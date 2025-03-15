import os
import json
from config import XRAY_CONFIG_PATH

class XRayManager:
    def __init__(self):
        self.config_path = XRAY_CONFIG_PATH

    def load_config(self):
        with open(self.config_path, "r") as file:
            return json.load(file)

    def save_config(self, config):
        with open(self.config_path, "w") as file:
            json.dump(config, file, indent=4)

    def restart_xray(self):
        os.system("systemctl restart xray")

# تست
if __name__ == "__main__":
    manager = XRayManager()
    config = manager.load_config()
    print(config)