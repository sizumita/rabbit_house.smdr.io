#!/bin/python3

import os
import csv
import traceback

try:
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

    if queries["ip"] not in ip_list:
        print("Status 302 Found")
        print(f"Location: http://{queries['ip']}")
        print("")
    else:
        target = queries["ip"]
        i = ip_list.index(queries["ip"])
        if to == "before":
            target = ip_list[i - 1]
        elif to == "after":
            target = ip_list[i + 1]
        elif to == "before2":
            target = ip_list[i - 2]
        elif to == "after2":
            target = ip_list[i + 2]
        else:
            target = queries["ip"]

        print("Status 302 Found")
        print(f"Location: http://{target}")
        print("")
except Exception as e:
    ps = "\n".join([f"<p>{i}</p>" for i in traceback.format_exc().split("\n")])
    htmlText = f'''
    <!DOCTYPE html>
    <html>
        <head><meta charset="utf-8" /></head>
    <body>
        {ps}
    </body>
    </html>
    '''
    print("Content-Type: text/html")
    print('')
    print(htmlText)
