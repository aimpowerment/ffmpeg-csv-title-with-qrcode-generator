chcp 1252
@echo off
setlocal enabledelayedexpansion

rem VON DER CSV ALLE TEXTFELDER IN EINFACHEN HOCHKOMMA (') UND FELDER MIT KOMMA (,) TRENNEN SOWIE IM WINDOWS-1252 ZEICHENSATZ SPEICHERN
rem ACHTUNG BEI PFAD ANGABEN DEN DOPPELPUNKT UND BACKSLAHES ESCAPEN UND DOPPEL HOCHKOMMATA: ("C\:\\PFAD\\ZUR\\SCHRIFT.TTF")
rem BEIM SPEICHERN IN OFFICE TEXTTRENNZEICHEN ENTFERNEN !!! SONST MERFACH HOCHKOMMA !!!
rem DIE TIME VARIABLE t KANN ZUM ANIMIEREN IM CSV GENUTZT WERDEN.
set input_csv=filelist.csv
set output_video=output.mp4
set temp_dir=temp_videos

if not exist %temp_dir% mkdir %temp_dir%
if exist %output_video% del %output_video%


for /f "tokens=1-29 delims=," %%A in (%input_csv%) do (
	set duration=%%A
	set text1=%%B
	set text_color1=%%C
	set text_size1=%%D
	set x1=%%E
	set y1=%%F
	set font1=%%G
	set fadeStart1=%%H
	set fadeIn1=%%I
	set textDuration1=%%J
	set fadeOut1=%%K
	set text2=%%L
	set text_color2=%%M
	set text_size2=%%N
	set x2=%%O
	set y2=%%P
	set font2=%%Q
	set fadeStart2=%%R
	set fadeIn2=%%S
	set textDuration2=%%T
	set fadeOut2=%%U
	set qr_text=%%V
	set qr_pos_x=%%W
	set qr_pos_y=%%X
	set qr_size=%%Y
	set qr_fade_in_start=0.2
	set qr_fade_in_duration=2
	set qr_fade_out_start=2
	set qr_fade_out_duration=2
       
    rem erzeuge Zufallszahl für temporäre Videos
    set rdnr=!RANDOM!

    set /a fullDuration1=!fadeStart1!+!fadeIn1!+!textDuration1!+!fadeOut1!
    set /a fullDuration2=!fadeStart2!+!fadeIn2!+!textDuration2!+!fadeOut2!

    set /a fadeDuration1=!fadeIn1!+!textDuration1!
    set /a fadeDuration2=!fadeIn2!+!textDuration2!

    rem Ein und Ausblenden des Textes sowie mit welcher Verzögerung der Text dargestellt werden soll
    set alpha1="alpha='if(lt(t,!fadeStart1!),0,if(lt(t,!fadeIn1!),(t-!fadeStart1!)/1,if(lt(t,!fadeDuration1!),1,if(lt(t,!fullDuration1!),(!fadeOut1!-(t-!fadeDuration1!))/!fadeOut1!,0))))'"
    set alpha2="alpha='if(lt(t,!fadeStart2!),0,if(lt(t,!fadeIn2!),(t-!fadeStart2!)/1,if(lt(t,!fadeDuration2!),1,if(lt(t,!fullDuration2!),(!fadeOut2!-(t-!fadeDuration2!))/!fadeOut2!,0))))'"
    rem Erzeuge QR-Code-Bild
    qrcode -o qr_temp.png -m 1 -d 120 -s !qr_size! "!qr_text!"



    rem Füge QR-Code-Bild zu Video hinzu und erstelle die Textfelder samt Parameter 
    rem :y_align=font für jedes Textfeld angeben um fixe Zeilenhöhe zu gewährleisten
	call ffmpeg -f lavfi -i "color=c=black:s=1920x1080:d=!duration!" !bgo! -i qr_temp.png -filter_complex "!bgi! overlay=x=!qr_pos_x!:y=!qr_pos_y!,fade=t=in:st=!qr_fade_in_start!:d=!qr_fade_in_duration!:alpha=0,fade=out:st=!qr_fade_out_start!:d=!qr_fade_out_duration!:alpha=0,drawtext=text='!text1!':fontcolor=!text_color1!:fontsize=!text_size1!:x=!x1!:y=!y1!:fontfile=!font1!:!alpha1!:y_align=font,drawtext=text='!text2!':fontcolor=!text_color2!:fontsize=!text_size2!:x=!x2!:y=!y2!:fontfile=!font2!:!alpha2!:y_align=font" -c:a copy -t !duration! -y -an %temp_dir%\temp_!rdnr!.mp4

    echo file '%temp_dir%\temp_!rdnr!.mp4' >> temp_list.txt
    rem Lösche temporäres QR-Code-Bild
    del qr_temp.png
    rem timeout /t 1 /nobreak >nul
)

rem Zusammenfügen der temporären Videos
ffmpeg -f concat -safe 0 -i temp_list.txt -c copy %output_video%

rem Löschen der temporären Dateien und Verzeichnisse
del temp_list.txt
rmdir /s /q %temp_dir%

echo "Video wurde erstellt: %output_video%"
