# LinkRedirect
> Server-side link redirect tool for UNIX systems utilizing NGINX. Made in bash, and only requires one script to setup. Web tool coming soon. 

## What is LinkRedirect?
LinkRedirect allows you to redirect from any URL in your custom domain to any URL on the web, utilizing just NGINX and Linux native functions. You are also able to setup a 404 redirect, and an index redirect. Super-easy setup and usage, made to be flexible. 

## Prerequisites 
- A system running Linux/UNIX-based OS <br>
- A system that supports Bash <br>
- NGINX

## Setup
1) Run the file by doing `bash linkredirect.sh` <br>
2) You should be presented with first-start steps. Follow them accordingly. <br>
    * **Domain** - please enter your (sub)domain without any prefix (ex. link.aiden.wtf **NOT** http://link.aiden.wtf)
    * **NGINX** - by default, if a directory is detected in /etc/nginx/conf.d/, then it will not prompt you. If nothing is found, it will ask you for the path.
    * **Alias** - if you want to access the program with the simple command `linkredirect`, then this is required, otherwise you will have to run with Bash.

> **NOTE:** if you want to move the Config directory from the default (/etc/linkredirect/), you have to edit the file and change the *CONFIGDIR* & *CONFIG* variables, located at the top of the file, then reset all settings for the change to take place.

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
The main purpose of this program is to allow you to quickly and efficiently shorten URLs. Here is a quick run-through of how to achieve that.

1) Use the `linkredirect new` command OR simply open the program with `linkredirect`, and input **1**.
2) Enter the URL you would like to **shorten** with the **http / https prefix** (ex. https://google.com/)
3) Enter the extension you would like to associate with this URL (ex. link.aiden.wtf/**example**)
4) Confirm that the URL change provided is correct with `Y`. If you select `N`, it will restart this process.
5) Go to the link you shorten and watch it redirect!

## Deleting a URL
Sometimes, it may be necessary to delete a URL you either made a mistake in or no longer need. This will show you different ways for efficient deletion.

1) Use the `linkredirect delete` command OR open the program, and input **2**. If you would like to reset all URLS, refer to the Reset area.
2) Input `list` for a list of all URLs, and or/then input the EXTENSION (the **example** in link.aiden.wtf/**example**).
3) If that URL is identified it will delete it! The redirect will no longer work.

## Reset Options
There are multiple reset options available by default in LinkRedirect, for troubleshooting, or if you just need a fresh start.

1) Use the `linkredirect reset` command OR open the program, and input **4**.
2) You should now be presented with a menu, each option on the menu achieves a different result.   
   * The *Reset all URLs* option will delete all URLs and reset the database file. This database file will regenerate after next-load.
