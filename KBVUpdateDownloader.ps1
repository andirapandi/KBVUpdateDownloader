# recursively downloads files and creates subfolders
# applying modify date as displayed on website

# test $starturl = "https://update.kbv.de/ita-update/Abrechnung"
$starturl = "https://update.kbv.de/ita-update" # no trailing /
$targetroot = "C:\temp\kbv"

function DownloadAll
{
    param (
        $url,
        $target
    )

    $data = invoke-webrequest -uri $url
    $lines = ($data.Content -split "\r?\n|\r")
    $linklines = $lines | where {$_ -like "*<a href=*"} | where {$_ -notlike "*Last modified</a>*"}
    #$linklines
    foreach ($line in $lines)
    {
        if ($line -match '<a href=".*">(?<subpath>.+)</a>.*(?<date>\d\d\d\d-\d\d-\d\d \d\d:\d\d)')
        {
            $newurl = $url + "/" + $Matches.subpath
            $date = $Matches.date
            $newpath = $target + "/" + $Matches.subpath

            # skip full iso + vorquartale
            if ($newurl -like '*ITA-Update_202?_Q?.iso' -Or $newurl -like '*Vorquartale')
            {
                 continue
            }

            # folder
            # debug output current data
            $newurl
            $newpath
            if ($newurl -like '*/')
            { 
                If (!(test-path $newpath))
                {
                    md $newpath
                }
                DownloadAll -url $newurl -target $newpath
                $folder = Get-Item $newpath
                $folder.LastWriteTime = [DateTime]$date
            } else
            # file
            {
                Invoke-WebRequest $newurl -OutFile $newpath
                $file = Get-Item $newpath
                $file.LastWriteTime = [DateTime]$date
            }
        }
    }
}

DownloadAll -url $starturl -target $targetroot