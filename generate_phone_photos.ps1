Add-Type -AssemblyName System.Drawing

$prodDir = "d:\ASP.NET\DataBase\DataBase\Product_Images"
if (!(Test-Path $prodDir)) {
    New-Item -ItemType Directory -Path $prodDir -Force
}

$phoneList = @(
    # --- APPLE ---
    @{ File="apple_iphone15promax.png"; Style="ApplePro"; BodyColor=[System.Drawing.Color]::FromArgb(120, 122, 125); ScreenGrad=@([System.Drawing.Color]::FromArgb(40, 50, 70), [System.Drawing.Color]::FromArgb(100, 120, 160)); CameraStyle="TripleIslands" },
    @{ File="apple_iphone15.png"; Style="AppleBase"; BodyColor=[System.Drawing.Color]::FromArgb(230, 200, 210); ScreenGrad=@([System.Drawing.Color]::FromArgb(255, 180, 200), [System.Drawing.Color]::FromArgb(200, 140, 180)); CameraStyle="DiagonalDual" },
    @{ File="apple_iphone14.png"; Style="AppleBase"; BodyColor=[System.Drawing.Color]::FromArgb(50, 80, 120); ScreenGrad=@([System.Drawing.Color]::FromArgb(30, 60, 100), [System.Drawing.Color]::FromArgb(80, 120, 180)); CameraStyle="DiagonalDual" },

    # --- SAMSUNG ---
    @{ File="samsung_s24ultra.png"; Style="SamsungUltra"; BodyColor=[System.Drawing.Color]::FromArgb(35, 38, 45); ScreenGrad=@([System.Drawing.Color]::FromArgb(20, 30, 50), [System.Drawing.Color]::FromArgb(60, 100, 160)); CameraStyle="QuadSeparate" },
    @{ File="samsung_zfold5.png"; Style="Foldable"; BodyColor=[System.Drawing.Color]::FromArgb(210, 215, 220); ScreenGrad=@([System.Drawing.Color]::FromArgb(10, 20, 40), [System.Drawing.Color]::FromArgb(50, 80, 130)); CameraStyle="VerticalTriple" },
    @{ File="samsung_a55.png"; Style="SamsungNormal"; BodyColor=[System.Drawing.Color]::FromArgb(190, 220, 240); ScreenGrad=@([System.Drawing.Color]::FromArgb(150, 200, 250), [System.Drawing.Color]::FromArgb(100, 150, 220)); CameraStyle="VerticalTriple" },

    # --- VIVO ---
    @{ File="vivo_x100pro.png"; Style="CircleCamera"; BodyColor=[System.Drawing.Color]::FromArgb(25, 30, 45); ScreenGrad=@([System.Drawing.Color]::FromArgb(10, 30, 60), [System.Drawing.Color]::FromArgb(0, 150, 255)); CameraStyle="LargeCircle" },
    @{ File="vivo_v30pro.png"; Style="SquareCamera"; BodyColor=[System.Drawing.Color]::FromArgb(180, 230, 240); ScreenGrad=@([System.Drawing.Color]::FromArgb(100, 210, 235), [System.Drawing.Color]::FromArgb(40, 160, 200)); CameraStyle="AuraSquare" },
    @{ File="vivo_y200e.png"; Style="Normal"; BodyColor=[System.Drawing.Color]::FromArgb(235, 120, 50); ScreenGrad=@([System.Drawing.Color]::FromArgb(240, 140, 70), [System.Drawing.Color]::FromArgb(200, 80, 20)); CameraStyle="VerticalTriple" },

    # --- OPPO ---
    @{ File="oppo_findx7ultra.png"; Style="CircleCamera"; BodyColor=[System.Drawing.Color]::FromArgb(220, 210, 195); ScreenGrad=@([System.Drawing.Color]::FromArgb(40, 35, 30), [System.Drawing.Color]::FromArgb(140, 120, 90)); CameraStyle="LargeCircleTwoTone" },
    @{ File="oppo_reno11pro.png"; Style="PillCamera"; BodyColor=[System.Drawing.Color]::FromArgb(230, 245, 240); ScreenGrad=@([System.Drawing.Color]::FromArgb(150, 230, 210), [System.Drawing.Color]::FromArgb(60, 170, 150)); CameraStyle="OvalPill" },
    @{ File="oppo_f25pro.png"; Style="SquareCamera"; BodyColor=[System.Drawing.Color]::FromArgb(130, 40, 70); ScreenGrad=@([System.Drawing.Color]::FromArgb(180, 50, 90), [System.Drawing.Color]::FromArgb(90, 20, 50)); CameraStyle="RectTriple" },

    # --- ONEPLUS ---
    @{ File="oneplus_12.png"; Style="OffsetCircle"; BodyColor=[System.Drawing.Color]::FromArgb(25, 65, 55); ScreenGrad=@([System.Drawing.Color]::FromArgb(15, 45, 38), [System.Drawing.Color]::FromArgb(45, 120, 100)); CameraStyle="OffsetDial" },
    @{ File="oneplus_12r.png"; Style="OffsetCircle"; BodyColor=[System.Drawing.Color]::FromArgb(50, 75, 110); ScreenGrad=@([System.Drawing.Color]::FromArgb(25, 45, 75), [System.Drawing.Color]::FromArgb(75, 120, 175)); CameraStyle="OffsetDial" },
    @{ File="oneplus_nordce4.png"; Style="PillCamera"; BodyColor=[System.Drawing.Color]::FromArgb(210, 240, 230); ScreenGrad=@([System.Drawing.Color]::FromArgb(160, 220, 200), [System.Drawing.Color]::FromArgb(80, 170, 140)); CameraStyle="PillVertical" },

    # --- XIAOMI ---
    @{ File="xiaomi_14ultra.png"; Style="CircleCamera"; BodyColor=[System.Drawing.Color]::FromArgb(240, 240, 242); ScreenGrad=@([System.Drawing.Color]::FromArgb(30, 30, 35), [System.Drawing.Color]::FromArgb(100, 100, 110)); CameraStyle="LeicaMassive" },
    @{ File="xiaomi_14.png"; Style="SquareCamera"; BodyColor=[System.Drawing.Color]::FromArgb(60, 130, 90); ScreenGrad=@([System.Drawing.Color]::FromArgb(35, 80, 55), [System.Drawing.Color]::FromArgb(90, 180, 130)); CameraStyle="SquareQuad" },
    @{ File="xiaomi_redminote13pro.png"; Style="Normal"; BodyColor=[System.Drawing.Color]::FromArgb(215, 205, 235); ScreenGrad=@([System.Drawing.Color]::FromArgb(160, 140, 210), [System.Drawing.Color]::FromArgb(100, 80, 160)); CameraStyle="CleanGlass" }
)

