#!/usr/bin/env python3

import csv
import requests
import pathlib

def row(emoji: str, name: str) -> str:
    return f"{emoji}\t{name}\n"

with open(pathlib.Path.home() / ".emoji", "w") as f:
    for (emoji, name) in [
        ("¯\_(ツ)_/¯", "shrug"),
        ("( ͡° ͜ʖ ͡°)", "lenny face"),
        ("(╯°□°)╯︵ ┻━┻", "flipping table"),
        ("┬─┬ノ( º _ ºノ)", "table down"),
        ("ಠ_ಠ", "disgusted"),
        ("(▀̿Ĺ̯▀̿ ̿)", "deal with it"),
        ("щ(ಥДಥщ)", "why?"),
        ("⁽⁽(੭ꐦ •̀Д•́ )੭*⁾⁾ ᑦᵒᔿᵉ ᵒᐢᵎᵎ", "come on"),
        ("๑•́ㅿ•̀๑) ᔆᵒʳʳᵞ", "sorry"),
        ("ヽ༼ ಠ益ಠ ༽ﾉ", "angry"),
        ("ᕕ( ᐛ )ᕗ", "strut"),
        ("ᶘ ᵒᴥᵒᶅ", "bear"),
        ("ᶘ ͡°ᴥ͡°ᶅ", "bear 2"),
        ("ᶘ ᵒ㉨ᵒᶅ", "panda"),
        ("ä", "ae"),
        ("ä", "a umlaut"),
        ("ö", "oe"),
        ("ö", "o umlaut"),
        ("ü", "ue"),
        ("ü", "u umlaut"),
        ("Ä", "Ae"),
        ("Ä", "A umlaut"),
        ("Ö", "Oe"),
        ("Ö", "O umlaut"),
        ("Ü", "Ue"),
        ("Ü", "U umlaut"),
        ("ß", "ss"),
        ("ß", "scharfes S")
    ]:
        f.write(row(emoji, name))
    emojis_url = "https://datahub.io/core/unicode-emojis/r/emojis.csv"    
    for r in csv.DictReader(requests.get(emojis_url).content.decode("utf-8").splitlines()):
        f.write(row(r['Representation'], r['Name']))


