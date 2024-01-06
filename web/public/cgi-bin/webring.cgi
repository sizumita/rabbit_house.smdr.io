#!/bin/python3

import os
import csv

query_string = os.environ["QUERY_STRING"]
queries_list = query_string.split('&')
queries = {}
for q in queries_list:
    t = q.split('=')
    queries[t[0]] = t[1]


ip_list = []

with open("/var/gsnet/hosts.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        if row[1] == "1":
            ip_list.append(row[0])

to = queries["to"]
target = 0

for i, ip in enumerate(ip_list):
    if ip == queries["ip"]:
        if to == "before":
            target = i-1
        elif to == "after":
            target = i+1
        elif to == "before2":
            target = i-2
        elif to == "after2":
            target = i+2
        else:
            target = i
        break

print("Status 302 Found")
print(f"Location: http://{ip_list[target]}")
