$baseDir = "d:\ASP.NET\DataBase\DataBase"

# Find all Screenshot and unnamed files
$filesToDelete = @(
    "imagescafe.jpg",
    "imagesScreenshot 2026-07-01 085732.png",
    "imagesScreenshot 2026-07-01 170727.png",
    "imagesScreenshot 2026-07-07 082106.png",
    "imagesScreenshot 2026-08-06 133227.png",
    "images\Screenshot 2026-07-01 171800.png",
    "images\unnamed.png",
    "Comp_Images\Screenshot 2026-08-12 091936.png",
    "Comp_Images\Screenshot 2026-08-14 101525.png",
    "Comp_Images\unnamed.png",
    "Product_Images\Screenshot 2026-08-12 091936.png",
    "Product_Images\unnamed.png"
)

Write-Host "Cleaning up unneeded screenshot and junk image files..."
foreach ($relPath in $filesToDelete) {
    $fullPath = Join-Path $baseDir $relPath
    if (Test-Path $fullPath) {
        Remove-Item -Path $fullPath -Force
        Write-Host "Deleted file: $fullPath"
    } else {
        Write-Host "File not found (already clean): $fullPath"
    }
}

# Double check if any wildcard *Screenshot* remains in DataBase tree
$remainingScreenshots = Get-ChildItem -Path $baseDir -Recurse -Include "*Screenshot*", "*unnamed*" -ErrorAction SilentlyContinue
foreach ($f in $remainingScreenshots) {
    Remove-Item -Path $f.FullName -Force
    Write-Host "Deleted additional junk file: $($f.FullName)"
}

Write-Host "`nAll unneeded screenshot image files deleted successfully!"
