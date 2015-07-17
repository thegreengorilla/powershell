-Import-Module Varonis -Force -ArgumentList $args

$ADuser = $ActingObject.trimstart("YourDomain.com")
$ADuser = $ADuser.trimstart("\")
$ADFilter = get-aduser -Filter { displayName -like $ADuser} | select sAMAccountName

Disable-ADAccount -Identity $ADFilter.sAMAccountName

