#!/usr/bin/env perl

use 5.22.1;
use warnings;
use strict;

use File::Path;
use File::Basename;
use Parse::CPAN::Meta;

sub flatten {
  my $hash = shift;
  my $prefix = shift // '';
  my %flathash;

  # add some dynamic entries to flathash
  $flathash{'system.dotfilespath'} = "$::scriptdir";
  $flathash{'system.utilspath'} = "$::scriptdir/build/run-on-demand";

  foreach (keys %{$hash}) {
    my @cprefix = grep(length, ($prefix, $_));

    if (ref($hash->{$_}) eq "HASH") {
      %flathash = (%flathash, flatten($hash->{$_}, $_));
    } elsif (ref($hash->{$_}) eq "ARRAY") {
      while (my ($i, $v) = each(@{$hash->{$_}})) {
        $flathash{join('.', (@cprefix, $i))} = $v;
      }
    } else {
      $flathash{join('.', @cprefix)} = $hash->{$_};
    }
  }

  return %flathash;
}

sub template {
  my ($text, $vars) = @_;

  foreach (keys %{$vars}) {
    my $find = quotemeta "<% $_ %>";
    my $replace = $vars->{$_};
    $text =~ s/$find/$replace/g
  }
  return $text;
}

sub dirwalk {
  my $dirname = shift;
  my $callback = shift;
  my $skiphidden = shift // 0;

  opendir(my $dh, $dirname) or die "[ERROR] Can't open $dirname: $!";
  foreach $_ (sort readdir $dh) {
    unless ($_ eq "." or $_ eq "..") {
      my $cpath = "$dirname/$_";
      if (-d $cpath) {
        print "[INFO] Going down to $cpath directory\n";
        $callback->($cpath);
        dirwalk($cpath, $callback); 
      } else {
        unless ($skiphidden and substr($_, 0, 1) eq '.') {
          print "[INFO] Processing $cpath file\n";
          $callback->($cpath);
        }
      }
    }
  }
  closedir $dh;
}

sub build {
  my ($flatconfig, $tdir, $bdir, $path) = @_;

  if (-d $path) {
    $path =~ s/$tdir/$bdir/;
    mkdir $path or die("[ERROR] Failed to create directory $path: $!");
  } else {
    open(my $ifh, "<:encoding(UTF-8)", $path)
      or die("[ERROR] Failed to open file $path: $!");

    $path =~ s/$tdir/$bdir/;
    open(my $ofh, ">:encoding(UTF-8)", $path)
      or die ("[ERROR] Failed to open file $path: $!");

    print $ofh map { template($_, $flatconfig) } <$ifh>;
    close($ifh) or warn("[WARNING] Failed to close file $path: $!");
    close($ofh) or warn("[WARNING] Failed to close file $path, $!");
  }
}

sub buildconf {
  my ($flatconfig, $tdir, $bdir) = @_;
  return sub {
    build($flatconfig, $tdir, $bdir, $_[0]);
  }
}

sub runinit {
  my $path = $_[0];
  print "[INFO] Running $path\n";
  system("bash", $path);
}

our $filepath   = $ARGV[0];
our $scriptdir  = dirname($0);
our $configpath = "$scriptdir/config.json";
our $config     = Parse::CPAN::Meta->load_file($configpath);
our %flatconfig = flatten($config);

my $mode = shift @ARGV // '';

if ($mode eq 'init') {
  print chr(7);
  print "[PHASE] Configuring OS\n";
  dirwalk("$scriptdir/init", \&runinit, 1);
}
print "[PHASE] Building dotfiles\n";
rmtree("$scriptdir/build");
mkdir("$scriptdir/build");
dirwalk("$scriptdir/template", buildconf(\%flatconfig, 'template', 'build'));
print "[PHASE] Running scripts in run-on-rebuild directory.\n";
dirwalk("$scriptdir/build/run-on-rebuild", \&runinit, 1);
print "[PHASE] Build finished. Now you can stow your things out.\n";
