# Get the directory of the currently running script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceDir = Join-Path -Path $scriptDir -ChildPath "user_documents_dotfiles"
$targetDir = [System.IO.Path]::Combine([Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments))

# Check if the source directory exists
if (Test-Path $sourceDir) {
    # Get all top-level items in the source directory
    $items = Get-ChildItem -Path $sourceDir

    # Inform user about the copying process
    Write-Host "Preparing to copy contents from $sourceDir to your Documents folder: $targetDir"

    # Loop through each top-level item
    foreach ($item in $items) {
        $sourceItemPath = $item.FullName
        $targetItemPath = $sourceItemPath.Replace($sourceDir, $targetDir)

        # Tell the user what will happen for top-level items
        Write-Host "Top-level item to copy: $($item.Name)"
        $userChoice = Read-Host "Do you want to copy this top-level item to $targetDir? (y[es]/n[o])"
        $userChoice = $userChoice.ToLower()

        # Check user choice
        if ($userChoice -eq "y" -or $userChoice -eq "yes") {
            # Copy item, use -Recurse if it is a directory
            if ($item.PSIsContainer) {
                Copy-Item -Path $sourceItemPath -Destination $targetItemPath -Recurse -Force
                Write-Host "Directory and its contents copied successfully to $targetItemPath"
            } else {
                Copy-Item -Path $sourceItemPath -Destination $targetItemPath -Force
                Write-Host "File copied successfully to $targetItemPath"
            }
        } else {
            Write-Host "Copying of $($item.Name) cancelled by user."
        }
        
        # Print a separator line after handling each top-level item
        Write-Host "------------------------------"
    }
} else {
    Write-Host "Source directory does not exist: $sourceDir"
}
