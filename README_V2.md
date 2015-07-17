
<p align='center'>
<img src='https://raw.githubusercontent.com/varonis/powershell/master/assets/logos.png'>
</p>


#Varonis PowerShell Resource Kit


This repository is a collection of PowerShell scripts, modules and resources to extend the functionality of the Varonis Software Suite.

--- 

## Current Status

The scripts included in this repository are being actively worked on and should not be considered ready for production use. It is expected that the names and directions will most likely undergo large breaking changes.

They are provided here for review and community input as we work to test, document and release them.

## Getting Started

### Prerequisites

- PowerShell 3.0
- DatAlert 5.9+
- Admin Rights for Installation

### Getting Started

#### 1. Configure DatAlert for Executable Scripts
The first step is to configure DatAlert with the right settings. 
Open DatAlert (Tools --> DatAlert), Click on the tab Configuration. Scroll down to Executable script.
<img src='https://raw.githubusercontent.com/varonis/powershell/master/assets/DatAlert_Config.png'>

You need to provide the credentials that will be used to run the script. Preferably Local administrator on the Varonis IDU/Collector/Probe. 
The Script path must be an UNC path to your executable or bat file. We will use PowerShell, so let’s use the following path for PowerShell
\\COMPUTERNAME\C$\Windows\system32\WindowsPowerShell\V1.0\Powershell.exe

**Note: The script must be launched of the IDU/probe/collector that is serving the monitored device.**


#### 2. Install the Varonis PowerShell Module
In the root of the repository is a file: `varonis.psm1` which should be copied to the below path:
C:\Windows\system32\Windows Powershell V1.0\Modules\Varonis\varonis.PSM1
If the folder "varonis" does not exist, you may create it.

NOTE: This needs to be done on the IDU/Probe/Collector that is serving the monitored device.
<img src='https://raw.githubusercontent.com/varonis/powershell/master/assets/Varonis_PowerShell_Location.png'>

The varonis PS Module will gather the information out of the alert and store them in variables, in order to reuse them. It will be stored in an array $args (Arguments).

#### 3. Configure an Alert Template in Varonis DatAlert

The Varonis PowerShell Module relies upon a specific configuration of the Real Time Alert Template. A new Real Time Alert Template should be created that has the following format:
Open DatAlert (Tools --> DatAlert), Click on the tab Alert Templates. Create a new alert Template.
<img src='https://raw.githubusercontent.com/varonis/powershell/master/assets/DL_AlertTemplate_New.png'>

**Note: Always start with the script path, for instance C:\ ___ScriptLocation___ \VaronisTest.PS1**

**Note: Make sure to have the right syntax as provided below, otherwise the script will not run.**

```powershell
 C:\___ScriptLocation___\Varonis.PS1 ‘<Rule ID>’ ‘<Rule Name>’’ <Acting Object>’ ‘<Affected Object>’ ‘<Event Time>’ ‘<Alert Time>’ ‘<File Server/Domain>’ ‘<Event Type>’ ‘<IP Address/Host>’ ‘<Severity>’ ‘<Path>’
```
See above example:

The field order of the template must exactly match that of the above or variables won't be passed correctly into the PowerShell scripts as they are called.

During your DatAlert setup you'll have the option to specify an executable script to run, at this time you should choose:

```powershell
C:\Windows\System32\WindowsPowershell\v1.0\powershell.exe
```

If you're not sure where your PowerShell executable is located you can run ```$PsHome``` from within a PowerShell command window. 

**Note: Microsoft puts all PowerShell versions in a \v1.0\ folder, because things were not sufficiently complicated.**

#### 4. Set the Alert Method

Rules can be edited to include multiple Alert Methods - to enable PowerShell scripting you'll need to check 'Command-line script' under Edit Rule > Alert Method.
Alert Method – as already mentioned previously, select Event Log & Executable Script.
It is important that you setup the Command Line Alert Template first or the 'Command-line script' Alert Method checkbox will be disabled.

**Note: We recommend to select both checkboxes, Executable Script & Event Log, This allows you to crosscheck the eventViewer as well, for DatAlert rules that are triggered.**

<img src='https://raw.githubusercontent.com/varonis/powershell/master/assets/Alert_Method.png'>

#### 5. Import the Varonis Module to a PowerShell Script

At the beginning of a new PowerShell script, include the following line:

```powershell
Import-Module Varonis -Force -ArgumentList $args
```

This will pass the arguments specified in the Alert Template into the script as referenceable variables. 

This greatly improves the ease with which new scripts can be written as the variables are exposed as first class PowerShell objects; which will be available in PowerShell ISE and behave accordingly. 

The variables are:

```powershell
	$ruleID
	$ruleName
	$alertTime
	$eventTime
	$actingObject
	$fileServerDomain
	$path
	$affectedObject
	$eventType
	$ipAddressHost
	$severity
```

This greatly simplifies the development of scripts, often to a single line:
	
ex: 
```powershell
Disable-ADAccount -Identity $actingObject
```

Additional example scripts utilizing this technique are included in the `scripts` directory. 

---- 

We welcome feedback on this ongoing project in our Varonis Connect Developer Community:

[https://connect.varonis.com/community/developer-community](https://connect.varonis.com/community/developer-community)
