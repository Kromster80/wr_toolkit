------------------------------------------------------
PTX Tool 2.1b
------------------------------------------------------

Description:
First purpose of this tool is making PTX textures for MBWR/WR2/AFC11 games.
Import/export BMP/TGA and view/export DDS files.
Later on added 2DB view ("Test Drive Unlimited" format).
DDS/2DB export almost there.

How to use:
Click on image file in filelist.
Right-click on preview images to display popup menu.
Import/Export images. Should be BMP or TGA(24/32bit) with dimensions equal to 2^n (8,16,32...2048). Image and Mask must have same dimensions.
Define maximum number of MipMap levels if necessary. By default MipMaps computed till size of 4x4 pixels and you don't need to change it.
Save PTX.

Notes:
Saving of compressed PTX files is imperfect. Resulting quality loss depends: new image compressed worse than by nvdxt util, recompressing of an already compressed image is almost perfect and much better than nvdxt can offer.
WR2 also supports packed PTX images with even smaller size, still not implemented in PTXTool.
You can use fewer MipMap levels to get sharper picture in game.
You can use uncompressed PTX images to get better image quality in game.

What's New:
v2.1b 09.04.24	Fixed bug in fog color generation
v2.1  09.04.21	Maintenance release
v2.1  09.02.20	Added checkbox to allow non-PowerOfTwo images to be opened and saved (not for games)
		Added function to create alpha from color-key
		Added function to replace color-key with average color of rest pixels
		Improved TGA saving speed, now it's as good as it was in PTXTool1.*
v2.0c 08.08.17	Fixed mask mip-map generation bug
v2.0b 08.08.07	Fixed compression bug
v2.0  08.07.29	Complete refactoring
		DXT compression built-in
		Added viewing of TDU images (*.2DB)
		Hopefully fixed incompatibility with Photosho BMP files
v1.1c 08.01.11	Fixed fade color display bug
v1.1b 07.02.25	Fixed major bug in BMP loading
v1.1  06.12.13	Greatly speed-up image display and PTX read
		Fixed save dialog to suggest correct PTX name
v1.0  06.08.29	Updated to work with newset nvdxt.exe (8.23.627.2205)
		Added menu
		Fixed image redraw
		Minor re-design
v0.9  06.01.09	Fixed bugs when viewing WR2 PTX files.
		Fastened image saving/loading.
		Added support for association with PTX/DDS files.
		Added Fade color controls.
v0.8b 05.10.01	Improved WR2 compatibility. (some bugs left)
v0.8b 05.09.24	Fastened PTX reading.
		Added beta support for WR2 PTX files. (not functional)
v0.7  05.03.19	Greatly improved BMP handling. (flipped, 8bit, etc..)
		Fixed handling or read-only files.
		Fixed locating of nvdxt.exe.
		Minor perfomance tweaks and memory usage optimizations.
		Fixed file list refresh.
		Added mirror link for nvdxt.exe.
v0.6c 05.02.12	Added support for DXT3 compressed images.
		Rearranged UI a bit.
v0.6b 05.01.12	Added "Invert Alpha" button.
v0.6  04.12.07	Added support for viewing DXT1,5 files (*.DDS).
		Updated 'About' window.
v0.5b 04.05.25	Added check for imported mask
		Pop-up menu reorganized.
v0.5  04.05.21	Added TGA support.
		Added pop-up menus.
		Fixed bug in saving of compressed PTX.
		Optimized loading of all uncompressed images.
		Custom number of mip-maps can be set.
v0.4  04.04.20	Added "Save compressed PTX" via NVDXT.exe tool.
v0.3c 04.04.09	Improved mipmap generation method.
v0.3b 04.03.31	Fixed bug in saving of non-square PTX images.
		Fixed bug with reading BMPs with non standard header.
		Added check for PTX header on file load.
		Added save without MipMaps.
		Added some info about opened file.
v0.3  04.03.27	Added save of non-compressed PTX files.
v0.2  04.03.**	Closed beta version.
v0.1b 04.03.**	Added list view.
v0.1  04.03.08	First release.

Have any questions, answers, comments ? Send me E-Mail.

Author: Krom
E-mail: kromster80@gmail.com
HomePage: http://krom.reveur.de/