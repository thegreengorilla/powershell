﻿# The parameters below are dependent upon having an Alert Template format that matches the below line (you can copy and paste it) 
#  
# C:\___ScriptLocation___\Varonis.PS1 ‘<Rule ID>’ ‘<Rule Name>’ <Acting Object>’ ‘<Affected Object>’ ‘<Event Time>’ ‘<Alert Time>’ ‘<File Server/Domain>’ ‘<Event Type>’ ‘<IP Address/Host>’ ‘<Severity>’ ‘<Path>’
function Varonis{}

$ruleID = $args[0]
$ruleName = $args[1]
$alertTime = $args[2]
$eventTime = $args[3]
$actingObject = $args[4]
$fileServerDomain = $args[5]
$path = $args[6]
$affectedObject = $args[7]
$eventType = $args[8]
$ipAddressHost = $args[9]
$severity = $args[10]

Export-ModuleMember -Variable ruleName
Export-ModuleMember -Variable ruleID
Export-ModuleMember -Variable actingObject
Export-ModuleMember -Variable affectedobject
Export-ModuleMember -Variable eventTime
Export-ModuleMember -Variable alertTime
Export-ModuleMember -Variable fileServerDomain
Export-ModuleMember -Variable ipAddressHost
Export-ModuleMember -Variable severity
Export-ModuleMember -Variable path

