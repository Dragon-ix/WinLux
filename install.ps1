<#
.SYNOPSIS
    Automated Windows Dotfiles & Rice Installer
#>

[CmdletBinding()]
param()

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "       STARTING WINDOWS DOTFILES SETUP & DEPLOYMENT       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Ensure script is running from its own directory
Set-Location $PSScriptRoot

# --------------------------------------------------------------------------
# 1. INSTALL ESSENTIAL APPLICATIONS & FONTS VIA WINGET
# --------------------------------------------------------------------------
Write-Host "`n[1/7] Installing applications & fonts via Winget..." -ForegroundColor Yellow

$packages = @(
    @{ Id = "LGUG2Z.Komorebi"; Name = "Komorebi" },
    @{ Id = "LGUG2Z.whkd"; Name = "whkd" },
    @{ Id = "AmN.yasb"; Name = "YASB" },
    @{ Id = "Fastfetch-cli.Fastfetch"; Name = "Fastfetch" },
    @{ Id = "Rainmeter.Rainmeter"; Name = "Rainmeter" },
    @{ Id = "RamenSoftware.Windhawk"; Name = "Windhawk" },
    @{ Id = "JetBrains.JetBrainsMono"; Name = "JetBrains Mono Font" }
)

foreach ($pkg in $packages) {
    Write-Host "Checking / Installing $($pkg.Name)..." -ForegroundColor DarkYellow
    winget install --id $pkg.Id -e --accept-package-agreements --accept-source-agreements --silent
}

# --------------------------------------------------------------------------
# 2. INSTALL LOCAL CUSTOM FONTS (FROM REPO FONT FOLDER)
# --------------------------------------------------------------------------
Write-Host "`n[2/7] Installing custom local fonts..." -ForegroundColor Yellow

$FontsDir = "$PSScriptRoot\fonts"
if (Test-Path $FontsDir) {
    $FontFiles = Get-ChildItem -Path $FontsDir -Include *.ttf, *.otf -Recurse
    $UserFontRegistryPath = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    foreach ($font in $FontFiles) {
        $Destination = Join-Path "$env:windir\Fonts" $font.Name
        if (-not (Test-Path $Destination)) {
            Copy-Item $font.FullName -Destination $Destination -Force
            $FontName = $font.BaseName + " (TrueType)"
            New-ItemProperty -Path $UserFontRegistryPath -Name $FontName -Value $font.Name -PropertyType String -Force | Out-Null
            Write-Host " -> Installed custom font: $($font.Name)" -ForegroundColor Green
        }
    }
} else {
    Write-Host " -> No local 'fonts' folder found, skipping custom local fonts." -ForegroundColor DarkGray
}

# --------------------------------------------------------------------------
# 3. DEPLOY POWERSHELL PROFILE & FASTFETCH CONFIG
# --------------------------------------------------------------------------
Write-Host "`n[3/7] Deploying PowerShell Profile & Fastfetch configs..." -ForegroundColor Yellow

# PowerShell Profile
$PSProfileDir = "$env:USERPROFILE\Documents\WindowsPowerShell"
New-Item -ItemType Directory -Force -Path $PSProfileDir | Out-Null
if (Test-Path "$PSScriptRoot\powershell\Microsoft.PowerShell_profile.ps1") {
    Copy-Item -Path "$PSScriptRoot\powershell\Microsoft.PowerShell_profile.ps1" -Destination "$PSProfileDir\Microsoft.PowerShell_profile.ps1" -Force
    Write-Host " -> PowerShell profile deployed." -ForegroundColor Green
}

# Fastfetch Config
$FastfetchDir = "$env:USERPROFILE\.config\fastfetch"
New-Item -ItemType Directory -Force -Path $FastfetchDir | Out-Null
if (Test-Path "$PSScriptRoot\config\fastfetch\config.jsonc") {
    Copy-Item -Path "$PSScriptRoot\config\fastfetch\config.jsonc" -Destination "$FastfetchDir\config.jsonc" -Force
    Write-Host " -> Fastfetch config deployed." -ForegroundColor Green
}

