Add-Type -AssemblyName System.Drawing

$imgDir = "d:\ASP.NET\DataBase\DataBase\images"
if (!(Test-Path $imgDir)) {
    New-Item -ItemType Directory -Path $imgDir -Force
}

$colors = @(
    [System.Drawing.Color]::FromArgb(41, 128, 185),   # Blue
    [System.Drawing.Color]::FromArgb(142, 68, 173),   # Purple
    [System.Drawing.Color]::FromArgb(39, 174, 96),    # Green
    [System.Drawing.Color]::FromArgb(230, 126, 34),   # Orange
    [System.Drawing.Color]::FromArgb(231, 76, 60),    # Red
    [System.Drawing.Color]::FromArgb(22, 160, 133),   # Teal
    [System.Drawing.Color]::FromArgb(243, 156, 18),   # Amber
    [System.Drawing.Color]::FromArgb(52, 73, 94),     # Dark Blue
    [System.Drawing.Color]::FromArgb(192, 57, 43),    # Crimson
    [System.Drawing.Color]::FromArgb(155, 89, 182)    # Amethyst
)

$employees = @(
    @{ Name="Aarav Patel"; Initials="AP"; Gender="Male"; Email="aarav.patel@gmail.com"; City="Ahmedabad"; Address="102 Science City Road"; Mobile="9825012345"; Image="~/images/emp1.jpg"; Password="123" },
    @{ Name="Priya Sharma"; Initials="PS"; Gender="Female"; Email="priya.sharma@gmail.com"; City="Rajkot"; Address="405 Kalawad Road"; Mobile="9876543210"; Image="~/images/emp2.jpg"; Password="123" },
    @{ Name="Rohan Mehta"; Initials="RM"; Gender="Male"; Email="rohan.mehta@gmail.com"; City="Surat"; Address="201 Adajan Main Road"; Mobile="9712345678"; Image="~/images/emp3.jpg"; Password="123" },
    @{ Name="Ananya Joshi"; Initials="AJ"; Gender="Female"; Email="ananya.joshi@gmail.com"; City="Vadodara"; Address="304 Alkapuri"; Mobile="9898011223"; Image="~/images/emp4.jpg"; Password="123" },
    @{ Name="Vikram Trivedi"; Initials="VT"; Gender="Male"; Email="vikram.trivedi@gmail.com"; City="Rajkot"; Address="501 Yagnik Road"; Mobile="9426098765"; Image="~/images/emp5.jpg"; Password="123" },
    @{ Name="Neha Vaghela"; Initials="NV"; Gender="Female"; Email="neha.vaghela@gmail.com"; City="Ahmedabad"; Address="602 SG Highway"; Mobile="9879012345"; Image="~/images/emp6.jpg"; Password="123" },
    @{ Name="Parth Solanki"; Initials="PS"; Gender="Male"; Email="parth.solanki@gmail.com"; City="Bhavnagar"; Address="703 Waghawadi Road"; Mobile="9909054321"; Image="~/images/emp7.jpg"; Password="123" },
    @{ Name="Diya Shah"; Initials="DS"; Gender="Female"; Email="diya.shah@gmail.com"; City="Surat"; Address="804 Ghoddod Road"; Mobile="9824067890"; Image="~/images/emp8.jpg"; Password="123" },
    @{ Name="Kunal Jadeja"; Initials="KJ"; Gender="Male"; Email="kunal.jadeja@gmail.com"; City="Jamnagar"; Address="905 Park Colony"; Mobile="9723045678"; Image="~/images/emp9.jpg"; Password="123" },
    @{ Name="Pooja Sikotra"; Initials="PS"; Gender="Female"; Email="pooja.sikotra@gmail.com"; City="Rajkot"; Address="1001 MG Road"; Mobile="9898567890"; Image="~/images/emp10.jpg"; Password="123" }
)

Write-Host "Creating 10 profile images..."
for ($i = 0; $i -lt $employees.Count; $i++) {
    $emp = $employees[$i]
    $bmp = New-Object System.Drawing.Bitmap(200, 200)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    # Background fill
    $bgColor = [System.Drawing.Color]::FromArgb(245, 247, 250)
    $g.Clear($bgColor)

    # Circle background
    $brush = New-Object System.Drawing.SolidBrush($colors[$i % $colors.Count])
    $g.FillEllipse($brush, 10, 10, 180, 180)

    # Initials Text
    $font = New-Object System.Drawing.Font("Arial", 64, [System.Drawing.FontStyle]::Bold)
    $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

    $rect = New-Object System.Drawing.RectangleF(10, 10, 180, 180)
    $g.DrawString($emp.Initials, $font, $whiteBrush, $rect, $sf)

    $fileName = "emp" + ($i + 1) + ".jpg"
    $filePath = Join-Path $imgDir $fileName
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Saved image: $filePath"
}

# Connect to database and update records
Write-Host "`nConnecting to Database..."
$conStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\ASP.NET\DataBase\DataBase\App_Data\Database1.mdf;Integrated Security=True"
$con = New-Object System.Data.SqlClient.SqlConnection($conStr)
$con.Open()

Write-Host "Deleting old records from emp_tbl..."
$cmd = $con.CreateCommand()
$cmd.CommandText = "DELETE FROM emp_tbl"
$deleted = $cmd.ExecuteNonQuery()
Write-Host "Deleted $deleted old records."

# Reset Identity if needed
try {
    $cmd.CommandText = "DBCC CHECKIDENT ('emp_tbl', RESEED, 0)"
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Identity reseeded to 0."
} catch {
    Write-Host "Identity reseed note: $_"
}

Write-Host "`nInserting 10 new employee records..."
foreach ($emp in $employees) {
    $insertCmd = $con.CreateCommand()
    $insertCmd.CommandText = "INSERT INTO emp_tbl (Name, Gender, Email, City, Address, Mobile, Image, Password) VALUES (@Name, @Gender, @Email, @City, @Address, @Mobile, @Image, @Password)"
    
    $insertCmd.Parameters.AddWithValue("@Name", $emp.Name) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Gender", $emp.Gender) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Email", $emp.Email) | Out-Null
    $insertCmd.Parameters.AddWithValue("@City", $emp.City) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Address", $emp.Address) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Mobile", $emp.Mobile) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Image", $emp.Image) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Password", $emp.Password) | Out-Null

    $rows = $insertCmd.ExecuteNonQuery()
    Write-Host "Inserted: $($emp.Name)"
}

Write-Host "`n=== VERIFYING INSERTED DATA ==="
$verifyCmd = $con.CreateCommand()
$verifyCmd.CommandText = "SELECT Id, Name, Gender, Email, City, Address, Mobile, Image, Password FROM emp_tbl"
$reader = $verifyCmd.ExecuteReader()
while ($reader.Read()) {
    Write-Host ("Id: " + $reader["Id"] + " | Name: " + $reader["Name"] + " | Gender: " + $reader["Gender"] + " | Email: " + $reader["Email"] + " | City: " + $reader["City"] + " | Address: " + $reader["Address"] + " | Mobile: " + $reader["Mobile"] + " | Image: " + $reader["Image"] + " | Password: " + $reader["Password"])
}
$reader.Close()

$con.Close()
Write-Host "Done!"
