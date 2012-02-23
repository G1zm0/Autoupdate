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
PYTHON26_APP=/usr/local/python26/bin/python		# python26 executable

# Step 1 update SickBeard

#Stop function
stop_sickbeard () {
	$PATH_TO_SCRIPTS_SICKBEARD/start-stop-status stop;
	}
# Start function
start_sickbeard () {
	$PATH_TO_SCRIPTS_SICKBEARD/start-stop-status start;
	}

# Update function
update_sickbeard () {
    #Start
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

	cd $PATH_TO_SICKBEARD && $GIT_APP clone https://github.com/midgetspy/Sick-Beard.git $PATH_TO_SICKBEARD

	# To save space remove the .git folder
	rm $PATH_TO_SICKBEARD/.git
	
	start_sickbeard
}
update_sickbeard;

# Step 2 update Couchpotato

# Stop function for couchpotato
stop_couchpotato () {
	$PATH_TO_SCRIPTS_COUCHPOTATO/start-stop-status stop;
}

# Start punction for couchpotato
start_couchpotato () {
	$PATH_TO_SCRIPTS_COUCHPOTATO/start-stop-status start;
}

#Update function
update_couchpotato () {
    # Start
	# Check if Sickbeard is installed correct
	echo "* Starting Sickbeard update ...";
	
	if [ ! -d $PATH_TO_COUCHPOTATO ]; then {
        echo "Couchpotato not installed or no Zebulon Package used!";
        echo "Skipping";
		break;
		}
    else
	echo "Couchpotato is installed properly starting update";
    fi

	stop_couchpotato
	
	# Start update
    echo "* Updating  ..."

	cd $PATH_TO_COUCHPOTATO && $GIT_APP clone https://github.com/RuudBurger/CouchPotato.git $PATH_TO_COUCHPOTATO
	
	# To save space remove the .git folder
	rm $PATH_TO_COUCHPOTATO/.git
	
	start_couchpotato
}

update_couchpotato

# Step 3 Updating headphones

# Stop function for headphones
stop_headphones () {
	$PATH_TO_SCRIPTS_HEADPHONES/start-stop-status stop;
}

# Start punction for headphones
start_headphones () {
	$PATH_TO_SCRIPTS_HEADPHONES/start-stop-status start;
}

#Update function
update_headphones () {
    # Start
	# Check if Headphones is installed correct
	echo "* Starting Headphones update ...";
	
	if [ ! -d $PATH_TO_HEADPHONES ]; then {
        echo "Headphones not installed or no Zebulon Package used!";
        echo "Skipping";
		break;
		}
    else
	echo "Headphones is installed properly starting update";
    fi

	stop_headphones
	
	# Start update
    echo "* Updating  ..."

	cd $PATH_TO_HEADPHONES && $GIT_APP clone https://github.com/rembo10/headphones.git $PATH_TO_HEADPHONES
	
	# To save space remove the .git folder
	rm $PATH_TO_HEADPHONES/.git
	
	start_headphones
}
# Step 4 Updating subliminal
#cd $PATH_TO_SUBLIMINAL


#TMP_FILE="/tmp/.subliminal-upgrade";    # Tmp file variable

#echo "======================"
#echo -n `date +%Y-%m-%d\ %H:%M`;
#echo ": Updating Subliminal";
#echo "";

# Eerst testen of het proces nog niet draait.
# Dit doe ik aan de hand van het bestaan van een tempfile.
#if [ -f $TMP_FILE ]
#    then
#        echo "Er draait al een update, dus niet nog een starten."
#        # Stoppen met verdere update aangezien de file al aanwezig is.
#        exit
#fi

# Tempfile aanmaken aangezien de update nog niet draait
#touch $TMP_FILE
#wait;

#if $GIT_APP --git-dir="${PATH_TO_SUBLIMINAL}/.git" pull | grep 'files changed';
#    then
#        echo "Update downloaded"
#        echo "Installing new Subliminal version"
#        echo ""
#        $PYTHON_APP ${PATH_TO_SUBLIMINAL}/setup.py install
#        echo ""
#        wait
#        # Tempfile weer opruimen, anders wordt er maar eenmalig ge-update.
#        rm $TMP_FILE
#        echo "Finished!"
#    else
#        rm $TMP_FILE
#        echo "No update available"
#fi
#
#echo ""
#echo -n `date +%Y-%m-%d\ %H:%M`;
#echo ": Updating ended";
#echo "======================";