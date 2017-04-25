#!/bin/bash
configpath=$1
if [ -z $2 ] 
then
	printf "Usage: xconfig.sh <config path> <output config name> \n"
	printf "Config path layout: \n"
	printf "<server_name> <port>\n"
	printf "<server_name> <port>\n"
	exit 1
fi
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi
readarray config < $configpath
final=""
for configline in "${config[@]}"
do
	IFS=' ' read -r -a args <<< "$configline"
	out=$(printf "server {\n\tlisten 80;\n\tserver_name %s;\n\tlocation / {\n\t\tproxy_pass http://localhost:%s;\n\t}\n\t%s\n}" "${args[0]}" "${args[1]}" "${args[2]}")
	final=$(printf "%s\n\n%s" "$final" "$out")
done
printf "$final" > "/etc/nginx/sites-available/""$2"
ln -sf "/etc/nginx/sites-available/""$2" "/etc/nginx/sites-enabled/""$2"
service nginx reload
