param ( $fileFolder)

$videoFolder = 'D:\d3 projects\meangirls_BWAY\objects\VideoFile'
$folderArray = @($null)*1000
$folderList = Get-ChildItem -Path $videoFolder -Name


if (!$fileFolder) {

    write-host("Enter Folder Path:")
    $fileFolder = Read-Host

}


$fileList = Get-ChildItem -Path $fileFolder


for($h = 0; $h -ne $folderlist.Length; $h++) {
    
    $split = $folderList[$h]

    $folderSplit = $split.Split("_")
 
   try { $folderArray[$folderSplit[0]] = $split }
   catch { write-host "Folder $split is missing folder number or formatted incorectly.  Skipping Folder" -ForegroundColor Red }
       # write-host($folderSplit[0])
       # write-host($split)



}

for($i = 0; $i -ne $filelist.Length; $i++) {
    
    $split = $fileList[$i].Name

    $fileSplit = $split.Split("_")

    
 
    

   try { 
    if([convert]::ToInt32($fileSplit[0]) ){}
   
    $dest = $videoFolder + '\' + $folderArray[$fileSplit[0]]
    $destFileList = Get-ChildItem -Path $dest -Name

    # Write-Host ($dest)

    if ($folderArray[$fileSplit[0]]) {

        Write-Host ("Put File $split into Folder", $folderArray[$fileSplit[0]])

        if ($destFileList.Contains($split)) {write-host ("File Already Exists- Change Version Number!") -ForegroundColor Red}
        else {
    
        
         # $fileList[$i] | Copy-Item -Destination $dest
           write-host("Will Succeed") -ForegroundColor Green
    
    
        }
       }
    else { write-host "Folder does not exist for file $split" -ForegroundColor Magenta }
    }
    catch { write-host "File $Split is missing folder number or formatted incorectly.  Skipping File" -ForegroundColor DarkMagenta }



}
$proceed = Read-Host -Prompt "Proceed? Y/N"

if ($proceed -eq "Y" -or $proceed -eq "y") {

    write-host("Copying Files")

for($i = 0; $i -ne $filelist.Length; $i++) {
    
    $split = $fileList[$i].Name

    $fileSplit = $split.Split("_")

    
 
   try { 

    if([convert]::ToInt32($fileSplit[0])){}

    $dest = $videoFolder + '\' + $folderArray[$fileSplit[0]]
    $destFileList = Get-ChildItem -Path $dest -Name

   # Write-Host ($dest)
   if($folderArray[$fileSplit[0]]) {

   Write-Host ("Putting File $split into Folder", $folderArray[$fileSplit[0]])

    if ($destFileList.Contains($split)) {write-host ("File Already Exists- Change Version Number!") -ForegroundColor Red}
    else {
    
        
        $fileList[$i] | Copy-Item -Destination $dest
        write-host("Success") -ForegroundColor Green
    
    
    }
    }

    else { write-host "Folder does not exist for file $split" -ForegroundColor Magenta }

    }
    catch { write-host "File $Split is missing folder number or formatted incorectly.  Skipping File" -ForegroundColor Red }


}
    Read-Host -Prompt "Complete. Press ENTER to quit"


}
