#!/usr/bin/python3
import requests
import json
import os
import pathlib

url = "http://localhost"
default_json_file = "/home/pi/klipper_config/.theme/default.json"
with open(default_json_file) as f:
    defaults = json.load(f)
namespaces = [name for name in defaults]

for name in namespaces:
    default_value = defaults[name]
    print("{} Namespace Default: {}".format(name, default_value))
    print("--- DELETING {} NAMESPACE ---".format(name))
    delete_url = url+"/server/database/item?namespace=mainsail&key="+name
    delete_response = requests.delete(delete_url)
    print(delete_response.text)

    print("--- POSTING NEW DEFAULT INTO {} NAMESPACE ---".format(name))
    post_url = url+"/server/database/item"
    body = {"namespace": "mainsail", "key": name, "value": defaults[name]}
    post_response = requests.post(post_url, json=body)
    print(post_response.text)

os.system("service moonraker restart")
