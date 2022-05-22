#!/usr/bin/python3
import requests
import json
import os
import subprocess

url = "http://localhost"
klipper_path = "/home/pi/klipper_config/"
klipper_scripts = klipper_path + "scripts/"

#Reloading UI configuration
default_json_file = klipper_path + ".theme/default.json"
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

#Reloading serial script
serial_out = subprocess.run([klipper_scripts + "get_serial.sh"], capture_output=True)
print(serial_out)

os.system("service moonraker restart")
