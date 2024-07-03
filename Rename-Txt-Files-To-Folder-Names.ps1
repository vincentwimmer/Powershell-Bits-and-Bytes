# Define the root folder path
$rootFolder = "C:\Path\To\Root\Folder"

# Get all the folders in the root folder
$folders = Get-ChildItem -Path $rootFolder -Directory

foreach ($folder in $folders) {
    # Get the folder name
    $folderName = $folder.Name
    
    # Get the path of the first .txt file in the folder
    $txtFile = Get-ChildItem -Path $folder.FullName -Filter *.txt -File | Select-Object -First 1

    if ($txtFile) {
        # Define the new file name with the folder name
        $newFileName = "$folderName.txt"
        $newFilePath = Join-Path -Path $folder.FullName -ChildPath $newFileName

        # Rename the file
        Rename-Item -Path $txtFile.FullName -NewName $newFilePath
    } else {
        Write-Host "No .txt file found in folder: $folderName"
    }
}

Write-Host "All folders processed."
