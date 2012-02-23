#!/bin/sh
#------------------------------------------
# Autoupdate script Synology NAS with Zebulon packages 
#
#
# Author: K.Meun (Gizmo)
#
# Location: /volume1/@appstore/autoupdate
#
# Version:
#
# 2011-10-22:
# - Initial release
#
#------------------------------------------

PATH_TO_SICKBEARD=/usr/local/var/sickbeard
PATH_TO_SCRIPTS_SICKBEARD=/var/packages/SickBeard/scripts
PATH_TO_COUCHPOTATO=/usr/local/var/couchpotato
PATH_TO_SCRIPTS_COUCHPOTATO=/var/packages/CouchPotato/scripts
PATH_TO_HEADPHONES=/usr/local/var/headphones
PATH_TO_SCRIPTS_HEADPHONES=/var/packages/Headphones/scripts
PATH_TO_SUBLIMINAL=/volume1/@appstore/subliminal

GIT_APP=$(which git)	                		# Find the git
PYTHON_APP=/usr/local/python26/bin/python		# python26 executable

# Step 1 update SickBeard


stop_sickbeard () {
	$PATH_TO_SCRIPTS_SICKBEARD/start-stop-status stop;
}

start_sickbeard () {
	$PATH_TO_SCRIPTS_SICKBEARD/start-stop-status start;
}

update_sickbeard () {
    # Start
	# Check if Sickbeard is installed correct
	echo "* Starting Sickbeard update ...";
	
	    if [ ! -d $PATH_TO_SICKBEARD ]; then {
        echo "Sickbeard not installed or no Zebulon Package used!";
        echo "Skipping";
		break;
		}
    else
	echo "SickBeard is installed properly starting update";
    fi

	stop_sickbeard
	
	# Start update
    echo "* Updating  ..."


#	mkdir $PATH_TO_SICKBEARD/.git


	cd ~/test/ && $GIT_APP clone https://github.com/midgetspy/Sick-Beard.git ~/test

	rm -rf ~/test/.git
	
#	start_sickbeard
}
update_sickbeard;

