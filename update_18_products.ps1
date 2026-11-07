Add-Type -AssemblyName System.Drawing

$prodDir = "d:\ASP.NET\DataBase\DataBase\Product_Images"
if (!(Test-Path $prodDir)) {
    New-Item -ItemType Directory -Path $prodDir -Force
}

$products = @(
    # --- APPLE (Comp_Id: 1) ---
    @{ CompId=1; Name="iPhone 15 Pro Max"; Model="A3106"; Desc="Titanium design, A17 Pro chip, 5x Telephoto camera."; Weight="221g"; Config="8GB RAM, 256GB Storage, 6.7`" Super Retina XDR"; Img="~/Product_Images/apple_iphone15promax.png"; File="apple_iphone15promax.png"; Brand="Apple"; Color=[System.Drawing.Color]::FromArgb(40, 40, 40) },
    @{ CompId=1; Name="iPhone 15"; Model="A3090"; Desc="Dynamic Island, 48MP Main camera, USB-C, Durable design."; Weight="171g"; Config="6GB RAM, 128GB Storage, 6.1`" Super Retina XDR"; Img="~/Product_Images/apple_iphone15.png"; File="apple_iphone15.png"; Brand="Apple"; Color=[System.Drawing.Color]::FromArgb(60, 60, 60) },
    @{ CompId=1; Name="iPhone 14"; Model="A2882"; Desc="Super Retina XDR display, Advanced dual-camera system."; Weight="172g"; Config="6GB RAM, 128GB Storage, A15 Bionic Chip"; Img="~/Product_Images/apple_iphone14.png"; File="apple_iphone14.png"; Brand="Apple"; Color=[System.Drawing.Color]::FromArgb(80, 80, 80) },

    # --- SAMSUNG (Comp_Id: 2) ---
    @{ CompId=2; Name="Galaxy S24 Ultra"; Model="SM-S928B"; Desc="Galaxy AI features, 200MP Quad camera, Titanium frame, Built-in S Pen."; Weight="232g"; Config="12GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/samsung_s24ultra.png"; File="samsung_s24ultra.png"; Brand="Samsung"; Color=[System.Drawing.Color]::FromArgb(10, 60, 150) },
    @{ CompId=2; Name="Galaxy Z Fold5"; Model="SM-F946B"; Desc="Foldable 7.6`" Main display, Armor Aluminum frame, Flex Hinge."; Weight="253g"; Config="12GB RAM, 512GB Storage, Snapdragon 8 Gen 2"; Img="~/Product_Images/samsung_zfold5.png"; File="samsung_zfold5.png"; Brand="Samsung"; Color=[System.Drawing.Color]::FromArgb(20, 80, 180) },
    @{ CompId=2; Name="Galaxy A55 5G"; Model="SM-A556B"; Desc="Premium glass back, Metal frame, 50MP OIS camera, 5000mAh battery."; Weight="213g"; Config="8GB RAM, 256GB Storage, Exynos 1480"; Img="~/Product_Images/samsung_a55.png"; File="samsung_a55.png"; Brand="Samsung"; Color=[System.Drawing.Color]::FromArgb(30, 100, 200) },

    # --- VIVO (Comp_Id: 3) ---
    @{ CompId=3; Name="Vivo X100 Pro"; Model="V2308"; Desc="ZEISS APO Floating Telephoto camera, Dimensity 9300 chip."; Weight="225g"; Config="16GB RAM, 512GB Storage, 5400mAh Battery"; Img="~/Product_Images/vivo_x100pro.png"; File="vivo_x100pro.png"; Brand="Vivo"; Color=[System.Drawing.Color]::FromArgb(0, 120, 230) },
    @{ CompId=3; Name="Vivo V30 Pro"; Model="V2319"; Desc="ZEISS Professional Portrait Camera, Studio Quality Aura Light."; Weight="188g"; Config="12GB RAM, 512GB Storage, Dimensity 8200"; Img="~/Product_Images/vivo_v30pro.png"; File="vivo_v30pro.png"; Brand="Vivo"; Color=[System.Drawing.Color]::FromArgb(0, 150, 255) },
    @{ CompId=3; Name="Vivo Y200e 5G"; Model="V2336"; Desc="Eco-Fiber Leather finish, 120Hz AMOLED display, 50MP HD Camera."; Weight="191g"; Config="8GB RAM, 128GB Storage, Snapdragon 4 Gen 2"; Img="~/Product_Images/vivo_y200e.png"; File="vivo_y200e.png"; Brand="Vivo"; Color=[System.Drawing.Color]::FromArgb(0, 175, 255) },

    # --- OPPO (Comp_Id: 4) ---
    @{ CompId=4; Name="Oppo Find X7 Ultra"; Model="PHY110"; Desc="World's first Quad Main Camera with Dual Periscope Telephoto."; Weight="221g"; Config="16GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/oppo_findx7ultra.png"; File="oppo_findx7ultra.png"; Brand="Oppo"; Color=[System.Drawing.Color]::FromArgb(5, 140, 75) },
    @{ CompId=4; Name="Oppo Reno 11 Pro 5G"; Model="CPH2607"; Desc="32MP Telephoto Portrait Camera, 80W SUPERVOOC charging."; Weight="181g"; Config="12GB RAM, 256GB Storage, Dimensity 8200"; Img="~/Product_Images/oppo_reno11pro.png"; File="oppo_reno11pro.png"; Brand="Oppo"; Color=[System.Drawing.Color]::FromArgb(10, 165, 90) },
    @{ CompId=4; Name="Oppo F25 Pro 5G"; Model="CPH2603"; Desc="Ultra-slim 7.54mm body, 4K video recording, 64MP Triple Camera."; Weight="177g"; Config="8GB RAM, 256GB Storage, Dimensity 7050"; Img="~/Product_Images/oppo_f25pro.png"; File="oppo_f25pro.png"; Brand="Oppo"; Color=[System.Drawing.Color]::FromArgb(15, 185, 105) },

    # --- ONEPLUS (Comp_Id: 5) ---
    @{ CompId=5; Name="OnePlus 12"; Model="CPH2581"; Desc="4th Gen Hasselblad Camera, 2K 120Hz ProXDR display, 100W charging."; Weight="220g"; Config="16GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/oneplus_12.png"; File="oneplus_12.png"; Brand="OnePlus"; Color=[System.Drawing.Color]::FromArgb(210, 30, 30) },
    @{ CompId=5; Name="OnePlus 12R"; Model="CPH2585"; Desc="1.5K 4th Gen LTPO display, 5500mAh largest battery, 100W charging."; Weight="207g"; Config="16GB RAM, 256GB Storage, Snapdragon 8 Gen 2"; Img="~/Product_Images/oneplus_12r.png"; File="oneplus_12r.png"; Brand="OnePlus"; Color=[System.Drawing.Color]::FromArgb(230, 50, 50) },
    @{ CompId=5; Name="OnePlus Nord CE4"; Model="CPH2613"; Desc="Sony LYT-600 OIS camera, 100W SUPERVOOC fast charging."; Weight="186g"; Config="8GB RAM, 256GB Storage, Snapdragon 7 Gen 3"; Img="~/Product_Images/oneplus_nordce4.png"; File="oneplus_nordce4.png"; Brand="OnePlus"; Color=[System.Drawing.Color]::FromArgb(245, 70, 70) },

    # --- XIAOMI (Comp_Id: 6) ---
    @{ CompId=6; Name="Xiaomi 14 Ultra"; Model="24030PN60G"; Desc="Leica Quad Camera with 1-inch Sony LYT-900 sensor."; Weight="220g"; Config="16GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/xiaomi_14ultra.png"; File="xiaomi_14ultra.png"; Brand="Xiaomi"; Color=[System.Drawing.Color]::FromArgb(240, 95, 0) },
    @{ CompId=6; Name="Xiaomi 14"; Model="23127PN0CG"; Desc="Compact flagship, Leica Summilux optical lens, 90W HyperCharge."; Weight="193g"; Config="12GB RAM, 512GB Storage, Snapdragon 8 Gen 3"; Img="~/Product_Images/xiaomi_14.png"; File="xiaomi_14.png"; Brand="Xiaomi"; Color=[System.Drawing.Color]::FromArgb(250, 115, 15) },
    @{ CompId=6; Name="Redmi Note 13 Pro+ 5G"; Model="23090RA98I"; Desc="200MP OIS Camera, Curved 120Hz AMOLED display, 120W HyperCharge."; Weight="204g"; Config="12GB RAM, 512GB Storage, Dimensity 7200 Ultra"; Img="~/Product_Images/xiaomi_redminote13pro.png"; File="xiaomi_redminote13pro.png"; Brand="Xiaomi"; Color=[System.Drawing.Color]::FromArgb(255, 135, 30) }
)

Write-Host "Generating 18 high-quality product images..."
foreach ($p in $products) {
    $bmp = New-Object System.Drawing.Bitmap(350, 260)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    # Outer background
    $g.Clear([System.Drawing.Color]::FromArgb(245, 247, 250))

    # Header Card Background
    $cardBrush = New-Object System.Drawing.SolidBrush($p.Color)
    $g.FillRectangle($cardBrush, 15, 15, 320, 160)

    # Smartphone graphic representation
    $phonePen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 3)
    $g.DrawRectangle($phonePen, 35, 35, 80, 120)
    
    # Camera lens on phone graphic
    $lensBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(200, 255, 255, 255))
    $g.FillEllipse($lensBrush, 65, 45, 20, 20)
    $g.FillEllipse($lensBrush, 65, 75, 15, 15)

    # Brand Title in header
    $brandFont = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $g.DrawString($p.Brand.ToUpper(), $brandFont, $whiteBrush, 135, 35)

    # Model Name
    $modelFont = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $rect = New-Object System.Drawing.RectangleF(135, 60, 190, 60)
    $sf = New-Object System.Drawing.StringFormat
    $g.DrawString($p.Name, $modelFont, $whiteBrush, $rect, $sf)

    # Model Number tag inside header
    $tagFont = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Italic)
    $g.DrawString("Model: " + $p.Model, $tagFont, $whiteBrush, 135, 125)

    # Bottom Footer Info Bar
    $footerBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $g.FillRectangle($footerBrush, 15, 185, 320, 60)
    $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(220, 224, 230), 1)
    $g.DrawRectangle($borderPen, 15, 185, 320, 60)

    # Specs in Footer Bar
    $specFont = New-Object System.Drawing.Font("Segoe UI", 8.5, [System.Drawing.FontStyle]::Regular)
    $darkBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(50, 50, 50))
    $g.DrawString("Weight: " + $p.Weight, $specFont, $darkBrush, 25, 192)
    $g.DrawString("Config: " + $p.Config, $specFont, $darkBrush, 25, 212)

    # Save image file
    $filePath = Join-Path $prodDir $p.File
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)

    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Saved product image: $filePath"
}

