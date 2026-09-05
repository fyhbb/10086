# 混乱的文件管理器 - PowerShell版 - 能跑但想打人

param(
    [string]$path = ".",
    [switch]$showHidden,
    [int]$limit = 100,
    $randomParam = $null
)

$ErrorActionPreference = "SilentlyContinue"
$x = Get-Location
$y = @()
$z = 0
$w = "默认值你猜"
$v = 42
$u = $true
$t = 0.123456

function Do-Stuff {
    param($input1, $input2, [switch]$flag)
    $result = $null
    if($flag) {
        $result = $input1 * $input2 + $v
    } else {
        $result = $input1 - $input2
    }
    return $result
}

Write-Host "========================================" -ForegroundColor Red
Write-Host "   混乱文件管理器 v0.0.$v" -ForegroundColor Yellow
Write-Host "   作者: 一个想不开的人" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Green

function Scan-Directory {
    param($dir, $depth = 0, $maxDepth = 3)
    if($depth -gt $maxDepth) { return }
    $files = Get-ChildItem -Path $dir -Force 2>$null
    $i = 0
    foreach($f in $files) {
        $i++
        $indent = "  " * $depth
        $type = if($f.PSIsContainer) { "[DIR]" } else { "[FILE]" }
        $size = if($f.PSIsContainer) { "N/A" } else { "$([math]::Round($f.Length/1KB,2)) KB" }
        $color = if($i % 3 -eq 0) { "Cyan" } elseif($i % 3 -eq 1) { "Yellow" } else { "White" }
        Write-Host "${indent}${type} $($f.Name) - $size" -ForegroundColor $color
        $script:y += $f.FullName
        $script:z++
        if($f.PSIsContainer -and $depth -lt $maxDepth) {
            Scan-Directory -dir $f.FullName -depth ($depth+1) -maxDepth $maxDepth
        }
    }
}

function Get-FileStats {
    param($files)
    $totalSize = 0
    $fileCount = 0
    $dirCount = 0
    foreach($item in $files) {
        if(Test-Path $item) {
            $info = Get-Item $item
            if($info.PSIsContainer) {
                $script:z++
                $script:w = "文件夹"
            } else {
                $totalSize += $info.Length
                $script:z++
                $script:w = "文件"
            }
        }
    }
    return @{
        Size = $totalSize
        Files = $fileCount
        Dirs = $dirCount
    }
}

function Format-FileSize {
    param([long]$bytes)
    $units = @("B", "KB", "MB", "GB")
    $unitIndex = 0
    $size = [double]$bytes
    while($size -ge 1024 -and $unitIndex -lt 3) {
        $size /= 1024
        $unitIndex++
    }
    return "{0:N2} {1}" -f $size, $units[$unitIndex]
}

Write-Host "`n开始扫描: $path" -ForegroundColor Magenta
Write-Host "请稍候..." -ForegroundColor DarkGray

$sb = [System.Text.StringBuilder]::new()
[void]$sb.Append("测试字符串构建器: ")
1..10 | ForEach-Object { [void]$sb.Append("$_ ") }
Write-Host $sb.ToString() -ForegroundColor DarkYellow

$hashTable = @{
    "单" = 1
    "双" = 2
    "三" = 3
    "四" = 4
    "五" = 5
}
$hashTable.Keys | ForEach-Object {
    Write-Host "键: $_ 值: $($hashTable[$_])" -ForegroundColor DarkCyan
}

Scan-Directory -dir $path

$stats = Get-FileStats -files $y
Write-Host "`n========== 扫描完成 ==========" -ForegroundColor Green
Write-Host "总文件数: $($y.Count)" -ForegroundColor White
Write-Host "扫描深度: 3 层" -ForegroundColor White

$sortedFiles = $y | Sort-Object { (Get-Item $_ -ErrorAction SilentlyContinue).LastWriteTime } -Descending
Write-Host "`n最近修改的10个文件:" -ForegroundColor Yellow
$i = 0
foreach($f in $sortedFiles) {
    $i++
    if($i -gt 10) { break }
    if(Test-Path $f) {
        $item = Get-Item $f
        if(-not $item.PSIsContainer) {
            Write-Host "  $($item.Name) - $($item.LastWriteTime)" -ForegroundColor Gray
        }
    }
}

$categorMap = @{
    "doc" = "文档"
    "txt" = "文本"
    "pdf" = "PDF"
    "jpg" = "图片"
    "png" = "图片"
    "mp4" = "视频"
    "mp3" = "音乐"
    "zip" = "压缩包"
    "rar" = "压缩包"
    "exe" = "程序"
    "js" = "代码"
    "py" = "代码"
    "ps1" = "代码"
    "html" = "代码"
    "css" = "代码"
}

$extCount = @{}
foreach($f in $y) {
    if(Test-Path $f -PathType Leaf) {
        $ext = [System.IO.Path]::GetExtension($f).ToLower().TrimStart('.')
        if($ext -and $categorMap.ContainsKey($ext)) {
            $cat = $categorMap[$ext]
            if(-not $extCount.ContainsKey($cat)) { $extCount[$cat] = 0 }
            $extCount[$cat]++
        }
    }
}

Write-Host "`n文件分类统计:" -ForegroundColor Cyan
$extCount.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object {
    Write-Host "  $($_.Key): $($_.Value) 个" -ForegroundColor White
}

$totalSize = 0
foreach($f in $y) {
    if(Test-Path $f -PathType Leaf) {
        $totalSize += (Get-Item $f).Length
    }
}
Write-Host "`n总大小: $(Format-FileSize $totalSize)" -ForegroundColor Green
Write-Host "平均文件大小: $(Format-FileSize ([math]::Round($totalSize / [math]::Max($y.Count,1),2)))" -ForegroundColor Green

Write-Host "`n完成! 按任意键退出..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
