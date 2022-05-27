#!/usr/bin/python3
import sys, requests, json, os, subprocess, configparser, time
from pathlib import Path

if len(sys.argv) > 1 and sys.argv[1] == "--first-boot":
    time.sleep(5)

url = "http://localhost"
home_path = Path(__file__).parent.resolve().parent.parent
klipper_path = home_path / "klipper"
moonraker_path = home_path / "moonraker"

klipper_config_path = home_path / "klipper_config"
klipper_config_scripts = klipper_config_path / "scripts"
master_config_path = klipper_config_path / ".master.cfg"

#Reloading serial script, Import script directly to run it.
if (klipper_config_scripts / "setup_printer.py").is_file():
    sys.path.append(str(klipper_config_scripts))
    import setup_printer
    setup_printer.main()
else:
    print("Could not locate setup_printer.py in {}!".format(klipper_config_path))

#Reloading UI configuration
default_json_file = klipper_config_path / ".theme/default.json"
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

master_config = configparser.ConfigParser(inline_comment_prefixes="#")
master_config.read(str(master_config_path))
printer_config = master_config["re3D"]

branch = printer_config.get("branch", "stable")

#Manage Moonraker, Klipper, virtual_keyboard version, based on klipper_config hashes
#Fetch update manager status endpoint /machine/update/status?refresh=true

#pull in klipper_config master.cfg, see if branch is on stable or develop, 
# check out Moonraker, Klipper, klipper_config develop branches if set to develop

os.system("service moonraker restart")
