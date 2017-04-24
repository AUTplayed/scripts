#!/bin/bash
basepath="/tmp/vpnme/"
jarpath="$basepath""vpnme.jar"
pwpath="$basepath""pw.vpnme"
configpath="$basepath""vpnmeconfigtmp"
configzippath="$basepath""config.zip"
jarurl="https://drive.google.com/uc?export=download&id=0Bw4F4s3cgDcwM1JMVl9zRmhaZEE"
configurl="https://www.vpnme.me/dl/vpnme_fr_tcp443.zip"

if [ ! -d $basepath ]
then
	mkdir $basepath
fi
if [ -f $pwpath ]
then
	rm $pwpath
fi
if [ ! -f $jarpath ]
then
	wget -O $jarpath $jarurl
fi
if [ ! -d $configpath ]
then
	wget -O $configzippath $configurl
	unzip $configzippath -d $configpath
	rm $configzippath
fi
status="fr-open\n"$(java -jar $jarpath)
printf $status > $pwpath
sudo openvpn --config $configpath/vpnme_fr_tcp443.ovpn --auth-user-pass $pwpath
rm $pwpath