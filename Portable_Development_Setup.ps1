#Name: Portable Development Setup
#Last updated: 2/13/2017
#Author: Alex Ireland


#Prompt for a path
function Prompt-Path ([String] $Description)
{
	$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
	
	if ($Description)
	{
		$FolderBrowser.Description = $Description
	}
	
	$FolderBrowser.ShowDialog()
	return $FolderBrowser.SelectedPath
}