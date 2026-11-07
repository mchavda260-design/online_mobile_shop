Add-Type -AssemblyName System.Drawing

$imgDir = "d:\ASP.NET\DataBase\DataBase\Comp_Images"
if (!(Test-Path $imgDir)) {
    New-Item -ItemType Directory -Path $imgDir -Force
}

# Generate crisp brand badges for the 6 companies
$companyLogos = @(
    @{ Name="Apple"; File="apple.png"; BgColor=[System.Drawing.Color]::FromArgb(20, 20, 20); TextColor=[System.Drawing.Color]::White; Text="Apple" },
    @{ Name="Samsung"; File="samsung.png"; BgColor=[System.Drawing.Color]::FromArgb(3, 78, 162); TextColor=[System.Drawing.Color]::White; Text="SAMSUNG" },
    @{ Name="Vivo"; File="vivo.png"; BgColor=[System.Drawing.Color]::FromArgb(0, 140, 255); TextColor=[System.Drawing.Color]::White; Text="vivo" },
    @{ Name="Oppo"; File="oppo.png"; BgColor=[System.Drawing.Color]::FromArgb(5, 155, 87); TextColor=[System.Drawing.Color]::White; Text="OPPO" },
    @{ Name="OnePlus"; File="oneplus.png"; BgColor=[System.Drawing.Color]::FromArgb(240, 40, 40); TextColor=[System.Drawing.Color]::White; Text="ONEPLUS" },
    @{ Name="Xiaomi"; File="xiaomi.png"; BgColor=[System.Drawing.Color]::FromArgb(255, 105, 0); TextColor=[System.Drawing.Color]::White; Text="Xiaomi" }
)

Write-Host "Generating cover images for the 6 mobile companies..."
foreach ($item in $companyLogos) {
    $bmp = New-Object System.Drawing.Bitmap(320, 180)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Background
    $bgBrush = New-Object System.Drawing.SolidBrush($item.BgColor)
    $g.FillRectangle($bgBrush, 0, 0, 320, 180)

    # Inner decorative border
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 255, 255, 255), 2)
    $g.DrawRectangle($pen, 10, 10, 300, 160)

    # Brand Text
    $font = New-Object System.Drawing.Font("Arial", 32, [System.Drawing.FontStyle]::Bold)
    $textBrush = New-Object System.Drawing.SolidBrush($item.TextColor)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

    $rect = New-Object System.Drawing.RectangleF(0, 0, 320, 180)
    $g.DrawString($item.Text, $font, $textBrush, $rect, $sf)

    $filePath = Join-Path $imgDir $item.File
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)

    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Created image: $filePath"
}

# Connect to database
Write-Host "`nConnecting to Database..."
$conStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\ASP.NET\DataBase\DataBase\App_Data\Database1.mdf;Integrated Security=True"
$con = New-Object System.Data.SqlClient.SqlConnection($conStr)
$con.Open()

# 1. Clear Add_Products_tbl or update foreign key dependencies first
Write-Host "Cleaning up products table references..."
$cmd = $con.CreateCommand()
$cmd.CommandText = "DELETE FROM Add_Products_tbl"
$cmd.ExecuteNonQuery() | Out-Null
try {
    $cmd.CommandText = "DBCC CHECKIDENT ('Add_Products_tbl', RESEED, 0)"
    $cmd.ExecuteNonQuery() | Out-Null
} catch {}

# 2. Delete old companies & reseed ID
Write-Host "Deleting old company records from Add_Company_tbl..."
$cmd.CommandText = "DELETE FROM Add_Company_tbl"
$deleted = $cmd.ExecuteNonQuery()
Write-Host "Deleted $deleted old company records."

try {
    $cmd.CommandText = "DBCC CHECKIDENT ('Add_Company_tbl', RESEED, 0)"
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Identity reseeded to 0."
} catch {
    Write-Host "Reseed note: $_"
}

# 3. Insert 6 Companies
$companies = @(
    @{ Name="Apple"; Owner="Tim Cook"; Email="contact@apple.com"; Address="Cupertino, California, USA"; Cover="~/Comp_Images/apple.png" },
    @{ Name="Samsung"; Owner="Lee Jae-yong"; Email="contact@samsung.com"; Address="Seoul, South Korea"; Cover="~/Comp_Images/samsung.png" },
    @{ Name="Vivo"; Owner="Shen Wei"; Email="contact@vivo.com"; Address="Dongguan, China"; Cover="~/Comp_Images/vivo.png" },
    @{ Name="Oppo"; Owner="Chen Mingyong"; Email="contact@oppo.com"; Address="Dongguan, China"; Cover="~/Comp_Images/oppo.png" },
    @{ Name="OnePlus"; Owner="Pete Lau"; Email="contact@oneplus.com"; Address="Shenzhen, China"; Cover="~/Comp_Images/oneplus.png" },
    @{ Name="Xiaomi"; Owner="Lei Jun"; Email="contact@xiaomi.com"; Address="Beijing, China"; Cover="~/Comp_Images/xiaomi.png" }
)

