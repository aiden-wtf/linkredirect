#! /usr/bin/bash

# Made by AidenWTF - https://aiden.wtf
# Version 1.0
VERSION="v1.0"

# Config file that holds essential variables
CONFIG="/etc/linkredirect/config.sh"
CONFIGDIR="/etc/linkredirect/"
# Error messages
error1="Error #1 - You didn't input a valid website!"
error2="Error #2 - Your input was blank!"
error3="Error #3 - Your input included an illegal character!"
error4="Error #4 - That extension URL already exists!"
error5="Error #5 - Invalid input!"

# Runs starting checks and welcome messages
start() {
echo ""
echo "Welcome to LinkRedirect by AidenWTF!"
if ! [ -d "$CONFIGDIR" ]; then
 mkdir -p $CONFIGDIR
fi
if ! [ -f "$CONFIG" ]; then
 echo "This seems like your first start. Let me create the appropriate files..."
 firstStart
elif [ -f "$CONFIG" ]; then
 source $CONFIG
fi
if ! [ -f "${CONFIGDIR}link.db" ]; then
 echo "It seems your database file got deleted. Let me create a new one..."
 > $FILE
fi
}

# Ran on first start/absence of config file
firstStart() {
echo "---------------------------------------------------"
echo "Please enter the domain you'd like to use. (WITHOUT HTTPS/HTTP)"
read tmpone
if [ -n "$tmpone" ] && [[ "$tmpone" =~ ["."] ]] && [[ "$tmpone" == *["abcdefghijklmnopqrstuvwxyz"]* ]] && ! [[ "$tmpone" == *["!@#$%^&*()_+"] ]]; then
 echo "DOMAIN='$tmpone'" > $CONFIG
 echo ""
else 
 echo ""
 echo "$error1"
 echo ""
 firstStart
fi
if [ -d "/etc/nginx/conf.d/" ]; then
 echo 'NGINX="/etc/nginx/conf.d/linkredirect.conf"' >> $CONFIG
else
 echo "I couldn't locate your NGINX CONF.D directory. Please specify your CONF.D directory."
 read nginxtmp
 if [ -d $nginxtmp ] && [[ $nginxtmp == *["conf.d/"] ]]; then
  echo "NGINX='${nginxtmp}linkredirect.conf'" >> $CONFIG
  echo ""
 else
  echo "Error in path. Restarting first-start process. EX. /etc/nginx/conf.d/"
  firstStart
 fi
fi 
echo "Config changes all complete - domain, variables."
source $CONFIG
if [ -f "$FILE" ]; then
 alias
else 
 echo "Creating database file..."
 > ${CONFIGDIR}link.db
 alias
fi
}

# Creates command alias
alias() {
echo "---------------------------------------------------"
echo "Would you like to create an alias for this program? (ex. linkredirect INSTEAD of bash ...) [Y/N]"
read tmptwo
if [ "$tmptwo" = "Y" ] || [ "$tmptwo" = "y" ]; then
 if [ -f "~/.bash_aliases" ]; then
  echo "alias linkredirect='bash ~/linkredirect.sh'" >> ~/.bash_aliases
  . ~/.bashrc
 else
  echo "alias linkredirect='bash ~linkredirect.sh'" > ~/.bash_aliases
  . ~/.bashrc
 fi 
elif [ "$tmptwo" = "N" ] || [ "$tmptwo" = "n" ]; then
 echo ""
else
 echo ""
 echo "$error2"
 alias
fi 
}

# Asks for shortening input
shorten() {
echo "---------------------------------------------------"
echo "What URL would you like to shorten? (ex. https://google.com)"
read shortenURL
if [ -n "$shortenURL" ] && [[ "$shortenURL" =~ ["."] ]] && [[ "$shortenURL" == *["abcdefghijklmnopqrstuvwxyz"]* ]] && ! [[ "$shortenURL" == *["!@#$%^&*()_+"]* ]]; then
 extURL
else
 echo ""
 echo  "$error1"
fi
}

# Asks for URL extension input
extURL() {
echo ""
echo "What would you like the URL extension to be? (ex. example -> $DOMAIN/example)"
read extensionURL
if [ -n "$extensionURL" ] && ! [[ "$extensionURL" == *["!@#$%^&*()_+"]* ]] && ! grep -q $DOMAIN/$extensionURL ${CONFIGDIR}link.db; then
 correct
elif ! [ -n "$extensionURL" ]; then
 echo "" 
 echo "$error2"
elif [[ "$extensionURL" == *["!@#$%^&*()_+"]* ]]; then
 echo "" 
 echo "$error3"
else
 echo "" 
 echo "$error4"
fi
}

