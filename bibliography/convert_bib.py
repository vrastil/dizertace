#!/usr/bin/env python3
import sys

MONTH_ALIAS = ["month = ", "month="]
MONTH_NAMES = {
    "jan": 1,
    "feb": 2,
    "mar": 3,
    "apr": 4,
    "may": 5,
    "jun": 6,
    "jul": 7,
    "aug": 8,
    "sep": 9,
    "oct": 10,
    "nov": 11,
    "dec": 12
}

def convert_month(line):
    month = line.lower().replace('"', "").replace(",", "")
    for month_alias in MONTH_ALIAS:
        month = month.replace(month_alias, "")
    month = month.replace("{","").replace("}", "").strip()

    try:
        # month is number
        month = int(month)
    except ValueError:
        # month is string
        month = MONTH_NAMES[month]

    return month

def convert_file(bib_file):
    # read file
    with open(bib_file, 'r', encoding="utf8") as a_file:
        data = a_file.readlines()

    # find month
    for i, line in enumerate(data):
        if any(month_alias in line.lower() for month_alias in MONTH_ALIAS):
            month = convert_month(line)
            new_line = f"\tmonth = {month},\n"
            print(f"\tline '{line.strip()}' converted to '{new_line.strip()}'")
            data[i] = new_line

    # write file
    with open(bib_file, 'w') as a_file:
        a_file.writelines(data)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        for bib_file in sys.argv[1:]:
            print(f"Processing file {bib_file}:")
            convert_file(bib_file)

