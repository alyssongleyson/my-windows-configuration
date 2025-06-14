# Elevate permissions if necessary
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This script needs to be run as administrator."
    exit 1
}

# Install Chocolatey (if not already installed)
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Wait for the choco to be loaded
Start-Sleep -Seconds 5
refreshenv

# List of software to install
$softwares = @(
    "bitwarden",
    "brave",
    "dropbox",
    "epicgameslauncher",
    "evernote",
    "goggalaxy",
    "googlechrome",
    "obsidian",
    "steam",
    "ubisoft-connect",
    "virtualbox",
    "vscode"
)

# Installation of each program
foreach ($sofware in $softwares) {
    Write-Host "Installing $software..." -ForegroundColor Cyan
    choco install $sofware -y --ignore-checksums
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$Software installed successfully." -ForegroundColor Green
    } else {
        Write-Host "Erro installing $software." -ForegroundColor Red
    }
}
