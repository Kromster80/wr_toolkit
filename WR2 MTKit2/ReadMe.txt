------------------------------------------------------
"World Racing 2" Mesh Tool-Kit v2.4.2
------------------------------------------------------

Description:
Mesh Tool-Kit for "World Racing 2" is capable of:
- Importing LWO and 3DS and OBJ files to WR2/AFC11 (as MOX models and COB and CPO collision boxes)
- Setup lights and damage parts for WR2/AFC11 models
- Password protect WR2 models
- Simple editing of COB/CPO files
- viewing and editing material settings of WR2 models (MTL editor)

Explanations for damage setup:
In order to setup damage details in MTKit2 you first need to split model into parts. You can do this in Lightwave by following routine:
- select polys you want to be stand-alone detail (Door for example)
- goto View tab, click "Create Part" and assign part name
- repeat previous steps for every part you want to make (up to ~64)
Now in MTKit you will need to define pivot points and behaviour of parts.

Notes:
WR2 loads car model each time you change car's color in game menu. To fine tune surfaces/geometry, switch out of WR2 by using Alt-TAB and replace MTL/MOX files with new ones. Then switch back to WR2 and change car color, WR2 will update geometry/surface.

Your OS might freeze for a dozen of seconds while LWO files are being loaded. Just watch progress bar, if it freezes for more than 20sec, MTKit is stuck and you can kill it from "Task Manager".

Collision models must have special shape. Best way to avoid bugs is to use slightly modified meshes from original WR2 cars of similar shape.

MTKit2 shows you preview of a car, WR2 will display it bit differently.

AFC11/FVR support is limited.

Version History:
2.4.2   2022.09.25  Replaced old clunky LWO import/export with a proper one (taken from KP) for LWO<->COB as a proof of concept
                    Fixed error in MOX>LWO export from 2.3.8
2.4.1   2022.09.18  Fixed several crashes due to code refactoring and 65k+ models support
                    Added crash reporter module
2.4.0   2022.09.17  Lots of code refactoring (hopefully that didnt brake anything)
                    Closing color picker with [X] will now revert the changes in color
                    Blinker color picker wont show up if no blinker is selected
                    Fixed the way .mox file associations are written in Windows Registry
                    Added error on loading unsupported MOX versions (newer AFC11 cars)
                    Fixed display of cars with more than 65k vertices/polys
                    Fixed uniformity of 3D model view rotation/pane/zoom on mouse/tablet input
2.3.9   2022.03.09  Added option to spread model parts over X axis on MOX > LWO export
                    Fixed LWO export (broken in 2.3.8)
2.3.8   2021.02.21  Added option to ask if you really want to close MTKit2
                    Added confirmation after registering file association of MOX files
                    Removed password protection
                    Build using Delphi XE8
2.3.7   2011.05.11  Fixed bug with registering file association of MOX files, now it's optional
2.3.6   2010.10.25  Improved loading speed of MOX files
                    Added association of MOX files with MTKit
                    Renamed unknown Light to Nozzle flash (it marks gunshot flash location)
2.3.5   2009.11.07  Materials and lights lists now have color boxes
                    Quick fix to open AFC11HN models
                    Blinkers are sorted descending on save now
2.3.4   2008.09.04  Fixed bug in COB saving which crashed WR2
2.3.3   2008.08.27  Added CPO freeform shapes import/export
                    Fixed a bug which made CPO don't work in game
                    Added quad support for LWO import, sweet!
                    Improved 3DS import
                    Added preliminary OBJ import
2.3.2   2008.07.26  Added support for packed ptx textures
2.3.1   2008.07.12  Half a dozen of bugfixes
                    Wireframe color can be changed now
2.3.0	2008.06.30	Major code refactoring and clean-up
			Improved MOX > LWO export
			Added 3DS import
			Added CPO format support
			Added UV map view
			Added vinyls display
			Improved UI and added some new minor features
2.2.2	2008.03.01	Improved LWO support (thanks to Hermann)
			Fixed Parts bug introduced in v2.2.1 (thanks to TomWin)
2.2.1	2008.01.08	Added folder view for easier navigation :)
			Further internal refactoring
2.2.0	2007.10.15	Changed mouse rotate/zoom controls to STKit2 alike
			Added CPO (AFC11 collision format) import
			Fixed LWO import broken UVs
			Started refactoring old code
2.1.10	2007.05.13	Fixed error messages on ATI9xxx series.
2.1.9	2007.03.14	Bugfixes
2.1.9	2007.03.04	Extended blinkers limit 64->128
			Bugfixes
2.1.8	2007.01.14	Added partial PTX textures support
			Rewritten shaders code to GLSL
2.1.7	2006.10.28	Optimizations and fixes
			Added and fixed TREE file import
			Fixed dummy preview for AFC11 models
2.1.6	2006.10.24	Added support for AFC11 files
			Added Extra menu
2.1.5	2006.10.06	Fixed bug in saving of single-color MTL files
			Added MBWR MOX import
			Added association MOX files with MTKit compatibility
			Fixed Info tab entries
2.1.4	2006.09.09	Fixed COB export
2.1.3	2006.09.05	Fixed minor bugs
			Minor optimizations
2.1.2	2006.08.25	Fixed major bug in saving of complex multi-part models
			Fixed bug in lights setup
			Fixed bug in loading 2 lwos for mox and cob files
2.1.1	2006.08.20	Fixed bug in parts behavior setup
2.1.1	2006.08.15	Decreased memory usage for multi-part cars greatly
			Added dirt preview controls
			New reload icon and slight UI rearrange
			Fixed handling of transparency values beyond 0..255 range
			Added 2-state Wireframes
			Fixed slowdown in COB view
			Partialy fixed LWO export
			Fixed controls of damage parts behavior
			Changed site link in "About" form
			Fixed bug in pivot setup routine
			Added batch loading of LWO+MTL+PSF+PBF+LSF+COB pack
			Menu splitted into 2 sections (Load,Save)
2.1.0	2006.07.27	Included options.ini file
			Fixed PSF (PivotSetupFile) bug
2.1.0	2006.07.27	Completed setup parts routine (including Save/Load so you can save templates)
			Model preview displays materials more accurate now
			Anything else I already forgot
2.0.9	2006.06.23	Fixed loading of cars with more than 64 blinker dummies.
			Decreased processor usage time by limiting max fps.
2.0.9	2006.06.19	Added damage setup
			Added Load MTL function
			UI Layout updated
			Enabled RGB color input
			Added Body and Blinker color presets
			Added "Show Light/Show Part" options
			Due to numerous bugs in WR2 blinker count now limited to 64
			Fixed surface renaming bug
2.0.2	2006.03.26	LWO export
			Improvements and bugfixes
2.0.1	2006.03.22	Improvements
			Added LWO>COB procedure and COB tab
			Fixed reflection incorrect saving in MTL
2.0	2006.03.19	Public release

If You have any questions, answers, comments, suggestions or requests - I'd be happy to read your e-mail.
Author: Krom
E-mail: kromster80@gmail.com
Site: http://krom.reveur.de/