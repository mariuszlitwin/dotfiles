#!/usr/bin/env python3

import os
import re
import argparse
import json
import logging
import pathlib
import itertools

import shutil

from typing import Any, Text, Union, Mapping


class AttrDict(dict):
    def __getattr__(self, key: Text) -> Any:
        return self[key]

    def __init__(self, map: Mapping[Text, Any], **kwargs: Any):
        super(AttrDict, self).__init__(
            {
                k: AttrDict(v) if type(v) == dict else v
                for k, v in itertools.chain(map.items(), kwargs.items())
            }
        )


_format_pattern = re.compile(r"<%\s*([A-Za-z_][a-zA-Z_\.0-9]*)\s*%>")


def format(content: Text, config: dict) -> Text:
    for old, new in [("{", "{{"), ("}", "}}")]:
        content = content.replace(old, new)
    content = _format_pattern.sub(r"{cfg.\1}", content)
    return content.format(cfg=config)


def run(path: pathlib.Path):
    logging.info(f"running {path}")
    os.system(f"bash {path}")


def run_all(path: pathlib.Path):
    if not (path.exists() and path.is_dir()):
        return
    for p in path.iterdir():
        if p.is_file():
            run(p)


def make(f: pathlib.Path, t: pathlib.Path, config: dict):
    if f.is_file():
        logging.info(f"processing { f } file")
        with open(f, "r") as ifh, open(t, "w") as ofh:
            ofh.write(format(ifh.read(), config))
    else:
        for path in f.iterdir():
            if path.is_dir():
                logging.info(f"going down to { f / path.name } directory")
                (t / path.name).mkdir()
            make(f / path.name, t / path.name, config)


if __name__ == "__main__":
    logging.root.setLevel(logging.INFO)

    script_dir = pathlib.Path(os.path.realpath(__file__)).parent

    parser = argparse.ArgumentParser(description="Rebuild dotfiles")
    parser.add_argument(
        "-i",
        "--init",
        action="store_true",
        default=False,
        help="if present, scripts from init directory will be run",
    )
    parser.add_argument(
        "-c",
        "--config",
        type=pathlib.Path,
        default=script_dir / "config.json",
        help="JSON file with all parameters used in templates",
    )
    parser.add_argument(
        "-t",
        "--template",
        type=pathlib.Path,
        default=script_dir / "template",
        help="directory with templates",
    )
    parser.add_argument(
        "-b",
        "--build",
        type=pathlib.Path,
        default=script_dir / "build",
        help="directory where rebuild resuls will be stored",
    )

    args = parser.parse_args()
    with open(args.config, encoding="UTF-8") as fh:
        config = AttrDict(json.load(fh))

    config["system"] = config.get("system", dict())
    config["system"]["utils_path"] = config["system"].get(
        "utils_path", args.build / "run-on-demand"
    )
    config["system"]["dotfiles_path"] = config["system"].get(
        "dotfiles_path", args.template.parent
    )

    if args.init:
        run_all(script_dir / "init")

    try:
        shutil.rmtree(args.build)
    except FileNotFoundError:
        pass
    os.mkdir(args.build)
    logging.info("building dotfiles")
    make(args.template, args.build, config)

    run_all(args.build / "run-on-rebuild")
