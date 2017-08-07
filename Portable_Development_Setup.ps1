#Name: Portable Development Setup
#Created: 2/13/2017
#Last updated: 2/18/2017
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
		exit	
	}
	
	return $Path
}

function Prompt-Confirmation([String] $Message) 
{
	$yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes"
	$no = New-Object System.Management.Automation.Host.ChoiceDescription "&No"
	$options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
	$result = $host.ui.PromptForChoice($title, $message, $options, 0)
	
	switch ($result)
	{
		0 {return $true} 
		1 {return $false}
	}
	
	return $result
}

#################################################################

#Prompt the user for an installation path
$Folder = Prompt-Path "Select an installation folder"

#Create file structure
#
#Installation Directory
#|_Tools
#  |_Cmder
#  |_VSCode
#  |_...
#|_Projects
#|_Sandbox

$confirmInstallation = Prompt-Confirmation("Installation will delete all contents of the installation path. Are you sure you want to install?")

if (-not $confirmInstallation)
{
	exit
}

$ToolsDirectory = Join-Path -path $Folder -childpath "Tools"
New-Item $ToolsDirectory -type Directory -Force

$CmderPath = Join-Path -path $ToolsDirectory -childpath "Cmder"
New-Item $CmderPath -type Directory -Force

$NodeJsPath = Join-Path -path $ToolsDirectory -childpath "Nodejs"
New-Item $NodeJsPath -type Directory -Force

$ElectronPath = Join-Path -path $ToolsDirectory -childpath "Electron"
New-Item $ElectronPath -type Directory -Force

$VSCodePath = Join-Path -path $ToolsDirectory -childpath "VSCode"
New-Item $VSCodePath -type Directory -Force

$ProjectsDirectory = Join-Path -path $Folder -childpath "Projects"
New-Item $ProjectsDirectory -type Directory -Force

$SandboxDirectory = Join-Path -path $Folder -childpath "Sandbox"
New-Item $SandboxDirectory -type Directory -Force

#################################################################

#Check if Chocolatey is installed
$ChocolateyVersion = choco
if (-not $ChocolateyVersion)
{
	Write-Error "Chocolatey is required to install the development tools."
}

#Test path as a source for the packages
$ChocoTestPath = "C:\Users\Alex\Documents\Development\Choco_Repository"

#Install packages
choco install cmder.portable --source $ChocoTestPath -y -r --force --package-parameters="/InstallationPath:'$CmderPath'"
choco install nodejs.portable --source $ChocoTestPath -y -r --force --package-parameters="/InstallationPath:'$NodeJsPath'"
choco install electron.portable --source $ChocoTestPath -y -r --force --package-parameters="/InstallationPath:'$ElectronPath'"
choco install visualstudiocode.portable --source $ChocoTestPath -y -r --force --package-parameters="/InstallationPath:'$VSCodePath'"

#################################################################

#Set up personalizations