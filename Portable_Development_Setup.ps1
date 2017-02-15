#Name: Portable Development Setup
#Last updated: 2/13/2017
#Author: Alex Ireland


#Prompt for a path
function Prompt-Path-Dialog ([String] $Description)
{
	$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
	
	if ($Description)
	{
		$FolderBrowser.Description = $Description
	}
	
	$FolderBrowser.ShowDialog()
	return $FolderBrowser.SelectedPath
}

function Prompt-Path
{
	$Path = Read-Host -Prompt 'Enter an installation path'
	$ValidPath = Test-Path $Path
	
	if (!$ValidPath)
	{
		Write-Error "Invalid path entered"		
	}
	
	return $Path
}

#Prompt the user for an installation path
$Folder = Prompt-Path "Select an installation folder"
Write-Host "Installing path" $Folder



#Create file structure

#Get default package installation path for Chocolatey and save it
#Set the default package installation path to the user selected path
#Install packages
#Reset the default package installation path

#Set up personalizations