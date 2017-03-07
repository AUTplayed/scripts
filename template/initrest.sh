#!/bin/bash
path=$(pwd)/
list=$(npm list express)
if [[ $list == *"(empty)"* ]]
then
	npm install --save express
	echo "wra"
fi
if [ -z $1 ] 
then
	file="$path""index.js";
else
	file="$path"$1;
fi
if [ ! -f $path ]
then
	touch $file
	printf "//External Dependencies\nvar express = require('express');\nvar app = express();\n\n//Internal Dependencies\n\n//Declarations\n\napp.get('/',function(req,res){\n\tres.send('succ');\n});\n\napp.listen(process.env.PORT || 8080);" > $file
fi