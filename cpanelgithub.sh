#!/bin/bash

: '
usage :

bash cpanelgithub.sh \
--serveraddress=http://<ip>:2082 \
--username=<YOUR-CPANEL_USERNAME> \
--password=<YOUR-CPANEL_PASSWORD> \
--repo=<YOUR-CLONED-REPO-ON-YOUR-HOST> \
--branch=<BRANCH>


exmple

bash cpanelgithub.sh \
--serveraddress=http://85.45.23.31:2082 \
--username=vladimir \
--password=1234 \
--repo=/home/vladimir/public_html/myrepo \
--branch=master


NOTE : 
your cpanel must have "Git™ Version Control" and you must add your repo to it then you can use this bash
and you can use --repo=/home/vladimir/public_html if you added on your Git™ Version Control
'

for i in "$@"
do
case $i in
    --username=*|--prefix=*)
    username="${i#*=}"

    ;;
    --serveraddress=*|--searchpath=*)
    serveraddress="${i#*=}"
    ;;
    --password=*|--lib=*)
    password="${i#*=}"
    ;;
    --repo=*|--lib=*)
    repo="${i#*=}"
    ;;
    
    --branch=*|--lib=*)
    branch="${i#*=}"
    ;;

    *)

    ;;
esac
done


useragent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36"


string=$(
 		 curl  -s -i $serveraddress'/login/?login_only=1' \
		-H 'Referer: '$serveraddress'/logout/?locale=en' \
		-H 'User-Agent: '$useragent \
		-H 'Content-type: application/x-www-form-urlencoded' \
		--data-raw $'user='$username'&pass='$password   
       )

       
cpsession=$(expr "$string" : '.*Set-Cookie: cpsession='$username'\(.*\); HttpOnly; path=/; port=2082')
securitytoken=$(expr "$string" : '.*"security_token":"/cpsess\([0-9]*\)"')




repo=${repo//\//%2F}

curl -s \
$serveraddress"/cpsess$securitytoken/execute/VersionControl/update" \
-H 'Connection: keep-alive' \
-H 'Accept: */*' \
-H 'X-Requested-With: XMLHttpRequest' \
-H 'User-Agent: '$useragent  \
-H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
-H 'Origin: '$serveraddress \
-H 'Referer: '$serveraddress \
-H 'Accept-Language: en-US,en;q=0.9' \
-H "Cookie: session_locale=en; timezone=Asia/Tehran; cpsession=$username$cpsession" \
--data-raw 'repository_root='$repo'&branch='$branch



