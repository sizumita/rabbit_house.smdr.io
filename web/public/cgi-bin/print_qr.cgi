#!/bin/python3

import os
import subprocess

query_string = os.environ["QUERY_STRING"]
queries_list = query_string.split('&')
queries = {}
for q in queries_list:
    t = q.split('=')
    queries[t[0]] = t[1]

url = queries["url"]

qrcode = subprocess.run(["qrencode", "-o", "-", url], capture_output=True)

if qrcode.returncode != 0:
    print("Status 400 Bad Request")
    print("")
    exit(0)

printing = subprocess.run(["lp", "-d", "akadox", "-o", "page-bottom=20", "-o", "page-top=20", "-o", "TopMargin=2Millimeter3"], input=qrcode.stdout)

if printing.returncode != 0:
    print("Status 400 Bad Request")
    print("")
    exit(0)

print("Status 200 Ok")
print("")
print(f"code: {printing.returncode}")
