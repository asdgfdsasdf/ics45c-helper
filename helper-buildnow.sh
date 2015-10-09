if [ -e auto.config -a $(cat auto.config) ]; then
	xfce4-terminal --hold --title="ICS 45C helper buildnow" --hide-menubar -x bash -c "
	echo 'Copyright © 2015 Yiteng Zhang. All rights reserved.
	'
	./projects/$(cat auto.config)/build
	./projects/$(cat auto.config)/run"
else 
	zenity --info --title="ICS 45C helper buildnow" --text="
Make sure to create or choose a project 
using 'helper.sh' before using 'buildnow'."
fi