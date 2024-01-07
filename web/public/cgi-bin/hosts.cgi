#!/bin/python3

import csv
import json

ip_list = []

with open("/var/gsnet/hosts.csv", "r") as f:
    reader = csv.reader(f)
    for row in reader:
        ip_list.append({
            "ip": row[0],
            "up": True if row[1] == "1" else False
        })

print("Content-Type: application/json")
print('')
print(json.dumps(ip_list))
