#!/bin/bash

# نصب XRay
wget https://github.com/XTLS/Xray-core/releases/download/v25.3.6/Xray-linux-64.zip
mv xray /usr/local/bin/
chmod +x /usr/local/bin/xray

# نصب systemd service
cat <<EOL > /etc/systemd/system/xray.service
[Unit]
Description=XRay
After=network.target

[Service]
ExecStart=/usr/local/bin/xray -config /etc/xray/config.json
Restart=on-failure
User=nobody
Group=nogroup
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOL

# فعالسازی و راه اندازی XRay
systemctl enable xray
systemctl start xray
