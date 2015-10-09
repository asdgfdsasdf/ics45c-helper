#!/bin/bash
if [ -e auto.config -a $(cat auto.config) ]; then
	choice=$(zenity --list --title="ICS 45C helper" --height=240 --text="Current project is '$(cat auto.config)'" --column=Actions --hide-header Build_and_run Run Edit_main.cpp Open_app_folder "" Create_new_project Switch_to_project Refresh_ics45c "" About)
else
	choice=Create_new_project
fi
if [ $choice == Create_new_project -o $choice == Switch_to_project ]; then
	proj=$(zenity --entry --title='Create/switch_project' --text='Project name:')
	if [ $proj ]; then
		echo $proj > auto.config
		if [ -d ./projects/$proj ]; then 
			echo
		else
			temp=$(zenity --entry --title='Choose template' --text='Template to start with:')
			ics45c start_project $proj $temp
		fi
		subl ./projects/$proj/app/main.cpp
	fi
elif [ $choice == Edit_main.cpp ]; then
	subl ./projects/$(cat auto.config)/app/main.cpp
elif [ $choice == Open_app_folder ]; then
	xdg-open ./projects/$(cat auto.config)/app/
elif [ $choice == Build_and_run ]; then
	xfce4-terminal --hold -x bash -c "
	./projects/$(cat auto.config)/build
	./projects/$(cat auto.config)/run"
elif [ $choice == Run ]; then
	xfce4-terminal --hold -x bash -c "
	./projects/$(cat auto.config)/run"
elif [ $choice == Refresh_ics45c ]; then
	xfce4-terminal --hold --hide-menubar -x bash -c "ics45c refresh"
elif [ $choice == About ]; then

	zenity --info --title="ICS 45C helper" --text="
Ver 1.0

Contact me for any issues:
ics45chelper@icloud.com

Copyright © 2015 Yiteng Zhang. 
All rights reserved."

fi



