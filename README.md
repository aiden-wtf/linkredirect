# LinkRedirect
Server-side link redirect tool for UNIX systems utilizing NGINX. Made in bash, and only requires one script to setup. Web tool coming soon. My first

## Features:
LinkRedirect allows you to redirect from any URL in your custom domain to any URL on the web, utilizing just NGINX and Linux native functions. You are also able to setup a 404 redirect, and an index redirect. Super-easy setup and usage, made to be flexible. 

## Prerequisites: 
- A system running Linux/UNIX-based OS <br>
- A system that supports Bash <br>
- NGINX

## Setup: 
1) Run the file by doing `bash linkredirect.sh` <br>
2) You should be presented with first-start steps. Follow them accordingly. <br>
    * **Domain** - please enter your (sub)domain without any prefix (ex. link.aiden.wtf **NOT** http://link.aiden.wtf)
    * **NGINX** - by default, if a directory is detected in /etc/nginx/conf.d/, then it will not prompt you. If nothing is found, it will ask you for the path.
    * **Alias** - if you want to access the program with the simple command `linkredirect`, then this is required, otherwise you will have to run with Bash.

> NOTE: if you want to move the Config directory from the default (/etc/linkredirect/), you have to edit the file and change the **CONFIGDIR** & **CONFIG** variables, located at the top of the file, then reset all settings for the change to take place.

# Usage
The functions, commands and capabilities of LinkRedirect. 

## Commands

These commands can be used to quickly select a process.
Commands|Usage
--------|----
linkredirect | directs to main menu
linkredirect new | starts URL shorterning process
linkredirect delete | starts URL deletion process
linkredirect list | lists all created URLs
linkredirect reset | directs to reset options

### Shortening a URL
