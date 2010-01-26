------------------------------------------------
MBWR Manager by Krom 0.5
------------------------------------------------

Description:
This tool installs and manages MBWR add-on cars 
and sceneries(tracks).

Key Features:
- Stores up to 5 selection sets of cars.
- Updates player profiles. You don`t need to 
  race any events to gain access to new cars or 
  tracks.
- Double-click on car in list launches its 
  editcar.car file using associated program.
- Add-on scenery installer :-)

Requirements:
- Manager must be run in MBWR folder.
- MBWR must be patched at least to version 
  1.4.4 or greater in order to accept add-on cars.
- Make a backup copy of Your "WR-EditCars" and 
  "WR-SavesSinglePM" folders and "FrontEnd\WR.ds" 
  and "FrontEnd\runtime.fxp" files, just in case.

Interface:
Save button - Applies and saves all changes.
MBWR button - Applies and saves all changes and 
	launches MBWR_Starter.exe
MBWR-MP button - Applies and saves all changes and 
	launches WR_Multiplayer_Lounge.exe
Edit MBWR Settings button - Launches MBWR 
	configuration utility.
Profiles To Alert - list of found player profiles. 
	Mark profiles You want to be updated
	with selected cars and sceneries(tracks).
Make Backup Copies - turns on/off autobackup 
	of alerted profile "career.wrc" and 
	"profile.wrp" files. Backup files are 
	timestamped. If needed, delete or restore 
	backup files manualy.
Car Manager tab:
  Add-on Cars (**/** Selected) - list of found 
	add-on cars. Mark cars You want to be 
	installed. If number of selected cars 
	exceeds On-Line Multi-Player limit then 
	indicator goes red.
  Quick Car Info - shows car class/model names,
	folder and race class of a car.
Track Manager tab:
  Add-on Sceneries (**/** Selected) - list of found 
	add-on sceneries. Mark sceneries You want 
	to be installed.
  Quick Tracks Info - shows tracks in scenery and
	their properties. Also contains info about
	scenery author/converter.
  Release Notes - press this button to view scenery
	release notes in separate window.
All - select all cars/sceneries in list.
None - select no cars/sceneries in list.
Revert - selects currently installed cars in list.
"<" - specify set name and save marked cars to it.
Set buttons (1-5) - load car selection from 
	an appropriate set.
Display Format - select from the offered formats
	one you prefer.
Sort cars/sceneries in list - turns on/off alpha-
	betical sorting of cars/sceneries in lists.
About - MBWR Manager version and my contact info.

CarManager does the following:
- Stores its preferencies, options and selection 
sets (5 so far) in "carman.ini" file which is plain 
text and can be edited in NotePad.
- Moves uninstalled cars from "..\WR-EditCars\" 
folder to "..\WR-EditCars\bak\" folder and moves 
installed cars from "..\WR-EditCars\bak\" folder 
back to "..\WR-EditCars\" folder. Same as 
Ortwin's Car Manager.
- Changes installed cars and tracks info in defined 
players profiles "career.wrc" and "profile.wrp" files.
- Changes installed sceneries and tracks info in MBWR
database "wr.ds" and "runtime.fxp" files.

Known Bugs:
Car list responds slow to clicks with many cars 
installed (150+).
All other bugs are unknown to me. If you find one
please tell me.

Version History:
v0.5  07.04.22	Fixed compatibility with password-protected cars.
v0.4f 05.12.14	Fixed bug, reading track/progile info with NT file system.
v0.4e 05.09.14	Fixed critical bug for DEF version of MBWR.
		Fixed bug in scenery sorting.
v0.4d 05.07.31	Added "Edit MBWR Settings" button.
v0.4c 05.05.22	Added info about current file processing to splash screen.
v0.4b 05.03.27	Fixed bug related to Windows fonts settings.
v0.4  05.03.25	CarManager and TrackManager got merged in one.
		Double-click on a car in list launches its editcar.car file with associated program.
		Available cars/tracks number displayed correctly in MBWR now.
		Added Release Notes button to Track Manager part.
		Updated save button functionality and added quick MBWR/MBWR-MP buttons.
		And of course UI got re-arranged.
v0.3c 05.02.27	Fixed bug on loading cars without names.
		Added Revert button.
		Common libraries are back now.
v0.3b 05.02.26	Fixed accessing of read-only files.
		Common libraries not included now. (smaller size)
		Added RaceClass info.
		Added new display patterns.
		Accelerated scanning of cars.
		Window dimensions stored now.
v0.3  05.01.26	Added resizing compatibility.
		Added splash screen showing loading progress.
		Fixed bug with accessing some folders.
v0.2b 05.01.25	Fixed few minor bugs. (reenabling cars, list slow)
v0.2  05.01.25	Fixed bug with lowercase named folders.
		Added DisplayFormat to choose.
		Added autoremoval of duplicate words in car names.
		Added 5th set.
		Added marked/total car counter.
		Interface update.		
v0.1  05.01.17	First release

If You have any questions, answers, comments, bugreports, wishes about this tool, please send me E-Mail.
Author: Krom
E-mail: kromster80@gmail.com
HomePage: http://krom.rscsites.org/