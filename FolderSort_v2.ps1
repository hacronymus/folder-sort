param ( $fileFolder, $videoFolder)

$DebugPreference = "Silently Continue"

#$videoFolder = 'D:\d3 projects\meangirls_BWAY\objects\VideoFile'
$folderArray = @($null)*1000



if (!$fileFolder) {

    write-host("Enter File Folder Path:")
    $fileFolder = Read-Host

}
if (!$videoFolder) {

    write-host("Enter Destination Folder Path:")
    $videoFolder = Read-Host

}

$folderList = Get-ChildItem -Path $videoFolder -Name
$fileList = Get-ChildItem -Path $fileFolder


for($h = 0; $h -ne $folderlist.Length; $h++) {
    
    $split = $folderList[$h]
	if($split[3] -eq "_") {
		$folderSplit = $split.Split("_")
		}
	elseif ($split[3] -eq " ") {
		$folderSplit = $split.Split(" ")
		}
	elseif ($split.Length -eq 3) {
		$folderSplit[0] = $split
		}
	else {
		write-host "Folder $split is missing folder number or formatted incorectly.  Skipping Folder" -ForegroundColor Red
		$folderSplit = "null"
	}

   try { $folderArray[$folderSplit[0]] = $split }
   catch { write-host "Folder $split is missing folder number or formatted incorectly.  Skipping Folder" -ForegroundColor Red }
       write-debug($folderSplit[0])
       write-debug($split)
	   Write-Debug($split.Length)



}

for($i = 0; $i -ne $filelist.Length; $i++) {
    
    $split = $fileList[$i].Name

    $fileSplit = $split.Split("_")

    
 
    

   try { 
    if([convert]::ToInt32($fileSplit[0]) ){}
   
    $dest = $videoFolder + '\' + $folderArray[$fileSplit[0]]
    $destFileList = Get-ChildItem -Path $dest -Name

    Write-Debug ($dest)

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