Write-Host "`nInserting 6 Mobile Companies..."
foreach ($c in $companies) {
    $insertCmd = $con.CreateCommand()
    $insertCmd.CommandText = "INSERT INTO Add_Company_tbl (Comp_Name, Comp_Owner_Name, Comp_Email, Comp_Address, Comp_Cover_img) VALUES (@Name, @Owner, @Email, @Address, @Cover)"
    $insertCmd.Parameters.AddWithValue("@Name", $c.Name) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Owner", $c.Owner) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Email", $c.Email) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Address", $c.Address) | Out-Null
    $insertCmd.Parameters.AddWithValue("@Cover", $c.Cover) | Out-Null

    $insertCmd.ExecuteNonQuery() | Out-Null
    Write-Host "Inserted company: $($c.Name)"
}

# 4. Insert initial flagship phone products for each of the 6 companies
$products = @(
    @{ CompId=1; Name="iPhone 15 Pro Max"; Model="A3106"; Desc="Flagship iPhone with Titanium body, A17 Pro Chip and 5x Telephoto Zoom."; Weight="221g"; Config="8GB RAM, 256GB Storage, Super Retina XDR Display"; Img="~/Product_Images/apple.png" },
    @{ CompId=2; Name="Galaxy S24 Ultra"; Model="SM-S928B"; Desc="Flagship Samsung Galaxy with Galaxy AI, 200MP Camera and Built-in S-Pen."; Weight="232g"; Config="12GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/samsung.png" },
    @{ CompId=3; Name="Vivo X100 Pro"; Model="V2308"; Desc="Zeiss Optics Camera Smartphone with Dimensity 9300 chipset."; Weight="225g"; Config="16GB RAM, 512GB Storage, 5400mAh Battery"; Img="~/Product_Images/vivo.png" },
    @{ CompId=4; Name="Oppo Find X7 Ultra"; Model="PHY110"; Desc="Quad Main Camera with Dual Periscope Lenses and Hasselblad tuning."; Weight="221g"; Config="16GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/oppo.png" },
    @{ CompId=5; Name="OnePlus 12"; Model="CPH2581"; Desc="Powerful flagship with 4th Gen Hasselblad Camera System and 100W SUPERVOOC charging."; Weight="220g"; Config="16GB RAM, 512GB Storage, 5400mAh Battery"; Img="~/Product_Images/oneplus.png" },
    @{ CompId=6; Name="Xiaomi 14 Ultra"; Model="24030PN60G"; Desc="Leica Quad Camera flagship with 1-inch sensor and Snapdragon 8 Gen 3."; Weight="220g"; Config="16GB RAM, 512GB Storage, 90W HyperCharge"; Img="~/Product_Images/xiaomi.png" }
)

$prodImgDir = "d:\ASP.NET\DataBase\DataBase\Product_Images"
if (!(Test-Path $prodImgDir)) {
    New-Item -ItemType Directory -Path $prodImgDir -Force
}

# Copy brand cover images to product images as fallbacks
foreach ($p in $products) {
    $srcImg = Join-Path $imgDir (Split-Path $p.Img -Leaf)
    $dstImg = Join-Path $prodImgDir (Split-Path $p.Img -Leaf)
    if (Test-Path $srcImg) {
        Copy-Item -Path $srcImg -Destination $dstImg -Force
    }

    $pCmd = $con.CreateCommand()
    $pCmd.CommandText = "INSERT INTO Add_Products_tbl (Prod_Comp_Id, Prod_Name, Prod_Model, Prod_Desc, Prod_Weight, Prod_Config, Prod_Img) VALUES (@CompId, @Name, @Model, @Desc, @Weight, @Config, @Img)"
    $pCmd.Parameters.AddWithValue("@CompId", $p.CompId) | Out-Null
    $pCmd.Parameters.AddWithValue("@Name", $p.Name) | Out-Null
    $pCmd.Parameters.AddWithValue("@Model", $p.Model) | Out-Null
    $pCmd.Parameters.AddWithValue("@Desc", $p.Desc) | Out-Null
    $pCmd.Parameters.AddWithValue("@Weight", $p.Weight) | Out-Null
    $pCmd.Parameters.AddWithValue("@Config", $p.Config) | Out-Null
    $pCmd.Parameters.AddWithValue("@Img", $p.Img) | Out-Null
    $pCmd.ExecuteNonQuery() | Out-Null
    Write-Host "Inserted product: $($p.Name)"
}

Write-Host "`n=== VERIFYING ADD_COMPANY_TBL ==="
$vCmd = $con.CreateCommand()
$vCmd.CommandText = "SELECT Comp_Id, Comp_Name, Comp_Owner_Name, Comp_Email, Comp_Address, Comp_Cover_img FROM Add_Company_tbl"
$r = $vCmd.ExecuteReader()
while ($r.Read()) {
    Write-Host ("ID: " + $r["Comp_Id"] + " | Name: " + $r["Comp_Name"] + " | Owner: " + $r["Comp_Owner_Name"] + " | Email: " + $r["Comp_Email"] + " | Address: " + $r["Comp_Address"] + " | Image: " + $r["Comp_Cover_img"])
}
$r.Close()

$con.Close()
Write-Host "Successfully updated company database!"
