# Minimal profile: UTF-8 + Fastfetch with dynamic user path
try {
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    chcp 65001 > $null
} catch {}

Clear-Host

# Dynamically point to Fastfetch config using the current user profile path
$FastfetchConfig = "$env:USERPROFILE\.config\fastfetch\config.jsonc"

if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    if (Test-Path $FastfetchConfig) {
        fastfetch -c $FastfetchConfig
    } else {
        fastfetch
    }
}