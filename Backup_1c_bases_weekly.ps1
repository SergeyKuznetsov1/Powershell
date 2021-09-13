# чистим экран)
cls 

#Ежедневное архивирование БД 1c сервера

# это создаем временный массив, для удаления в массиве версий 1с-платформ
$tmp =@()

#узнаем текущий день недели
$date = Get-Date -Format ddMMyyyy

#создание массива с версиями 1с-платформ
$1cversions = dir "C:\Program Files\1cv8" | Select Name

#в массиве убираем "common" и "conf" и всё сохраняем в массив tmp
foreach ($element in $1cversions){
   If (($element.Name -ne 'common') -and ($element.Name -ne 'conf'))
       { $tmp += $element}
   }

# выбираем максиамльную версию
$tmp | sort 


#Формируем путь к 1cv8.exe
$path="C:\Program Files\1cv8\" + $tmp.name[-1] + "\bin\"
#сформировали первую часть запускаемой строки
$pathto1cv8exe = '"'+$path + "1cv8.exe"+'"'
#Base path
$directory="\\FSERVER3\Backups\1C_Backups\Auto\weekly\"
#Делаем архив бухгалтерии UK MORION
$config = "CONFIG /F D:\root\base\Accounting\UKM /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'UKM_Accounting_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "UKM_Accounting.log"
$config
& $pathto1cv8exe $config | out-null
#Делаем архив Зарплаты и кадры UK MORION
$config = "CONFIG /F D:\root\base\HRM\UKM /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'UKM_HRM_'+$date+".dt"+'"'+ " /Out $directory" + 'logs\'+ "UKM_HRM.log"
& $pathto1cv8exe $config | out-null
#Делаем архив бухгалтерии ООО "FORT"
$config = "CONFIG /F D:\root\base\Accounting\Fort /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'Fort_Accounting_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "Fort_Accounting.log"
& $pathto1cv8exe $config | out-null
#Делаем архив Зарплаты и кадры ООО "FORT"
$config = "CONFIG /F D:\root\base\HRM\Fort\3.0 /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'Fort_HRM_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "Fort_HRM.log"
& $pathto1cv8exe $config | out-null
#Делаем архив бухгалтерии ООО "MORION"
$config = "CONFIG /F D:\root\base\accounting\M\3.0 /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'Morion_accounting_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "Morion_Accounting.log"
& $pathto1cv8exe $config | out-null
#Делаем архив Зарплаты и кадры ООО "MORION"
$config = "CONFIG /F D:\root\base\HRM\MORION\3.0 /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'Morion_HRM_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "Morion_HRM.log"
& $pathto1cv8exe $config | out-null
#Делаем архив бухгалтерии ООО "Alfa-MORION"
$config = "CONFIG /F D:\root\base\accounting\AM\3.0 /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'Alfa-Morion_accounting_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "Alfa-Morion_accounting.log"
& $pathto1cv8exe $config | out-null
#Делаем архив Зарплаты и кадры ООО "Alfa-MORION"
$config = "CONFIG /F D:\root\base\HRM\Alfa-Morion\3.0 /N update /P 1sbase /DumpIB" 
$config = $config + '"'+$directory+'Alfa-Morion_HRM_'+$date+".dt"+'"'+ " /Out $directory" +'logs\'+ "Alfa-Morion_HRM.log"
& $pathto1cv8exe $config | out-null

