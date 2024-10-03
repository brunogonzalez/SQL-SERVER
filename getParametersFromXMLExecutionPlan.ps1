# Load the XML file
[XML]$QueryPlan = Get-Content -Path "PATH_TO_EXECUTIONPLAN.xml"
Write-Output $xmlQueryPlan.NameTable
#Set namespace manager
 [System.Xml.XmlNamespaceManager]$nsMgr = new-object 'System.Xml.XmlNamespaceManager' $QueryPlan.NameTable;
 $nsMgr.AddNamespace("sm", 'http://schemas.microsoft.com/sqlserver/2004/07/showplan');
#Extract the parameters name, type and value
 $QueryPlan.SelectNodes("//sm:ParameterList", $nsMgr) | ForEach-Object {
     $ParameterName=@($_.ColumnReference.Column)
     $ParameterType=@($_.ColumnReference.ParameterDataType)
     $ParameterValue=@($_.ColumnReference.ParameterCompiledValue)
 }
#Print the parameters to build the declare and set statements
foreach ($i in 0..($ParameterName.Count - 1))
{
    Write-Host "Declare $($ParameterName[$i]) $($ParameterType[$i])"
    Write-Host "Set $($ParameterName[$i]) = $($ParameterValue[$i])"
}
#This will give a result like:
#Declare @P1 nvarchar(6)
#Set @P1 = N'210'