# Connect to database and populate Add_Products_tbl
Write-Host "`nConnecting to Database..."
$conStr = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=D:\ASP.NET\DataBase\DataBase\App_Data\Database1.mdf;Integrated Security=True"
$con = New-Object System.Data.SqlClient.SqlConnection($conStr)
$con.Open()

Write-Host "Deleting old products from Add_Products_tbl..."
$cmd = $con.CreateCommand()
$cmd.CommandText = "DELETE FROM Add_Products_tbl"
$deleted = $cmd.ExecuteNonQuery()
Write-Host "Deleted $deleted old products."

try {
    $cmd.CommandText = "DBCC CHECKIDENT ('Add_Products_tbl', RESEED, 0)"
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "Identity reseeded to 0."
} catch {
    Write-Host "Reseed note: $_"
}

Write-Host "`nInserting 18 flagship mobile products (3 for each of the 6 companies)..."
foreach ($p in $products) {
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
    Write-Host "Inserted Product ID (Comp: $($p.CompId)): $($p.Name)"
}

Write-Host "`n=== VERIFYING ADD_PRODUCTS_TBL (Total 18 Products) ==="
$vCmd = $con.CreateCommand()
$vCmd.CommandText = "SELECT Prod_Id, Prod_Comp_Id, Prod_Name, Prod_Model, Prod_Weight, Prod_Img FROM Add_Products_tbl"
$r = $vCmd.ExecuteReader()
while ($r.Read()) {
    Write-Host ("ID: " + $r["Prod_Id"] + " | CompID: " + $r["Prod_Comp_Id"] + " | Name: " + $r["Prod_Name"] + " | Model: " + $r["Prod_Model"] + " | Image: " + $r["Prod_Img"])
}
$r.Close()

$con.Close()
Write-Host "Done! Successfully updated 18 products across 6 companies."