# SIG # Begin signature block
# MIIOUAYJKoZIhvcNAQcCoIIOQTCCDj0CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU9bm+9hqPEJ/8duRLnIEOFVTb
# odOgggn2MIIEmTCCA4GgAwIBAgIPFojwOSVeY45pFDkH5jMLMA0GCSqGSIb3DQEB
# BQUAMIGVMQswCQYDVQQGEwJVUzELMAkGA1UECBMCVVQxFzAVBgNVBAcTDlNhbHQg
# TGFrZSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxITAfBgNV
# BAsTGGh0dHA6Ly93d3cudXNlcnRydXN0LmNvbTEdMBsGA1UEAxMUVVROLVVTRVJG
# aXJzdC1PYmplY3QwHhcNMTUxMjMxMDAwMDAwWhcNMTkwNzA5MTg0MDM2WjCBhDEL
# MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
# BxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKjAoBgNVBAMT
# IUNPTU9ETyBTSEEtMSBUaW1lIFN0YW1waW5nIFNpZ25lcjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBAOnpPd/XNwjJHjiyUlNCbSLxscQGBGue/YJ0UEN9
# xqC7H075AnEmse9D2IOMSPznD5d6muuc3qajDjscRBh1jnilF2n+SRik4rtcTv6O
# KlR6UPDV9syR55l51955lNeWM/4Og74iv2MWLKPdKBuvPavql9LxvwQQ5z1IRf0f
# aGXBf1mZacAiMQxibqdcZQEhsGPEIhgn7ub80gA9Ry6ouIZWXQTcExclbhzfRA8V
# zbfbpVd2Qm8AaIKZ0uPB3vCLlFdM7AiQIiHOIiuYDELmQpOUmJPv/QbZP7xbm1Q8
# ILHuatZHesWrgOkwmt7xpD9VTQoJNIp1KdJprZcPUL/4ygkCAwEAAaOB9DCB8TAf
# BgNVHSMEGDAWgBTa7WR0FJwUPKvdmam9WyhNizzJ2DAdBgNVHQ4EFgQUjmstM2v0
# M6eTsxOapeAK9xI1aogwDgYDVR0PAQH/BAQDAgbAMAwGA1UdEwEB/wQCMAAwFgYD
# VR0lAQH/BAwwCgYIKwYBBQUHAwgwQgYDVR0fBDswOTA3oDWgM4YxaHR0cDovL2Ny
# bC51c2VydHJ1c3QuY29tL1VUTi1VU0VSRmlyc3QtT2JqZWN0LmNybDA1BggrBgEF
# BQcBAQQpMCcwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20w
# DQYJKoZIhvcNAQEFBQADggEBALozJEBAjHzbWJ+zYJiy9cAx/usfblD2CuDk5oGt
# Joei3/2z2vRz8wD7KRuJGxU+22tSkyvErDmB1zxnV5o5NuAoCJrjOU+biQl/e8Vh
# f1mJMiUKaq4aPvCiJ6i2w7iH9xYESEE9XNjsn00gMQTZZaHtzWkHUxY93TYCCojr
# QOUGMAu4Fkvc77xVCf/GPhIudrPczkLv+XZX4bcKBUCYWJpdcRaTcYxlgepv84n3
# +3OttOe/2Y5vqgtPJfO44dXddZhogfiqwNGAwsTEOYnB9smebNd0+dmX+E/CmgrN
# Xo/4GengpZ/E8JIh5i15Jcki+cPwOoRXrToW9GOUEB1d0MYwggVVMIIEPaADAgEC
# AhNiAAAABat2SURxouO1AAAAAAAFMA0GCSqGSIb3DQEBBQUAMEYxEzARBgoJkiaJ
# k/IsZAEZFgNzcGIxFjAUBgoJkiaJk/IsZAEZFgZtb3Jpb24xFzAVBgNVBAMTDm1v
# cmlvbi1WREMxLUNBMB4XDTE4MDMzMDExMDgyNVoXDTIwMDMyOTExMDgyNVowgYUx
# EzARBgoJkiaJk/IsZAEZFgNzcGIxFjAUBgoJkiaJk/IsZAEZFgZtb3Jpb24xFDAS
# BgNVBAsTC0RlcGFydG1lbnRzMRgwFgYDVQQLEw9PU0EgRGVwYXJ0YW1lbnQxJjAk
# BgNVBAMMHdCa0YPQt9C90LXRhtC+0LIg0KHQtdGA0LPQtdC5MIGfMA0GCSqGSIb3
# DQEBAQUAA4GNADCBiQKBgQDOZx8eOoePQDUTaHbhKvV1d+JNFM3oPEBPy6rT11HC
# zrQaQa3+jMIg70ONSdLpySRV0J/r2bVKtP3dOSgAYDNMH3JDcs/lrMXCns31CTNv
# 48h/BVgfhR6G/YLMJ8mqe6SwnCJKCCIHFEIUmUQsK6C/lVNKCSTK7F/4L3sNAHkd
# cQIDAQABo4ICfjCCAnowPQYJKwYBBAGCNxUHBDAwLgYmKwYBBAGCNxUIhq/VIo2B
# DoednR+GusMihuv8EIFehYGIEYO6wQUCAWQCAQIwEwYDVR0lBAwwCgYIKwYBBQUH
# AwMwCwYDVR0PBAQDAgeAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUHAwMwHQYD
# VR0OBBYEFJ1B3ovAIsqKw4Ry27tEo3WEPsDvMB8GA1UdIwQYMBaAFEcNrIh5wIqS
# MPHHNN17u2ZTOkM8MIHIBgNVHR8EgcAwgb0wgbqggbeggbSGgbFsZGFwOi8vL0NO
# PW1vcmlvbi1WREMxLUNBLENOPVZEQzEsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUy
# MFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9bW9yaW9u
# LERDPXNwYj9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xh
# c3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnQwgb8GCCsGAQUFBwEBBIGyMIGvMIGsBggr
# BgEFBQcwAoaBn2xkYXA6Ly8vQ049bW9yaW9uLVZEQzEtQ0EsQ049QUlBLENOPVB1
# YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRp
# b24sREM9bW9yaW9uLERDPXNwYj9jQUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xh
# c3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTAtBgNVHREEJjAkoCIGCisGAQQBgjcU
# AgOgFAwSY29udHJvbEBtb3Jpb24uc3BiMA0GCSqGSIb3DQEBBQUAA4IBAQCUUjjH
# eetX9wMAt7WYGhBMeqiQnIeXUBUDxnFUYCnP3vhAJs3pmyEsCu3VPsbY7M+JWHFU
# SC8UpI6LHcA5CpTDXH6SRFgYBY5J/RaUItfymqahtRJLApi0zGaym1UNV6yxFxTq
# /JC+YVe+idj6zyt6w0282KJicOXce5nP3eJwRAjqXXEZ5XFr8FGIEN4VSrG+jF3P
# g0i3oBGcmO9ZDyGfEItLVTnSxsXIP/4/AbNHLyfBuyRTcGILuUt2FTjLynG0qSet
# cJRbdT5UD56jtBpw5Y9QlhGuPEWq5R5q0CuNQozj+w5eRTRb4CKmvBQ25tIXRtX6
# CET6MckiTHp8wPOZMYIDxDCCA8ACAQEwXTBGMRMwEQYKCZImiZPyLGQBGRYDc3Bi
# MRYwFAYKCZImiZPyLGQBGRYGbW9yaW9uMRcwFQYDVQQDEw5tb3Jpb24tVkRDMS1D
# QQITYgAAAAWrdklEcaLjtQAAAAAABTAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIB
# DDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUQFLNhiCsZxf0
# 3kMC+NuN5kjb+FswDQYJKoZIhvcNAQEBBQAEgYCSj+pI8/A1/Dex6F0aBNsXBgW2
# Nri36sQ+7e9ONLQU02blV44tWdIATlajtoCHTMFKwxhQHO6BHeUcUb0LJELlMe0T
# 7zfUBIZ0n1+CKH6aGEqvrE5tkE6O3hcetC2vvUs5FBS9Z0wJdVdDMZQsVtrJApR8
# A/MArZZ38L87nvf506GCAkMwggI/BgkqhkiG9w0BCQYxggIwMIICLAIBATCBqTCB
# lTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlVUMRcwFQYDVQQHEw5TYWx0IExha2Ug
# Q2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3b3JrMSEwHwYDVQQLExho
# dHRwOi8vd3d3LnVzZXJ0cnVzdC5jb20xHTAbBgNVBAMTFFVUTi1VU0VSRmlyc3Qt
# T2JqZWN0Ag8WiPA5JV5jjmkUOQfmMwswCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDQwMjA5MTc0M1owIwYJ
# KoZIhvcNAQkEMRYEFFon0bLvg/ky84Wcd1CGsmhactAGMA0GCSqGSIb3DQEBAQUA
# BIIBANS5PkhOEUW3BECndriTnLdD5JS9KLBd+V3wc66sUyv2xyGRc+NoNt6vXstE
# q13i7ITOvSlEF7qHeXGkjM+bARlybdJ+sEr/XzWj5XG2QWggyfzCdsh9VMnWUull
# TMmOAsKop1T5r6sbdgSmOXl5gV6gIbWBeIeohQylGACifBYBfzdWp5uI7AYR2rLD
# AWVpyk7DCuZqdpaBDBs9hEfsx/2F/aTZVOJISezoSEYK4n73vANsel+wDhnqkdUO
# vpnBFsqZmV6J8FDvNhFJC/hnnDu2Cdnq19nT5yAehZWvxwJ/w+JEWne5FftTRUzV
# EE3wA/kEWjGALUENWZDGhmGlONs=
# SIG # End signature block
