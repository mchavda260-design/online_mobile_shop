$conStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\ASP.NET\DataBase\DataBase\App_Data\Database1.mdf;Integrated Security=True"
$con = New-Object System.Data.SqlClient.SqlConnection($conStr)
$con.Open()

Write-Host "=== CART_TBL COLUMNS ==="
$cmd = $con.CreateCommand()
$cmd.CommandText = "SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'cart_tbl'"
$r = $cmd.ExecuteReader()
while ($r.Read()) {
    Write-Host ($r[0] + " (" + $r[1] + ")")
}
$r.Close()
$con.Close()
