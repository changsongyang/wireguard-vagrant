choco install -y wireshark

Set-Content "$env:USERPROFILE\ConfigureDesktop-WireShark.ps1" @'
Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:USERPROFILE\Desktop\Wireshark.lnk" `
    -TargetPath 'C:\Program Files\Wireshark\Wireshark.exe'
'@

# leave npcap on the desktop for the user to install manually.
# (it does not have a silent installer).
# see https://github.com/nmap/npcap/releases
# see https://npcap.com/#download
$url = 'https://npcap.com/dist/npcap-1.84.exe'
$expectedHash = '90dcda7d4902daf983db653793cf6f91eeaa2de60cdd5fe9c27cdb7da3928910'
$localPath = "$env:USERPROFILE\Desktop\$(Split-Path -Leaf $url)"
(New-Object Net.WebClient).DownloadFile($url, $localPath)
$actualHash = (Get-FileHash $localPath -Algorithm SHA256).Hash
if ($actualHash -ne $expectedHash) {
    throw "downloaded file from $url to $localPath has $actualHash hash that does not match the expected $expectedHash"
}
