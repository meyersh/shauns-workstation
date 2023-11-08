set -v
cp gettytab /etc/gettytab
cp serialconsole.plist /Library/LaunchDaemons/serialconsole.plist
launchctl stop serialconsole
launchctl unload -F /Library/LaunchDaemons/serialconsole.plist
launchctl load -F /Library/LaunchDaemons/serialconsole.plist
launchctl start serialconsole
