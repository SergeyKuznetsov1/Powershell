$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections'
$data = (Get-ItemProperty -Path $key -Name  DefaultConnectionSettings).DefaultConnectionSettings

if($data[8] -eq 11)
{
$data[8] = 0
Set-ItemProperty -Path $key -Name DefaultConnectionSettings -Value $data
}
elseif ($data[8] -eq 3){
$data[8] = 9
Set-ItemProperty -Path $key -Name DefaultConnectionSettings -Value $data
}