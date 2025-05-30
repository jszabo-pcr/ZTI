# Settings
$OSName = 'Windows 11 24H2 x64'
$OSEdition = 'Enterprise'
$OSActivation = 'Retail'
$OSLanguage = 'en-US'
#$GroupTag = 'AutopilotUserDeployment'

#Set Global OSDCloud Vars
$Global:MyOSDCloud = [ordered]@{
    BrandColor = "#0096FF"
    Restart = [bool]$true
    RecoveryPartition = [bool]$True
    OEMActivation = [bool]$True
    WindowsUpdate = [bool]$True
    WindowsUpdateDrivers = [bool]$True
    WindowsDefenderUpdate = [bool]$True
    SetTimeZone = [bool]$True
    ClearDiskConfirm = [bool]$False
    ShutdownSetupComplete = [bool]$false
    SyncMSUpCatDriverUSB = [bool]$True
    CheckSHA1 = [bool]$True
}


Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host -ForegroundColor Green "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

#Make sure I have the latest OSD Content
Write-Host -ForegroundColor Green "Updating OSD PowerShell Module"
Install-Module OSD -Force

Write-Host -ForegroundColor Green "Importing OSD PowerShell Module"
Import-Module OSD -Force

#Start OSDCloud ZTI the RIGHT way
Write-Host -ForegroundColor Green "Start-OSDCloud -OSName $OSName -OSEdition $OSEdition -OSActivation $OSActivation -OSLanguage $OSLanguage -ZTI"
Start-OSDCloud -OSName $OSName -OSEdition $OSEdition -OSActivation $OSActivation -OSLanguage $OSLanguage -ZTI

#Restart from WinPE
Write-Host -ForegroundColor Green "Restarting in 5 seconds!"
Start-Sleep -Seconds 5
wpeutil reboot
