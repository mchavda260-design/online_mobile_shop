$conStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\ASP.NET\DataBase\DataBase\App_Data\Database1.mdf;Integrated Security=True"
$con = New-Object System.Data.SqlClient.SqlConnection($conStr)
$con.Open()

$cmd = $con.CreateCommand()
$cmd.CommandText = "SELECT * FROM Add_Products_tbl"
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
