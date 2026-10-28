# ---------------------------------------------------------------------------
# Downloads every image the site currently loads from Wix into .\images\
# and rewrites the HTML to use the local copies.
#
# Run ONCE from inside the higginshaw-site folder:
#   Right-click this file > "Run with PowerShell"
#   or in a terminal:  powershell -ExecutionPolicy Bypass -File .\download-images.ps1
# ---------------------------------------------------------------------------
$ErrorActionPreference = 'Stop'
$root   = Split-Path -Parent $MyInvocation.MyCommand.Path
$imgDir = Join-Path $root 'images'
New-Item -ItemType Directory -Force -Path $imgDir | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$pattern = 'https://static\.wixstatic\.com/media/([^/"]+)/v1/fit/w_(\d+),[^"]*'
$htmlFiles = Get-ChildItem -Path $root -Recurse -Filter *.html

# 1. Collect every unique Wix image URL and give it a tidy local name
$map = @{}
foreach ($file in $htmlFiles) {
    $text = Get-Content -Raw -Encoding UTF8 $file.FullName
    foreach ($m in [regex]::Matches($text, $pattern)) {
        $url = $m.Value
        if (-not $map.ContainsKey($url)) {
            $id   = $m.Groups[1].Value -replace '~mv2', ''
            $ext  = [IO.Path]::GetExtension($id)
            $base = [IO.Path]::GetFileNameWithoutExtension($id)
            $map[$url] = "$base-w$($m.Groups[2].Value)$ext"
        }
    }
}
Write-Host "Found $($map.Count) images to download..."

# 2. Download them
$i = 0
foreach ($url in @($map.Keys)) {
    $i++
    $dest = Join-Path $imgDir $map[$url]
    if (Test-Path $dest) { Write-Host "[$i/$($map.Count)] already have $($map[$url])"; continue }
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing
        Write-Host "[$i/$($map.Count)] $($map[$url])"
    } catch {
        Write-Warning "Failed: $url  ($($_.Exception.Message))"
        $map.Remove($url) | Out-Null
    }
}

# 3. Point the HTML at the local files (news/ pages need ../images/)
foreach ($file in $htmlFiles) {
    $text = Get-Content -Raw -Encoding UTF8 $file.FullName
    $prefix = if ($file.DirectoryName -ne $root) { '../images/' } else { 'images/' }
    foreach ($url in $map.Keys) { $text = $text.Replace($url, $prefix + $map[$url]) }
    [IO.File]::WriteAllText($file.FullName, $text, (New-Object Text.UTF8Encoding $false))
}
Write-Host "`nDone. Images saved to $imgDir and HTML updated." -ForegroundColor Green
