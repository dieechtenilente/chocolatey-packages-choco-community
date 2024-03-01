
$FilePath = "./googlechrome.msi"
$GoogleThumbprint = "2673EA6CC23BEFFDA49AC715B121544098A1284C"
Invoke-WebRequest -Uri 'https://dl.google.com/dl/chrome/install/googlechromestandaloneenterprise64.msi' -OutFile $FilePath

$File = Get-Item -Path $FilePath

$ShellApplication = New-Object -ComObject Shell.Application

$folder = $ShellApplication.Namespace($File.Directory.FullName)
$file = $folder.ParseName($File.Name)

# Number 24 is the comment field
$GoogleChromeVersion = ($folder.GetDetailsOf($file, 24) -Split " ")[0]

# Check if certificate is valid and thumbprint matches
if (
  (( Get-AuthenticodeSignature .\googlechromestandaloneenterprise64.msi ).Status -eq "Valid") -and 
  (( Get-AuthenticodeSignature .\googlechromestandaloneenterprise64.msi ).SignerCertificate.Thumbprint -eq $GoogleThumbprint))
{
  echo "Executable is valid"
}