# --------------------------------------------------------------------------
# 4. DEPLOY KOMOREBI & WHKD CONFIGS
# --------------------------------------------------------------------------
Write-Host "`n[4/7] Deploying Komorebi & whkd configurations..." -ForegroundColor Yellow

$KomorebiDir = "$env:LOCALAPPDATA\komorebi"
New-Item -ItemType Directory -Force -Path $KomorebiDir | Out-Null
if (Test-Path "$PSScriptRoot\config\komorebi") {
    Copy-Item -Path "$PSScriptRoot\config\komorebi\*" -Destination $KomorebiDir -Recurse -Force
    Write-Host " -> Komorebi files deployed." -ForegroundColor Green
}

$WhkdDir = "$env:USERPROFILE\.config\whkd"
New-Item -ItemType Directory -Force -Path $WhkdDir | Out-Null
if (Test-Path "$PSScriptRoot\config\whkd") {
    Copy-Item -Path "$PSScriptRoot\config\whkd\*" -Destination $WhkdDir -Recurse -Force
    Write-Host " -> whkd files deployed." -ForegroundColor Green
}

# --------------------------------------------------------------------------
# 5. DEPLOY YASB CONFIGS
# --------------------------------------------------------------------------
Write-Host "`n[5/7] Deploying YASB bar configuration..." -ForegroundColor Yellow

$YasbDir = "$env:USERPROFILE\.config\yasb"
New-Item -ItemType Directory -Force -Path $YasbDir | Out-Null
if (Test-Path "$PSScriptRoot\config\yasb") {
    Copy-Item -Path "$PSScriptRoot\config\yasb\*" -Destination $YasbDir -Recurse -Force
    Write-Host " -> YASB files deployed." -ForegroundColor Green
}

# --------------------------------------------------------------------------
# 6. DEPLOY RAINMETER SKINS
# --------------------------------------------------------------------------
Write-Host "`n[6/7] Deploying Rainmeter custom skins..." -ForegroundColor Yellow

$RainmeterSkinsDir = "$env:USERPROFILE\Documents\Rainmeter\Skins"
New-Item -ItemType Directory -Force -Path $RainmeterSkinsDir | Out-Null
if (Test-Path "$PSScriptRoot\config\rainmeter") {
    Copy-Item -Path "$PSScriptRoot\config\rainmeter\*" -Destination $RainmeterSkinsDir -Recurse -Force
    Write-Host " -> Rainmeter skins deployed." -ForegroundColor Green
}

# --------------------------------------------------------------------------
# 7. DEPLOY WINDHAWK MODS & SETTINGS
# --------------------------------------------------------------------------
Write-Host "`n[7/7] Deploying Windhawk mods and registry settings..." -ForegroundColor Yellow

$WindhawkProgData = "C:\ProgramData\Windhawk"
New-Item -ItemType Directory -Force -Path "$WindhawkProgData\Engine" | Out-Null

if (Test-Path "$PSScriptRoot\config\windhawk\ModsSource") {
    Copy-Item -Path "$PSScriptRoot\config\windhawk\ModsSource" -Destination $WindhawkProgData -Recurse -Force
}
if (Test-Path "$PSScriptRoot\config\windhawk\Engine\Mods") {
    Copy-Item -Path "$PSScriptRoot\config\windhawk\Engine\Mods" -Destination "$WindhawkProgData\Engine" -Recurse -Force
}

$RegFile = "$PSScriptRoot\config\windhawk\windhawk_settings.reg"
if (Test-Path $RegFile) {
    Start-Process reg.exe -ArgumentList "import `"$RegFile`"" -NoNewWindow -Wait
    Write-Host " -> Windhawk registry settings imported." -ForegroundColor Green
}

Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "       WINDOWS DOTFILES DEPLOYMENT SUCCESSFULLY FINISHED!       " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green
Write-Host "Restart your PowerShell terminal or initialize Komorebi to see your rice!" -ForegroundColor Cyan