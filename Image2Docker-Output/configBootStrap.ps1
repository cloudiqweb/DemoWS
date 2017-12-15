$configMappingJsonPath = 'C:\configmappings.json'
$configJson = (Get-Content $configMappingJsonPath -Raw) | ConvertFrom-Json



foreach($configObj in $configJson)
{
    $environmentVar = $configObj.configID
    
    $environmentValue = [Environment]::GetEnvironmentVariable($environmentVar, 'Process')
	
	$environmentValue = $environmentValue -replace '"', ""

    $decodedValue = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($environmentValue))

    Out-File -FilePath $configObj.configTargetFilePath -Encoding "UTF8" -InputObject $decodedValue
    
}


C:\ServiceMonitor.exe w3svc