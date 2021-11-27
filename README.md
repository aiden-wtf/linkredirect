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
    * **Domain** - please enter your (sub)domain without any prefix (ex. link.aiden.wtf **NOT** http://link.aiden.wtf) <br> <img src ="https://i.aiden.wtf/1637809491.png" width="440" height="68"/> 
 
    * **NGINX** - by default, if a directory is detected in /etc/nginx/conf.d/, then it will not prompt you. If nothing is found, it will ask you for the path. *This path must end in "conf.d/" and, to properly work, all confs in that folder must be getting pulled by NGINX.* <br> <img src="https://i.aiden.wtf/1637810085.png" width="509" height="29"/>
     
    * **Alias** - if you want to access the program with the simple command `linkredirect`, then this is required, otherwise you will have to run with Bash. <br> <img src="https://i.aiden.wtf/1637809835.png" width="585" height="32"/>

> **NOTE:** if you want to move the Config directory from the default (/etc/linkredirect/), you have to edit the file and change the *CONFIGDIR* & *CONFIG* variables, located at the top of the file, then reset all settings for the change to take place.

# Usage
The functions, commands and capabilities of LinkRedirect. 

## Commands

These commands can be used to quickly select a process.
Commands|Usage
--------|----
linkredirect | directs to main menu
linkredirect new/shorten | starts URL shorterning process
linkredirect delete | starts URL deletion process
linkredirect list | lists all created URLs
linkredirect reset | directs to reset options
linkredirect settings | directs to the settings menu
linkredirect credits | directs to the credit prompt

### Shortening a URL
The main purpose of this program is to allow you to quickly and efficiently shorten URLs. Here is a quick run-through of how to achieve that.

1) Use the `linkredirect new` command OR simply open the program with `linkredirect`, and input **1**.
2) Enter the URL you would like to **shorten** with the **http / https prefix** (ex. https://google.com/)
3) Enter the extension you would like to associate with this URL (ex. link.aiden.wtf/**example**)
4) Confirm that the URL change provided is correct with `Y`. If you select `N`, it will restart this process.
5) Go to the link you shorten and watch it redirect!

### Deleting a URL
Sometimes, it may be necessary to delete a URL you either made a mistake in or no longer need. This will show you different ways for efficient deletion.

1) Use the `linkredirect delete` command OR open the program, and input **2**. If you would like to reset all URLS, refer to the Reset area.
2) Input `list` for a list of all URLs, and or/then input the EXTENSION (the **example** in link.aiden.wtf/**example**).
3) If that URL is identified it will delete it! The redirect will no longer work.

### Reset Options
There are multiple reset options available by default in LinkRedirect, for troubleshooting, or if you just need a fresh start.

1) Use the `linkredirect reset` command OR open the program, and input **5**, and then input **4**.
2) You should now be presented with a menu, each option on the menu achieves a different result.   
   * The *Reset all URLs* option will delete all URLs and reset the database file. This database file will regenerate after next-load.
   * The *Reset all Options* option will delete all configuration files other then the base file. This will effectively make the program act as a "fresh start".
   * The *Reset NGINX Config File* option will delete the configuration file for NGINX. This file will be remade when you try to shorten a URL next.

### Settings Menu
There is a settings menu present for you to change some customizable options and make the program suit your needs.

1) Use the `linkredirect settings` command OR open the program, and input **5**.
2) You should then be prompted with the Settings menu.
   * The *Create Alias* option is identicial to the initial alias process prompted in the first start. This will simply create an alias for the program so you can access it with `linkredirect` commands instead of `bash linkredirect` commands.
   * The *Create 404 Redirect* option allows you to set a redirect for any request to your domain under a URL that does not have a valid redirect. (ex. you have not set a explicit redirect for example.com/test, so instead of showing an error, it redirects to the set 404 URL.)
   * The *Create Index Redirect* option allows you to set a redirect for the base domain you have set. (ex. selected domain is example.com, an index redirect would redirect to a URL from example.com)
   * The *Reset...* option redirects you to the aforementioned Reset Options menu. Please read above for further information.

## Updating
There may be a need to update the software. When a new update is released, you will get a notice everytime you startup the program. Since major bugs may be present, it is advised to update when given notice.

> **NOTE:** In order to push update messages, your device will request information from my API server. If this makes you uncomfortable, feel free to delete the code, present in the *start()* function. 

1) First, reset ALL options to ensure a smooth transition. Some configuration settings may be new, and in order to account for those changes you need to reset all options.
2) Then, download the new release onto your server, or copy and paste the code the new code (after deleting the old code) inside the `linkredirect.sh` file.
3) Start the file. You may have to re-undergo the setup process.
