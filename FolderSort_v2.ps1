#Branch for Mean Girls Broadway
#Adds functionality to handle headshot files and sort them into the appropriate folder
#Headshot files don't contain a folder number but are consistently named with "headshot" at the beginning
#New functionality handles folder 200 naming convention

param ( $fileFolder, $videoFolder)

$DebugPreference = "Silently Continue"
#$DebugPreference = "Continue"

$videoFolder = 'D:\d3 projects\meangirls_BWAY\objects\VideoFile'
$folderArray = @($null)*1000
$proceed = "N"


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
Function Folder-Sort {
		
	param($proceedCase)

	if ($proceedCase -eq "Y") {Write-Host "Copying Files..."}

	foreach ($file in $fileList) {


		$split = $file.Name

		$fileSplit = $split.Split("_")

	
	   try { 
		
		   if($fileSplit[0] -eq "Headshots"){
			   $folder = $folderArray[200]
		   }
		   elseif([convert]::ToInt32($fileSplit[0]) ){ $folder = $folderArray[$fileSplit[0]]}
		   else {$folder = $false}
		
		$dest = $videoFolder + '\' + $folder
		$destFileList = Get-ChildItem -Path $dest -Name

		Write-Debug ($dest)

		if ($folder) {

			Write-Host ("Put File $split into Folder", $folder)

			if ($destFileList.Contains($split)) {write-host ("File Already Exists- Change Version Number!") -ForegroundColor Red}
			else {
    
        
			 if($proceedCase -eq "Y"){
				$file | Copy-Item -Destination $dest
				 Write-Host("Success") -ForegroundColor Green
				 }
			else {
			   write-host("Will Succeed") -ForegroundColor Green
			}
    
			}
		   }
		else { write-host "Folder does not exist for file $split" -ForegroundColor Magenta }
		}
		catch { write-host "File $Split is missing folder number or formatted incorectly.  Skipping File" -ForegroundColor DarkMagenta }
	}

	}

Folder-Sort -proceedCase $false


$proceed = Read-Host -Prompt "Proceed? Y/N"
$proceed.ToUpper()

Folder-Sort($proceed)




	