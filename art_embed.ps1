# ============================================================
#  画像をゲームに組み込む
#  inbox フォルダに置かれた画像を images に移して、
#  ゲームから使えるように登録します。
#  natsu art  で呼び出されます。
# ============================================================

$Root     = Split-Path -Parent $MyInvocation.MyCommand.Path
$GameFile = Join-Path $Root "natsu_no_tonari.html"
$InboxDir = Join-Path $Root "inbox"
$ImgDir   = Join-Path $Root "images"
$LogFile  = Join-Path $Root "auto_run.log"
$ArtLog   = Join-Path $Root "ART_NEW.md"

function Log($m) { Add-Content $LogFile "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - [art] $m" }

if (-not (Test-Path $InboxDir)) { New-Item $InboxDir -ItemType Directory | Out-Null }
if (-not (Test-Path $ImgDir))   { New-Item $ImgDir   -ItemType Directory | Out-Null }

# --- inbox の画像を images へ移動 ---------------------------
$new = @()
$files = Get-ChildItem $InboxDir -Include *.png,*.jpg,*.jpeg,*.webp -Recurse -ErrorAction SilentlyContinue
foreach ($f in $files) {
    # ファイル名をそのままキーにする(スペースや記号は _ に)
    $key = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $key = ($key -replace '[^A-Za-z0-9_\-ぁ-んァ-ヶ一-龠]', '_')
    $ext = $f.Extension.ToLower()
    $dest = Join-Path $ImgDir "$key$ext"

    Move-Item $f.FullName $dest -Force
    $new += "$key$ext"
    Log "取り込み: $key$ext"
}

# --- ゲームから参照できるよう一覧を書き込む -----------------
$all = Get-ChildItem $ImgDir -Include *.png,*.jpg,*.jpeg,*.webp -Recurse -ErrorAction SilentlyContinue
$entries = @()
foreach ($img in $all) {
    $k = [System.IO.Path]::GetFileNameWithoutExtension($img.Name)
    $entries += "  `"$k`": `"images/$($img.Name)`""
}

$block = "<script id=""ART_DATA"">`n" +
         "// このブロックは自動生成されます。手で編集しないでください。`n" +
         "window.ART = {`n" + ($entries -join ",`n") + "`n};`n" +
         "</script>"

$html = Get-Content $GameFile -Raw -Encoding UTF8

if ($html -match '(?s)<script id="ART_DATA">.*?</script>') {
    $html = [regex]::Replace($html, '(?s)<script id="ART_DATA">.*?</script>', [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $block })
} else {
    $html = $html -replace '</body>', "$block`n</body>"
}
Set-Content $GameFile $html -Encoding UTF8 -NoNewline

# --- 新規画像があればClaudeへの申し送りを書く ---------------
if ($new.Count -gt 0) {
    $lines = @("# 新しく届いた画像", "", "Claude Code へ: 以下の画像が届きました。",
               "ゲーム内の適切な場面で ``window.ART[""キー名""]`` として表示するよう",
               "組み込んでください。組み込んだらこのファイルを空にしてください。", "")
    foreach ($n in $new) {
        $k = [System.IO.Path]::GetFileNameWithoutExtension($n)
        $lines += "- ``$k`` (images/$n)"
    }
    Set-Content $ArtLog ($lines -join "`n") -Encoding UTF8
    Write-Host ""
    Write-Host "  $($new.Count) 枚を取り込みました" -ForegroundColor Green
    foreach ($n in $new) { Write-Host "    ・$n" }
    Write-Host ""
    Write-Host "  次の自動実行でClaudeがゲームに組み込みます" -ForegroundColor Cyan
    Write-Host "  すぐ組み込ませるなら  natsu now"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "  inbox に新しい画像はありませんでした"
    Write-Host "  画像を入れる場所: $InboxDir"
    Write-Host ""
}
