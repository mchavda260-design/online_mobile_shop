$conStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\ASP.NET\DataBase\DataBase\App_Data\Database1.mdf;Integrated Security=True"
$con = New-Object System.Data.SqlClient.SqlConnection($conStr)
$con.Open()

Write-Host "=== ADD_COMPANY_TBL COLUMNS ==="
$cmd = $con.CreateCommand()
$cmd.CommandText = "SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Add_Company_tbl'"
$r = $cmd.ExecuteReader()
while ($r.Read()) {
    Write-Host ($r[0] + " (" + $r[1] + ")")
}
$r.Close()

Write-Host "`n=== CURRENT ADD_COMPANY_TBL DATA ==="
$cmd.CommandText = "SELECT * FROM Add_Company_tbl"
$r = $cmd.ExecuteReader()
while ($r.Read()) {
    $rowStr = ""
    for ($i = 0; $i -lt $r.FieldCount; $i++) {
        $rowStr += $r.GetName($i) + ":" + $r[$i] + " | "
    }
    Write-Host $rowStr
}
$r.Close()

$con.Close()
