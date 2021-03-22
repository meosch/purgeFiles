#! /usr/bin/env bash
# For testing. First line outputs line numbers.
# Second line says to output what is going on in script
PS4=':${LINENO}+'
#set -x

#### Quick script to reset the date and time on MEOS website backup files to the date and time in the filename. This is
# useful if the files get move to a new location, as the the backup purge script looks at these date and time stamps to
# determine which files to keep and which to purge.

directorytoprocess=$1

if [ -d "$directorytoprocess" ]; then

  for filetoprocess in $directorytoprocess/*.tar.gz; do
    # Parse date and time from filename and put in the correct format for touch.
    # Remove the folder, remove the file extension .tar.gz, print out the parts of the filename that we need,
    # add a decimal point between the minutes and seconds.
    touchformateddate=$(echo "$filetoprocess" | awk -F'/' '{print $2}' | awk -F'.tar' '{print $1}' | awk -F'-' '{print $2$3$4$7}' | sed 's/..$/.&/')
    touch -t $touchformateddate "$filetoprocess"
    echo "Date and time set on $filetoprocess."
  done
else
  echo "Sorry that is not a directory. Please give me a directory of backup files to set the date and time on."
fi