$oldPythonMajorVersion = (Get-Command python).Version.Major
$oldPythonMinorVersion = (Get-Command python).Version.Minor

if ($oldPythonMajorVersion -eq 0) {
    Write-Output "Python is not installed. Execute `install-python.ps1` first."
    exit
}

Write-Output "installing essential libraries"

# update pip
python -m pip install --upgrade pip
pip install pandas openpyxl

Stop-Process -Id $PID
