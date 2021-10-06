#!/usr/bin/env python3
import argparse
import json
import os
from scholarly import scholarly

parser = argparse.ArgumentParser()

parser.add_argument("--author", type=str, default="Federico Andrea Galatolo")
parser.add_argument("--output-file", type=str, default="{HOME}/.cache/scholar.json")

args = parser.parse_args()

search_query = scholarly.search_author(args.author)
author = scholarly.fill(next(search_query))

json.dump(author, open(args.output_file.format(**os.environ), "w"))
