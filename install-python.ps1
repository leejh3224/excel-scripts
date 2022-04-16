$oldPythonMajorVersion = (Get-Command python).Version.Major
$oldPythonMinorVersion = (Get-Command python).Version.Minor

# if python is not installed, `Get-Command python` returns 0 for all versions, i.e. 0.0.0.0
if ($oldPythonMajorVersion -ne 0) {
    Write-Output "Python is already installed, found: $oldPythonMajorVersion.$oldPythonMinorVersion"
    exit
}

Write-Output "Python executable not exists. Continue..."

# change this version to install other python versions
$pythonVersion = "3.10.0"

# directory where python installer be installed
$pythonParentDir = "C:\Tools"

# architecture of the machine, default intel64
$hostArch = "amd64"

$pythonUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion-$hostArch.exe"
$pythonDownloadPath = "$pythonParentDir\python-$pythonVersion.exe"
$pythonInstallDir = "$pythonParentDir\Python$pythonVersion"

# if folder not exists, create new one
if (-not(Test-Path -Path $pythonParentDir)) {
    New-Item $pythonParentDir -ItemType Directory | Out-Null
    Write-Output "Successfully created dir: $pythonParentDir"
} else {
    Write-Output "$pythonParentDir is already in use!"
    exit
}

# download python installer
(New-Object Net.WebClient).DownloadFile($pythonUrl, $pythonDownloadPath)

Write-Output "installed python:$pythonVersion installer"

# execute python installer
& $pythonDownloadPath InstallAllUsers=1 PrependPath=1 Include_test=0

Write-Output "Python successfully installed!"

Stop-Process -Id $PID
