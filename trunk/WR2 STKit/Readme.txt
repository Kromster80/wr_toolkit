------------------------------------------------
Scenery Tool-Kit 2 by Krom - v2.3.6
------------------------------------------------

Description:
This is a powerfull all-in-one tool to convert/edit World Racing 2 sceneries.

Requirements:
- 512mb RAM and fast GPU with shader 2.0 support (preferrably nVidia based)
- Remember to make a backup of everything just in case ;)
- Disable AntiAliasing in display drivers

Interface:
Unpack STKit2 into new folder and run Options to set path to WR2.
All controls are split into separate tabs. Few special controls are in upper menu.
Camera controls are in top-right corner.
In many tabs you can double-click in render frame to select items.
There are some docs in STKit2 Docs folder
You can edit, but can't save WR2 stock maps.
Who wants to write a tutorial?

Key Features:
- WYSIWYG :-)

Policy:
Use on your own risk.

Version History:
			Changed driving preview selector
			Fixed crash when changing STR node info without node selected
			Fixed bug in changing active track between racetrack and waypoint 
2.3.6	05.08.2010	Improved culling spheres generation algorithm for terrain
2.3.5	16.07.2010	Fixed loading of Blender LWO files
			Raised LWO layers limit from 128 to 1024
			Raised scenery size limit to 20km in any one direction
2.3.4	24Apr09	Maintenance release
2.3.4	20Apr09	Added ability to open AFC11/FVR sceneries, use save function on your own risk
		Added TRK generation
		Added warning for missing textures
		Added highlight for copy/paste properties
		Added option to choose top-down render resolution
		Added "Cast no shadow" to material properties
		Added direction arrows to some triggers
		Various improvements
		Optimized LWO import, now it works good for sceneries upto ~1m polys
		Same optimization improves scenery fps performance ingame by ~15%
2.3.3	03Dec08	Increased speed of LWO import by ~4% and quads processing by x100 times
		Fixed 2 bugs in LWO import which made scenery look weird until reloading
		Fixed OpenAL initialization bug which could break STKit2 loading
2.3.2	26Nov08	Added preliminary live sound playback
		Improved OpenGL preview		
		Minor improvements
		Fixed bug when choosing grass MaterialMode with OpenGL render
		Fixed bug with overbright objects
		Bugfix in shadow tracing
		More bugfixes
2.3.1	22May08 Added spline detail level setting
		Fixed line width display
		Fixed bug in generation of TRK straight line
2.3.0	14Apr08 Added simple car driving simulator
		Improved LWO loading, addon scenery performance increased ~20-150%
		Added particles routes maker (for snow/rain effects)
		Improved Animated objects setup and display
		Added Waypoint tracks handling
		Added auto-listing of Objects
		Improved shadow tracing
		Added shadow sharpness option
		Replaced batch loading with autoload function
		Improved Sky setup
		Improved track display
		Improved Triggers setup
		Improved grass generation, especially for MBWR maps
		Improved renderspeed ~10%
		Fixed and improved built-in ColorPicker
		Fixed street spline connection without shapes premade
		Improved Checkers render mode to show true texture resolution
		Added print screen to JPG
		Fixed three bugs in TRK making (Thanks to TomWin)
		V1\V2\V3 tracks are saved alltogether now
		Other small bugfixes and improvements
2.2.1	16Dec07	Changed traffic lanes preview
		Changes grass preview to better one
		Fixed tunnel lights highlighting players car
		Got rid of 65k vertices\polys limit per layer
		Added Enlite\Grass marks to materials list
		Added waypoint routes loading (wtr files)
		Added checkers render mode
		Fixed minor bugs in streets setup
		Fixed grass display error
2.2.0	03Dec07	Added fog preview
		Added shadow map making (smp files)
		Minor bugfixes and major speed improvements in shadow tracing
		Fixed bug in animated object preview if route length =0
		Fixed bug when saving materials, names were in wrong order
		Minor improvements and bugfixes		
2.1.9	24Nov07	Added simple test-drive feature
		Added preview mode
		Added simple warnings of unsaved data
		Fixed instance copy/paste bug
		Added button to reload LWO scenery
		Added "Enlite" option switch for materials
2.1.8	14Nov07	Fixed ObjectX3/X4 messages
		Included tree leaves to display
2.1.7	14Nov07	Improved triggers setup for Nitro
		Improved shadow tracing speed
		Fixed bug in materials order, now it's reset on saving
		Improved scenery shaders for better WYSIWYG
		Minor bugfixes
2.1.6	20Oct07	Added shadow tracing
		Fixed big flaw in LWO import
		Improved SC2 handling
		Changed TGA textures to PTX, made STKit2 package size smaller
2.1.5	13Oct07	AddonInfo page bugfix
		Improved "Screenrender 2x2" taking
		Added getting grass color from TGA image
		Added object instances landing (in Special menu)
		Small improvements in street routes drawing
2.1.4	10Oct07	Removed annoying loading messages "XXX missing"
		Improved traffic setup greatly
		Fixed object placing bug
		Improved [Reset] button functionality
		Improved grass setup
		Fixed bugs in AddTrigger function
2.1.3	07Sep07	Added OpenGL version check at startup
		Growing grass only on selected materials
		Small bugfixes
2.1.2	30Aug07	Added ability to change object for instances
2.1.1	29Aug07	Small bugfixes
2.1	17Aug07	Track generation includes good racing-line approximation now
		Implemented universal ColorPicker for colors (sky, lights)
		Improved Sun setup and overall Sky tab functionality
		Replaced text tabs with icons :-)
		Fixed Materials import/export to files. Does not compatible with older versions of .dat files
		Improved Textures and Objects adding/removing
		Improved Animated objects view
		Simplified creation on new scenary, doesn't depends on LWO filename from now on
		Added basic batch handling for LWO import (should be improved later)
		Added basic grass generation (should be improved later)
		New render mode "OpenGL" works faster but only for UV mapped materials
		Number of various bugfixes
2.0	14Jul07	Public release
demo	12Jun07	Public demo
beta	07	Closed version

If You have any questions, comments, bugreports or requests about this tool or just want to send a postcard - contact me by e-mail.
Author: Krom
E-mail: kromster80@gmail.com
Site: http://krom.reveur.de/