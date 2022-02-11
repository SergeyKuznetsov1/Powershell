$CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
if (-not((New-Object Security.Principal.WindowsPrincipal $currentUser).
    IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)))
{
    Write-Warning "Этот скрипт должен быть запущен с правами администратора"
    break
}

Write-Host -ForegroundColor Green "Всё в порядке, можно работать"