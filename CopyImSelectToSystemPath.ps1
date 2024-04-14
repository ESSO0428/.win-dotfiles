# Get the directory of the currently running script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceFile = Join-Path -Path $scriptDir -ChildPath "im-select.exe"
$targetPathWindows = "C:\Windows\"
$targetPathUserProfile = "$env:USERPROFILE\"

# Function to copy file with user confirmation
function CopyFileWithConfirmation {
    param(
        [string]$source,
        [string]$destination
    )
    # Inform the user about the target location
    Write-Host "Attempting to copy `im-select.exe` to $destination."
    $userChoice = Read-Host "Do you want to proceed with copying to this location? (y[es]/n[o])"
    $userChoice = $userChoice.ToLower()

    if ($userChoice -eq "y" -or $userChoice -eq "yes") {
        if (Test-Path $destination) {
            Copy-Item $source $destination -Force
            Write-Host "im-select.exe has been successfully copied to $destination"
        } else {
            Write-Host "Destination path does not exist: $destination"
        }
    } else {
        Write-Host "Copying aborted by user."
    }
	Write-Host "------------------------------"
}

# Check if the source file exists
if (Test-Path $sourceFile) {
    try {
        # Ask user and copy the file to the Windows directory
        CopyFileWithConfirmation -source $sourceFile -destination $targetPathWindows
        
        # Ask user and copy the file to the User Profile directory
        CopyFileWithConfirmation -source $sourceFile -destination $targetPathUserProfile
    } catch {
        Write-Host "An error occurred: $_"
    }
} else {
    Write-Host "The source file does not exist: $sourceFile"
}
