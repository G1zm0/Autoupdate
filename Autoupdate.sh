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
PATH_TO_SCRIPTS_COUCHPOTATO=/var/packages/SickBeard/scripts
PATH_TO_HEADPHONES=/usr/local/var/headphones
PATH_TO_SCRIPTS_HEADPHONES=/var/packages/SickBeard/scripts
PATH_TO_SUBLIMINAL=/volume1/@appstore/subliminal

GIT_APP=$(which git)	                		# Find the git
PYTHON_APP=/usr/local/python26/bin/python		# python26 executable

# Step 1 update SickBeard

# Check if Sickbeard is installed correct
sickbeard_dir_check () {
    if [ $PATH_TO_SICKBEARD ]; then    
        if [ ! -d $PATH_TO_SICKBEARD ]; then
            echo "Sickbeard not installed or no Zebulon Package used!";
            echo "Skipping";
			break;
        fi
		echo "SickBeard is installed properly starting update";
    fi
}
#Update function

stop_sickbeard () {
	$PATH_TO_SCRIPTS_SICKBEARD/start-stop-status stop;
}

start_sickbeard () {
	$PATH_TO_SCRIPTS_SICKBEARD/start-stop-status start;
}

update_sickbeard () {
    #Start
	echo "* Starting Sickbeard update ...";
	
	sickbeard_dir_check
	stop_sickbeard
	
	# Manual update
    echo "* Updating  ..."
#    /bin/sh -c "$GIT_APP --git-dir=$PATH_TO_SICKBEARD pull" || exit 1
#	$GIT_APP clone git://github.com/G1zm0/Autoupdate.git $PATH_TO_SICKBEARD
	$PYTHON_APP /usr/local/var/sickbeard/SickBeard.py --forceupdate
	
	start_sickbeard
}
update_sickbeard;

# Step 2 update Couchpotato

# Check if Couchpotato is installed correct
cochpotato_dir_check () {
    if [ $PATH_TO_COUCHPOTATO ]; then    
        if [ ! -d $PATH_TO_COUCHPOTATO ]; then
            echo "Couchpotato not installed or no Zebulon Package used!";
            echo "Skipping";
			break;
        fi
		echo "Couchpotato is installed properly starting update";
    fi
}


stop_couchpotato () {
	$PATH_TO_SCRIPTS_COUCHPOTATO/start-stop-status stop;
}

start_couchpotato () {
	$PATH_TO_SCRIPTS_COUCHPOTATO/start-stop-status start;
}

#Update function
update_couchpotato () {
    #Start
	echo "* Starting Couchpotato update ...";
	
	couchpotato_dir_check
	stop_couchpotato
	
	# Manual update
    echo "* Updating Couchpotato ..."
    #/bin/sh -c "$GIT --git-dir=$PATH_TO_COUCHPOTATO/.git pull" || exit 1 /bin/sh -c ##"cd $APP_PATH && $GIT pull"
	$PYTHON_APP /usr/local/var/couchpotato/app/config/updater.py
	
	start_couchpotato
}

update_couchpotato

# Step 3 Updating Headphones

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