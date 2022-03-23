KBVUpdateDownloader

Powershellskript, um die aktuellen Stammdaten von der Webseite der KBV runterzuladen.

(Grundsätzlich können damit beliebige andere Webseiten im selben Format runtergeladen werden.)

Früher konnte man Updates über FTP runterladen - großer Vorteil dort, dass u. a. das Änderungsdatum erhalten bleiben konnte. So konnte man leicht sehen, wo es z. B. spät im Quartal noch Änderungen gab.

Seit dem Abstellen des FTPs können Updates nur noch über die Webseite runtergeladen werden, am einfachsten über ein .iso, das jedoch auf allen Dateien und Ordnern dasselbe Datum enthält.

Im Skript hier wird die Webseite und die enthaltenen Dateien und Ordner rekursiv runtergeladen - das Datum wird aus dem .html extrahiert und anschließend auf Dateien und Ordnern gesetzt.

powershell script to download files from the German KBV website.

It can be more or less easily adapted for different websites.

The highlight is that file time information is also extracted from the website (looks like a standard browsable filesystem served through a web server) and applied to files and folders.

Requires specific format of files like

'''
<img src="/icons/layout.gif" alt="[   ]"> <a href="KBV_ITA_VGEX_Anforderungskatalog_ICD-10.pdf">KBV_ITA_VGEX_Anforderungskatalog_ICD-10.pdf</a>             2022-02-15
 16:11  1.2M  
'''