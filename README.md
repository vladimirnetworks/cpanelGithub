# cpanelGithub
a simple bash for auto update github repository on cpanel 


# usage :
```
bash cpanelgithub.sh \
--serveraddress=http://<ip>:2082 \
--username=<YOUR-CPANEL_USERNAME> \
--password=<YOUR-CPANEL_PASSWORD> \
--repo=<YOUR-CLONED-REPO-ON-YOUR-HOST> \
--branch=<BRANCH>
```

# example
```
bash cpanelgithub.sh \
--serveraddress=http://85.45.23.31:2082 \
--username=vladimir \
--password=1234 \
--repo=/home/vladimir/public_html/myrepo \
--branch=master
```

NOTE : 
your cpanel must have "Git™ Version Control" and you must add your repo to it then you can use this bash
and you can use --repo=/home/vladimir/public_html (for main public website) if you added on your Git™ Version Control