# Verifies selected data is correct
correct() {
echo ""
echo "Is this correct? $shortenURL -> $DOMAIN/$extensionURL [Y/N]"
read value
if [ "$value" = "Y" ] || [ "$value" = "y" ]; then
 writeList
elif [ "$value" = "N" ] || [ "$value" = "n" ]; then
 echo ""
 echo "Okay, let's restart then!"
 echo "---------------------------------------------------" 
 shorten
else
 echo ""
 echo "$error2"
 correct
fi
}

# Writes to Link DB specifided in FILE
writeList() {
echo ""
echo "Writing to DB..."
echo "$shortenURL -> $DOMAIN/$extensionURL" >> ${CONFIGDIR}link.db
nginxCreate
}

# Creating (if needed) NGINX Conf and actual redirect
nginxCreate() {
if ! [ -f "$NGINX" ]; then
 nginxConfig
fi
if ! [ -d "${CONFIGDIR}/links/" ]; then
 mkdir -p ${CONFIGDIR}/links/
fi
echo "Adding link file to ${CONFIGDIR}links/${extensionURL}.html"
echo "<html>" > ${CONFIGDIR}links/${extensionURL}.html
echo "<meta http-equiv=\"Refresh\" content=\"0; url='$shortenURL'\" />" >> ${CONFIGDIR}links/${extensionURL}.html
echo "</html>" >> ${CONFIGDIR}links/${extensionURL}.html
echo "----------------------------------------------------"
echo "You can now access the link at http://${DOMAIN}/${extensionURL}"
}

# Lists URLs
listURL() {
echo ""
echo "LONG URL                 SHORT URL"
echo "----------------------------------"
cat ${CONFIGDIR}link.db
echo ""
}

# Deletes URLs
deleteURL() {
echo "---------------------------------------------------"
echo "To delete a URL, please enter the extension. (ex. A in johndoe.com/a)"
echo "If you need a list of current URLs, please enter list or use the list command."
read deletetmp
echo ""
if [ $deletetmp == "list" ]; then
 listURL
 deleteURL
elif [ -f "${CONFIGDIR}links/${deletetmp}.html" ]; then
 rm ${CONFIGDIR}links/${deletetmp}.html
 grep -v link.aiden.wtf/${deletetmp} ${CONFIGDIR}link.db > ${CONFIGDIR}link.tmp; mv ${CONFIGDIR}link.tmp ${CONFIGDIR}link.db
 echo "${deletetmp} was successfully deleted."
else
 echo "$error5"
 echo ""
fi
}

# Help system
help() {
echo "---------------------------------------------------"
echo "Help System - $VERSION"
echo ""
echo "The in-progam Help System is currently a WIP. Please refer to GitHub for any support issues."
}

# Settings Menu
settings() {
echo "---------------------------------------------------"
echo "Settings Menu - $VERSION"
echo ""
echo "1) Create Alias"
echo ""
echo "2) Create 404 Redirect"
echo ""
echo "3) Create Index Redirect"
echo ""
echo "4) Reset..."
read settingstmp
if [ $settingstmp = "1" ]; then
 alias
elif [ $settingstmp = "2" ]; then
 fourofour
elif [ $settingstmp = "3" ]; then
 index
elif [ $settingstmp = "4" ]; then
 reset
else
 echo $error5
fi
}

# Creates config file for nginx if necessary
nginxConfig() {
echo "Creating config file for NGINX..."
echo "server {" > $NGINX
echo "  listen 80;" >> $NGINX
echo "  root ${CONFIGDIR}/links/;" >> $NGINX
echo "  index index.html;" >> $NGINX
echo "  server_name $DOMAIN;" >> $NGINX
echo "  error_page 404 =200 /404.html;" >> $NGINX
echo "" >> $NGINX
echo "  location / {" >> $NGINX
echo '     if ($request_uri ~ ^/(.*)\.html) {' >> $NGINX
echo '      return 302 /$1;' >> $NGINX
echo "     }" >> $NGINX
echo '     try_files $uri $uri.html $uri/ =404;' >> $NGINX
echo "  }" >> $NGINX
echo "}" >> $NGINX
systemctl reload nginx
}

