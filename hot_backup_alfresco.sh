#!/bin/bash
# This is a script that runs migration in Alfresco Content Service
#
# Copyright 2021 Lucy Zarbano
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.



## HOT BACKUP PROCEDURE
### ALFRESCO HOT BACKUP ###
# 1. Check if solr4Backup exists under dir.root
# 2. Backup solr4Backup
# 3. Backup Database
# 4. Backup the others dir.root directories (contentstore, contentstore.deleted)
# 5. Store database e dir.root directory toghether as a singole unit (opzionale)


###  SETTING LOG FILE ###
LOG_FILE=$(pwd)/logging.log

### LOAD FILE ###

# load file of properties
if [ -f ./alfresco_prop.properties ]; then
         . ./alfresco_prop.properties
else
        echo missing alfresco_prop.properties
fi


# load file of acs methods
if [ -f ./acs_functions.sh ]; then
         . ./acs_functions.sh
else
        echo missing ./acs_functions.sh
fi


# load file of postgresql methods
if [ -f ./postgresql_functions.sh ]; then
         . ./postgresql_functions.sh
else
        echo missing ./postgresql_functions.sh
fi

# load file of utility methods
if [ -f ./utility_functions.sh ]; then
         . ./utility_functions.sh
else
        echo missing ./utility_functions.sh
fi


# load file of data methods
if [ -f ./data_functions.sh ]; then
         . ./data_functions.sh
else
        echo missing ./data_functions.sh
fi



#0. configure directory backup 
configure_dir_backup 

# 1.Check if solr4Backup exists under dir.root
# 2.Backup solr4Backup
backup_indexes ${ALF_DIR_ROOT}

# 3.Backup Database
backup_database ${ALF_DIR_ROOT}

# 4.Backup the others dir.root directories (contentstore, contentstore.deleted)
backup_contentstore ${ALF_DIR_ROOT}
