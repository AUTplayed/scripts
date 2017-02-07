#!/bin/bash
if [ -f pw.vpnme ]
then
	rm pw.vpnme
fi
wget -O config.zip https://www.vpnme.me/dl/vpnme_fr_tcp443.zip
unzip config.zip -d vpnmeconfigtmp
rm config.zip
status="fr-open\n"$(java -jar vpnme.jar)
printf $status > pw.vpnme
sudo openvpn --config vpnmeconfigtmp/vpnme_fr_tcp443.ovpn --auth-user-pass pw.vpnme
rm pw.vpnme
rm -R vpnmeconfigtmp