# Creates 404 Redirect
fourofour() {
echo ""
echo "Please enter the URL you would like to redirect to from a 404 error."
echo "If you're unsure what a 404 is, it is when a requested file/url is not present on the server."
read fourtmp
if [ -n "$fourtmp" ] && [[ "$fourtmp" =~ ["."] ]] && [[ "$fourtmp" == *["abcdefghijklmnopqrstuvwxyz"]* ]] && ! [[ "$fourtmp" == *["!@#$%^&*()_+"]* ]]; then
 if ! [ -f "$NGINX" ]; then
  nginxConfig
fi
if ! [ -d "${CONFIGDIR}/links/" ]; then
 mkdir -p ${CONFIGDIR}/links/
fi
echo "Adding link file to ${CONFIGDIR}links/404.html"
echo "<html>" > ${CONFIGDIR}links/404.html
echo "<meta http-equiv=\"Refresh\" content=\"0; url='$fourtmp'\" />" >> ${CONFIGDIR}links/404.html
echo "</html>" >> ${CONFIGDIR}links/404.html
else 
 echo "$error1"
fi
}

# Creates index/main page redirect
index() {
echo ""
echo "Please enter the URL you would like to redirect to from your base domain (${DOMAIN})."
read indextmp
if [ -n "$indextmp" ] && [[ "$indextmp" =~ ["."] ]] && [[ "$indextmp" == *["abcdefghijklmnopqrstuvwxyz"]* ]] && ! [[ "$indextmp" == *["!@#$%^&*()_+"]* ]]; then
 if ! [ -f "$NGINX" ]; then
  nginxConfig
fi
if ! [ -d "${CONFIGDIR}/links/" ]; then
 mkdir -p ${CONFIGDIR}/links/
fi
echo "Adding link file to ${CONFIGDIR}links/index.html"
echo "<html>" > ${CONFIGDIR}links/index.html
echo "<meta http-equiv=\"Refresh\" content=\"0; url='$indextmp'\" />" >> ${CONFIGDIR}links/index.html
echo "</html>" >> ${CONFIGDIR}links/index.html
else 
 echo "$error1"
fi
}

# Reset Options 
reset() {
echo "---------------------------------------------------"
echo "Reset Options - $VERSION"
echo ""
echo "1) Reset all options"
echo ""
echo "2) Reset all URLs"
echo ""
echo "3) Reset NGINX config file"
read resettmp
echo ""
if [ $resettmp = "1" ]; then
 rm -r ${CONFIGDIR}
 rm ${NGINX}
 echo "Successfully reset. Program will now act as a first start."
elif [ $resettmp = "2" ]; then
 rm -r ${CONFIGDIR}links
 rm ${CONFIGDIR}link.db
 echo "Successfully deleted all link files and the database file."
elif [ $resettmp = "3" ]; then
 rm ${NGINX}
 echo "Successfully deleted the NGINX config file."
else
 echo ""
 echo "$error5"
fi
}

# Menu system that is the default for any non-specialized input
menu() {
echo "---------------------------------------------------"
echo "Main Menu - $VERSION"
echo ""
echo "1) Shorten URL"
echo ""
echo "2) List URLs"
echo ""
echo "3) Delete URLs"
echo ""
echo "4) Help"
echo ""
echo "5) Settings"
echo ""
echo "6) Credits"
read menutmp
if [ $menutmp == "1" ]; then
 shorten
elif [ $menutmp == "2" ]; then
 listURL
elif [ $menutmp == "3" ]; then
 deleteURL
elif [ $menutmp == "4" ]; then
 help
elif [ $menutmp == "5" ]; then
 settings
elif [ $menutmp == "6" ]; then
 credits
else
 echo ""
 echo $error5
 menu
fi
}

# Command director/interperter
if [ "$1" == "new" ]; then 
 start
 shorten
elif [ "$1" == "delete" ]; then
 start
 deleteURL
elif [ "$1" == "list" ]; then
 start
 listURL
elif [ "$1" == "help" ]; then
 start
 help
elif [ "$1" == "settings" ]; then
 start
 settings
elif [ "$1" == "credits" ]; then
 start
 credits
elif [ "$1" == "reset" ]; then
 start
 reset
else
 start
 menu
fi

