#!/usr/bin/env python3

import csv
import requests
import pathlib

def format_row(diacritic: str, description: str) -> str:
    return f"{diacritic}\t{description}"

emojis_url = "https://datahub.io/core/unicode-emojis/r/emojis.csv"


with open(pathlib.Path.home() / ".emoji", "w") as f:
    for (diacritic, description) in [
        ("¯\_(ツ)_/¯", "shrug"),
        ("( ͡° ͜ʖ ͡°)", "lenny face"),
        ("(╯°□°)╯︵ ┻━┻", "flipping table"),
        ("≋≋≋≋≋̯̫⌧̯̫(ˆ•̮ ̮•ˆ)", "nyan cat"),
    ]:
        print(format_row(diacritic, description), file=f)

    for row in csv.DictReader(requests.get(emojis_url).content.decode("utf-8").splitlines()):
        print(format_row(row["Representation"], row["Name"]), file=f)

    for (diacritic, transliteration, description) in [
        ("ä", "ae", "a umlaut"),
        ("ö", "oe", "o umlaut"),
        ("ü", "ue", "u umlaut"),
        ("Ä", "Ae", "A umlaut"),
        ("Ö", "Oe", "O umlaut"),
        ("Ü", "Ue", "U umlaut"),
        ("ß", "ss", "scharfes S"),
    ]:
        print(format_row(diacritic, transliteration), file=f)
        print(format_row(diacritic, description), file=f)

