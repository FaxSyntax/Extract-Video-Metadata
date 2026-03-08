@echo off

title Retrieving Video Information

setlocal enabledelayedexpansion
set "target_folder=C:\Videos"
set "outputfile=Videos.txt"
set "AspectRatio=NO"
set "Dimensions=YES"
set "Codec=NO"

echo. > %outputfile%
del /q %outputfile%
echo. > %outputfile%

setlocal disabledelayedexpansion

FOR /R "%target_folder%" %%X IN (*.mp4 *.mkv *.mov *.avi *.wmv) DO (
	SET FILENAME=%%X
	setlocal enabledelayedexpansion
	echo !FILENAME! >> %outputfile%
	
	IF "%AspectRatio%"=="YES" (
		ffprobe -v error -select_streams v:0 -show_entries stream=display_aspect_ratio -of csv=p=0 "!FILENAME!" >> %outputfile%
	)
	IF "%Dimensions%"=="YES" (
		ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "!FILENAME!" >> %outputfile%
		ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "!FILENAME!" >> %outputfile%
	)
	IF "%Codec%"=="YES" (
		ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "!FILENAME!" >> %outputfile%
	)
	endlocal
)
endlocal
