$config = gc config.json | ConvertFrom-Json
$dpath = gci $config.settings.VSDir -Recurse -Name msbuild.exe | select -First 1
if($dpath -eq $null){
    Write-Host "Can't find binary for devenv"
    return
}



$msbuild = $config.settings.VSDir + "\" + $dpath

New-Item -Name Binaries -ItemType Directory
$config.settings.Categories | %{ 
    New-Item -Path .\Binaries -ItemType Directory -Name $_ 
}
$config.repos | %{
    Write-Host "[*] Building $($_.name)"
    $j = start-job -scriptblock {
        param($git,$name)  
        Set-Location $using:PWD
        "git clone $($git) $($name)" | out-file -append  test.out 
         & "git" clone $git $name 2>&1  | out-null  } -ArgumentList $_.git,$_.name 
    if (Wait-Job $j -Timeout 30 ) { Receive-Job $j 2>&1 | out-null }
    Remove-Job -force $j
    if(-not (Test-Path $_.name -ErrorAction SilentlyContinue)){
        Write-Host -ForegroundColor Red "[-] Clone failed of $($_.name)"
    }else {
    Write-Host "QQ"
     $b = $_.Build -split "\|"
     & "nuget" Restore "$($_.name)\$($_.Solution)" 2>&1  | out-file -Append Build.out
     & "$msbuild" -t:Build /p:PlatformToolset=v140 /p:WindowsTargetPlatformVersion=10.0 -p:Configuration="$($b[0])" -p:Platform="$($b[1])" "$($_.name)\$($_.Solution)" | out-file -append build.out
     if($_.bindir -ne $null){
        copy-item -path "$($_.name)\$($_.bindir)\*" -Destination "Binaries\$($_.cat)\" -Recurse -ErrorAction Continue
     }
}
}

