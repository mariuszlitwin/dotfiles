#!/usr/bin/env python3

import csv
import requests
import pathlib

emojis_url = "https://datahub.io/core/unicode-emojis/r/emojis.csv"
with open(pathlib.Path.home() / ".emoji", "w") as f:
    for row in csv.DictReader(requests.get(emojis_url).content.decode("utf-8").splitlines()):
        print(f"{row['Representation']}\t{row['Name']}", file=f)

