# Titles with QR-Code from CSV
Developed by [Alberto Sono](https://github.com/aimpowerment/ "Alberto Sono @ aimpowerment Dept.") for [ffmpeg](https://github.com/BtbN/FFmpeg-Builds/releases "ffmpeg") & [qrencode](https://github.com/fukuchi/libqrencode "qrencode")

**Description:**

The [csv2title](https://github.com/aimpowerment/ffmpeg-csv-title-with-qrcode-generator/blob/main/csv2title.bat) batch script generates a video title with two lines and a QR code. The size and position can be specified in the csv file. Font type and colour can also be specified for the font, whereby each of the two lines can be defined with its own colour and font type.

**Important:**

Please note the following when saving the csv file:
* All alphanumeric or strings are set in single inverted commas.
* SEPARATE ALL TEXT FIELDS FROM THE CSV IN SINGLE APOSTROPHE (') AND FIELDS WITH COMMA (,) AND SAVE IN WINDOWS-1252 CHARACTER SET
* BE CAREFUL WHEN SPECIFYING THE PATH, ESCAPE THE COLON AND BACKSLAPS AND DOUBLE INVERTED COMMAS: `'"C\\:\\\PATH\\\TO\\\TYPE.TTF"'`
* REMOVE TEXT SEPARATORS WHEN SAVING IN OFFICE !!! OTHERWISE JUST USE AN APOSTROPHE !!!
* THE TIME VARIABLE t AND OTHER FFMPEG VARS CAN BE USED FOR ANIMATING IN CSV

![CSV SAVE OPTIONS](https://github.com/aimpowerment/ffmpeg-csv-title-with-qrcode-generator/blob/main/csv_save_options.png?raw=true)
