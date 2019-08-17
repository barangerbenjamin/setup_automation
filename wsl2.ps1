Write-Host "------------------------------"
Write-Host "Welcome to Le Wagon WSL2 Setup"
Write-Host "------------------------------"

Write-Host "Checking OS Build Version..."

# Retrieve Windows Edition and Transform it to String
$edition = Get-WindowsEdition -Online | Out-String

# Remove all whitespaces so we can compare it's content later
$edition = $edition -replace '(^\s+|\s+$)','' -replace '\s+',' '

# Retrieve Build version
$version = [System.Environment]::OSVersion.Version.build

# Tranform $version to an Integer
$version = [int]$version

# Prevent the rest of the script to run until $edition and $version are OK
$proceed = $FALSE

# Checking $version and $edition
if($version -ge 18917 -And $edition -eq "Edition : Professional") {
    Write-Host "Current OS build is high enough, proceeding with installation..."
    $proceed = $TRUE
}else {
    if($version -ge 18917) {
        Write-Host "You're currently not running Windows Professional Edition, please upgrade."
    }else {
        Write-Host "Your current OS build is"$version", it should be minimum 18917. Please sign-up to the Windows Insider program at https://insider.windows.com/en-us/ and install all the latest updates. Finally run this script again."
    }
}

if($proceed) {
    Write-Host "Enabling Windows Subsytem Linux..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
}
