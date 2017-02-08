#!/bin/bash
basepath="/home/philipp/scripts/"
jarpath="$basepath""vpnme.jar"
pwpath="$basepath""pw.vpnme"
configpath="$basepath""vpnmeconfigtmp"
configzippath="$basepath""config.zip"
if [ -f $pwpath ]
then
	rm $pwpath
fi
wget -O $configzippath https://www.vpnme.me/dl/vpnme_fr_tcp443.zip
unzip $configzippath -d $configpath
rm $configzippath
status="fr-open\n"$(java -jar $jarpath)
printf $status > $pwpath
sudo openvpn --config $configpath/vpnme_fr_tcp443.ovpn --auth-user-pass $pwpath
rm $pwpath
rm -R $configpath