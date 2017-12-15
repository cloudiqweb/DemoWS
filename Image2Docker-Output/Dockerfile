# escape=`
FROM microsoft/aspnet:3.5-windowsservercore-10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Remove-Website 'Default Web Site';

RUN Add-WindowsFeature NET-WCF-HTTP-Activation45

# Set up website: MyAspNetWebForms
RUN New-Item -Path 'C:\inetpub\Websites\MyAspNetWebForms' -Type Directory -Force; 

RUN New-WebAppPool 'MyAspNetWebForms' | Set-ItemProperty -Name 'managedRuntimeVersion' -Value 'v4.0'

RUN New-Website -Name 'MyAspNetWebForms' -PhysicalPath 'C:\inetpub\Websites\MyAspNetWebForms' -Port 82 -ApplicationPool 'MyAspNetWebForms' -Force; 

EXPOSE 82

COPY ["MyAspNetWebForms", "/inetpub/Websites/MyAspNetWebForms"]

RUN $path='C:\inetpub\Websites\MyAspNetWebForms'; `
    $acl = Get-Acl $path; `
    $newOwner = [System.Security.Principal.NTAccount]('BUILTIN\IIS_IUSRS'); `
    $acl.SetOwner($newOwner); `
    dir -r $path | Set-Acl -aclobject  $acl

COPY configBootStrap.ps1 .
COPY configmappings.json .

ENTRYPOINT ["powershell.exe","C:/configBootStrap.ps1"]
