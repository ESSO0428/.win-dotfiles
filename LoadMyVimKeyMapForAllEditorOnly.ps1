# Define the paths and corresponding files
$paths = @{
    [System.IO.Path]::Combine([Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments), "Obsidian Vault") = ".obsidian.vimrc"
    [System.IO.Path]::Combine([Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData), "nvim") = "nvim/"
    [System.IO.Path]::Combine([Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile), ".ideavimrc") = ".ideavimrc"
    [System.IO.Path]::Combine([Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile), "keymap.vim") = "keymap.vim"
}

# Array of files to check individually
# $fileNames = @(".obsidian.vimrc", ".ideavimrc", "keymap.vim")

# Define files and their target handling
$fileHandling = @{
    ".obsidian.vimrc" = "targetToSubDir";
    ".ideavimrc"      = "targetToDir";
    "keymap.vim"      = "targetToDir"
}

# Get the current script directory to use as the source path
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptVimKeyMapSubDir = Join-Path -Path ($scriptDir) -ChildPath "VimKeyMap"

# Check if each path exists
foreach ($path in $paths.Keys) {
    $fileName = $paths[$path]
    $fullFilePath = [System.IO.Path]::Combine($path, $fileName)
    $directoryPath = $fullFilePath | Split-Path -Parent
    
    if (Test-Path $path) {
        
        # Determine handling type from fileHandling hash table
        $handlingType = $fileHandling[$fileName]

        # Prompt user for overwrite action using a switch on handling type
        switch ($handlingType) {
            "targetToSubDir" {
                Write-Host "File exists: $fullFilePath"
                $userChoice = Read-Host ("Do you want to overwrite the sub-directory file at " + $fullFilePath + "? (y[es]/n[o])")
                $userChoice = $userChoice.ToLower()
                if ($userChoice -eq "y" -or $userChoice -eq "yes") {
                    Copy-Item "$scriptVimKeyMapSubDir\$fileName" $fullFilePath -Force
                    Write-Host "File overwritten successfully at " + $fullFilePath + "."
                }
            }
            "targetToDir" {
                Write-Host "File exists: $path"
                $userChoice = Read-Host ("Do you want to overwrite the directory file at " + $path + "? (y[es]/n[o])")
                $userChoice = $userChoice.ToLower()
                if ($userChoice -eq "y" -or $userChoice -eq "yes") {
                    Copy-Item "$scriptVimKeyMapSubDir\$fileName" $directoryPath -Force
                    Write-Host "File overwritten successfully at " + $fullFilePath + "."
                }
            }
        }
        if ($paths[$path] -eq "nvim/") {
            Write-Host "File exists: $directoryPath"

            $userChoice = Read-Host ("Do you want to completely remove and overwrite the nvim/ directory at " + $path + "? (y[es]/n[o])")
            $userChoice = $userChoice.ToLower()  # Normalize input
            if ($userChoice -eq "y" -or $userChoice -eq "yes") {
                # Copy and overwrite the directory
                if (Test-Path $directoryPath) {
                    Remove-Item -Path $path -Recurse -Force
                    Write-Host "Old nvim directory removed."
                }
                Copy-Item "$scriptVimKeyMapSubDir\nvim\" $path -Recurse -Force
                Write-Host "Directory overwritten successfully."
            }
        }

    } else {
        Write-Host "Directory does not exist: $path"
    }
    Write-Host "------------------------------"
}
