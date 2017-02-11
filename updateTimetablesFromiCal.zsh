#!/bin/zsh

# Get MPSMD2RES Lecture List, put into CSV,make Markdown table
includeEventProps="title, datetime, location, notes"
echo "Title,Room,Description,Date" > "$TEMPDIRECTORY/timetableLecture2res.csv"
icalBuddy \
	-nnr " " \
	-b "" \
	--includeEventProps $includeEventProps --dateFormat "%edayMonthSeparator%b" \
	--timeFormat "" \
	--includeCals CCCU \
	--propertySeparators "|,|" \
	eventsFrom:2016-09-20 to:2017:05:02 \
	| egrep 2RES \
	| sed "s/ (CCCU)//g" \
	| egrep "Lecture" \
	| sed "s/MPSMD2RES Lecture: //g" \
	| sed "s/location: //g" \
	| sed "s/notes: //g" \
	| sed "s/ Long description:.*,/,/" \
	| sed "s/ -//g" \
	| sed "s/dayMonthSeparator/\&nbsp;/" \
	>> "$TEMPDIRECTORY/timetableLecture2res.csv"

# Tidy it up:

cat "$TEMPDIRECTORY/timetableLecture2res.csv" | awk 'BEGIN { FS = "," }{print $1, "," $4, "," $2, "\\ \\ \\ \\ ," $3}' | sed "s/Room.*,/Room ,/" > "$TEMPDIRECTORY/timetableLecture2resColumnsReordered.csv" 

# Create the markdown table
csvtomd "$TEMPDIRECTORY/timetableLecture2resColumnsReordered.csv" > "$HOME/Dropbox/CCCU/text/deploy/includes/timetableLecture2res.markdown"

# -----------------------------------------------------------------------------------

# Get MPSMD2RES Seminar List, put into CSV, make Markdown table
includeEventProps="title, datetime, notes"
echo "Title,Description,Date" > "$TEMPDIRECTORY/timetableSeminar2res.csv"


icalBuddy \
	-nnr " " \
	-b "" \
	--timeFormat "" \
	--includeEventProps "title, datetime, notes" \
	--includeCals CCCU \
	--dateFormat "%edayMonthSeparator%b" \
	--propertySeparators "|@|" \
	eventsFrom:2016-09-20 to:2017:05:02 \
	| egrep 2RES \
	| egrep "GRP1:" \
	| sed "s/MPSMD2RES S GRP1: //g" \
	| sed "s/notes: //g" \
	| sed "s/ -//g" \
	| sed "s/dayMonthSeparator/\&nbsp;/" \
	| sed "s/ (CCCU)//g" \
	>> "$TEMPDIRECTORY/timetableWorkshop2res.csv"

# Create the markdown table
csvtomd -d "@" "$TEMPDIRECTORY/timetableWorkshop2res.csv" > "$HOME/Dropbox/CCCU/text/deploy/includes/timetableWorkshop2res.markdown"



# -----------------------------------------------------------------------------------

# Get deadlines for:
# 3ART, 3LAD
# 2RES
# 1BAM
