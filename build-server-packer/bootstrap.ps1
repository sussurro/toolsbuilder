Write-Host "Starting SendWindowsIsReady"
C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\SendWindowsIsReady.ps1 -Schedule
Write-Host "Starting InitliazeInstance"
C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\InitializeInstance.ps1 -Schedule
Write-Host "performing Sysprep"
C:\ProgramData\Amazon\EC2-Windows\Launch\Scripts\SysprepInstance.ps1 -NoShutdown
Write-Host "SYSPREP Finished..."