Write-Host "Rendering 18 realistic 3D smartphone product photos..."

foreach ($p in $phoneList) {
    $bmp = New-Object System.Drawing.Bitmap(400, 400)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    # Clean Studio Backdrop
    $bgBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        (New-Object System.Drawing.Point(0,0)), 
        (New-Object System.Drawing.Point(0,400)), 
        [System.Drawing.Color]::FromArgb(248, 249, 252), 
        [System.Drawing.Color]::FromArgb(232, 236, 242)
    )
    $g.FillRectangle($bgBrush, 0, 0, 400, 400)

    # Soft 3D Shadow under the phone
    $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35, 120, 130, 150))
    $g.FillEllipse($shadowBrush, 90, 355, 220, 25)

    if ($p.Style -eq "Foldable") {
        # --- DRAW FOLDABLE PHONE (Z Fold 5) ---
        # Outer Screen
        $outerPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(160, 165, 170), 3)
        $g.FillRectangle((New-Object System.Drawing.SolidBrush($p.BodyColor)), 80, 50, 110, 300)
        $g.DrawRectangle($outerPen, 80, 50, 110, 300)

        $scrBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush((New-Object System.Drawing.Point(85,55)), (New-Object System.Drawing.Point(185,345)), $p.ScreenGrad[0], $p.ScreenGrad[1])
        $g.FillRectangle($scrBrush, 85, 55, 100, 290)

        # Hinge
        $hingeBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(140, 145, 150))
        $g.FillRectangle($hingeBrush, 190, 45, 15, 310)

        # Main Screen Folded Open Right Side
        $g.FillRectangle((New-Object System.Drawing.SolidBrush($p.BodyColor)), 205, 50, 110, 300)
        $g.DrawRectangle($outerPen, 205, 50, 110, 300)
        $g.FillRectangle($scrBrush, 210, 55, 100, 290)

        # Camera Bar on Fold
        $camBar = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40, 40, 40))
        $g.FillRectangle($camBar, 95, 70, 20, 60)
        $lensB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(200, 200, 220))
        $g.FillEllipse($lensB, 98, 73, 14, 14)
        $g.FillEllipse($lensB, 98, 93, 14, 14)
        $g.FillEllipse($lensB, 98, 113, 14, 14)

    } else {
        # --- DRAW STANDARD 3D SMARTPHONE (FRONT + REAR ANGLED DISPLAY) ---
        
        # 1. REAR BODY (Angled Back view on left side)
        $rearRect = New-Object System.Drawing.Rectangle(75, 45, 115, 295)
        $bodyPath = New-Object System.Drawing.Drawing2D.GraphicsPath
        $cornerRadius = 24
        $bodyPath.AddArc(75, 45, $cornerRadius, $cornerRadius, 180, 90)
        $bodyPath.AddArc(75 + 115 - $cornerRadius, 45, $cornerRadius, $cornerRadius, 270, 90)
        $bodyPath.AddArc(75 + 115 - $cornerRadius, 45 + 295 - $cornerRadius, $cornerRadius, $cornerRadius, 0, 90)
        $bodyPath.AddArc(75, 45 + 295 - $cornerRadius, $cornerRadius, $cornerRadius, 90, 90)
        $bodyPath.CloseAllFigures()

        # Fill Rear Body Color
        $bodyBrush = New-Object System.Drawing.SolidBrush($p.BodyColor)
        $g.FillPath($bodyBrush, $bodyPath)

        # Frame border
        $framePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(180, 255, 255, 255), 2.5)
        $g.DrawPath($framePen, $bodyPath)

        # Render Specific Camera Module on Rear View
        if ($p.CameraStyle -eq "TripleIslands") {
            # iPhone Pro Triple Lens Module
            $camB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(60, 255, 255, 255))
            $g.FillRectangle($camB, 85, 55, 50, 50)
            $lensB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, 20, 25))
            $ringP = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 200, 200), 2)
            
            $g.FillEllipse($lensB, 89, 59, 18, 18); $g.DrawEllipse($ringP, 89, 59, 18, 18)
            $g.FillEllipse($lensB, 89, 83, 18, 18); $g.DrawEllipse($ringP, 89, 83, 18, 18)
            $g.FillEllipse($lensB, 112, 71, 18, 18); $g.DrawEllipse($ringP, 112, 71, 18, 18)
        }
        elseif ($p.CameraStyle -eq "DiagonalDual") {
            # iPhone Base Diagonal Lens
            $camB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(70, 255, 255, 255))
            $g.FillRectangle($camB, 85, 55, 42, 42)
            $lensB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30, 30, 35))
            $ringP = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 1.5)
            $g.FillEllipse($lensB, 88, 58, 16, 16); $g.DrawEllipse($ringP, 88, 58, 16, 16)
            $g.FillEllipse($lensB, 107, 77, 16, 16); $g.DrawEllipse($ringP, 107, 77, 16, 16)
        }
        elseif ($p.CameraStyle -eq "LargeCircle" -or $p.CameraStyle -eq "LargeCircleTwoTone" -or $p.CameraStyle -eq "LeicaMassive") {
            # Big Circular Camera Module (Vivo X100, Xiaomi 14 Ultra, Oppo Find X7)
            $dialBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25, 25, 30))
            $g.FillEllipse($dialBrush, 85, 60, 65, 65)
            $goldPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(212, 175, 55), 2)
            $g.DrawEllipse($goldPen, 85, 60, 65, 65)
            
            $lensB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(10, 10, 12))
            $g.FillEllipse($lensB, 95, 70, 18, 18)
            $g.FillEllipse($lensB, 122, 70, 18, 18)
            $g.FillEllipse($lensB, 95, 95, 18, 18)
            $g.FillEllipse($lensB, 122, 95, 18, 18)
        }
        elseif ($p.CameraStyle -eq "OffsetDial") {
            # OnePlus 12 Offset Hasselblad Dial
            $dialBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35, 40, 45))
            $g.FillEllipse($dialBrush, 75, 60, 60, 60)
            $silverP = New-Object System.Drawing.Pen([System.Drawing.Color]::Silver, 2)
            $g.DrawEllipse($silverP, 75, 60, 60, 60)
            $lensB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(15, 15, 20))
            $g.FillEllipse($lensB, 83, 68, 16, 16)
            $g.FillEllipse($lensB, 110, 68, 16, 16)
            $g.FillEllipse($lensB, 83, 93, 16, 16)
        }
        else {
            # Standard Vertical / Quad Lenses
            $lensB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20, 20, 25))
            $ringP = New-Object System.Drawing.Pen([System.Drawing.Color]::Silver, 2)
            $g.FillEllipse($lensB, 90, 58, 20, 20); $g.DrawEllipse($ringP, 90, 58, 20, 20)
            $g.FillEllipse($lensB, 90, 85, 20, 20); $g.DrawEllipse($ringP, 90, 85, 20, 20)
            $g.FillEllipse($lensB, 90, 112, 20, 20); $g.DrawEllipse($ringP, 90, 112, 20, 20)
        }


        # 2. FRONT DISPLAY PHONE (Main prominent view on right side)
        $frontRect = New-Object System.Drawing.Rectangle(200, 35, 130, 310)
        $fPath = New-Object System.Drawing.Drawing2D.GraphicsPath
        $fRadius = 26
        $fPath.AddArc(200, 35, $fRadius, $fRadius, 180, 90)
        $fPath.AddArc(200 + 130 - $fRadius, 35, $fRadius, $fRadius, 270, 90)
        $fPath.AddArc(200 + 130 - $fRadius, 35 + 310 - $fRadius, $fRadius, $fRadius, 0, 90)
        $fPath.AddArc(200, 35 + 310 - $fRadius, $fRadius, $fRadius, 90, 90)
        $fPath.CloseAllFigures()

        # Phone Outer Frame
        $fFrameBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25, 27, 30))
        $g.FillPath($fFrameBrush, $fPath)
        
        $edgePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(120, 200, 200, 200), 2)
        $g.DrawPath($edgePen, $fPath)

        # Screen Bezel & Display Screen
        $scrPath = New-Object System.Drawing.Drawing2D.GraphicsPath
        $sRadius = 20
        $scrPath.AddArc(204, 39, $sRadius, $sRadius, 180, 90)
        $scrPath.AddArc(204 + 122 - $sRadius, 39, $sRadius, $sRadius, 270, 90)
        $scrPath.AddArc(204 + 122 - $sRadius, 39 + 302 - $sRadius, $sRadius, $sRadius, 0, 90)
        $scrPath.AddArc(204, 39 + 302 - $sRadius, $sRadius, $sRadius, 90, 90)
        $scrPath.CloseAllFigures()

        $dispBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            (New-Object System.Drawing.Point(204, 39)), 
            (New-Object System.Drawing.Point(326, 341)), 
            $p.ScreenGrad[0], 
            $p.ScreenGrad[1]
        )
        $g.FillPath($dispBrush, $scrPath)

        # Screen Notch or Dynamic Island / Punch Hole
        $blackB = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
        if ($p.Style.StartsWith("ApplePro") -or $p.File.Contains("iphone15")) {
            # Dynamic Island
            $g.FillRectangle($blackB, 248, 46, 34, 10)
        } else {
            # Punch Hole Camera
            $g.FillEllipse($blackB, 260, 46, 10, 10)
        }

        # Subtle screen glossy reflection overlay
        $glareBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
            (New-Object System.Drawing.Point(204, 39)), 
            (New-Object System.Drawing.Point(326, 180)), 
            [System.Drawing.Color]::FromArgb(70, 255, 255, 255), 
            [System.Drawing.Color]::FromArgb(0, 255, 255, 255)
        )
        $g.FillPath($glareBrush, $scrPath)
    }

    # Save realistic photo
    $filePath = Join-Path $prodDir $p.File
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)

    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Generated 3D photo: $filePath"
}

Write-Host "All 18 realistic 3D smartphone photos created!"
