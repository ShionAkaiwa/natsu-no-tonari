# ============================================================
#  無料で画像を自動生成する(Pollinations.ai / Flux)
#  APIキー・アカウント登録・課金は一切不要です。
#  ART_QUEUE.md に書かれた未生成のプロンプトを読んで、
#  画像を作り、inbox に保存します。
# ============================================================

$Root     = Split-Path -Parent $MyInvocation.MyCommand.Path
$Queue    = Join-Path $Root "ART_QUEUE.md"
$InboxDir = Join-Path $Root "inbox"
$LogFile  = Join-Path $Root "auto_run.log"

$Utf8 = New-Object System.Text.UTF8Encoding($false)
function Log($m) { [System.IO.File]::AppendAllText($LogFile, "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - [art] $m`r`n", $Utf8) }

if (-not (Test-Path $Queue))    { Write-Host "  ART_QUEUE.md がありません"; exit }
if (-not (Test-Path $InboxDir)) { New-Item $InboxDir -ItemType Directory | Out-Null }

$content = Get-Content $Queue -Raw -Encoding UTF8

# ART_QUEUE.md の書式:
#   ### key_name
#   status: 未生成
#   prompt: <英語のプロンプト>
$pattern = '(?ms)^### (.+?)\r?\n(?:retries: \d+\r?\n)?status: 未生成\r?\nprompt: (.+?)(?=\r?\n###|\r?\n*\z)'
$matches = [regex]::Matches($content, $pattern)

if ($matches.Count -eq 0) {
    Write-Host "  生成待ちの画像はありません"
    exit
}

Write-Host ""
Write-Host "  $($matches.Count) 件の画像を生成します(無料・課金なし)" -ForegroundColor Cyan

# 1回の実行で作りすぎないよう3枚まで
$limit = [Math]::Min(3, $matches.Count)
$successCount = 0

for ($i = 0; $i -lt $limit; $i++) {
    $key    = $matches[$i].Groups[1].Value.Trim()
    $prompt = $matches[$i].Groups[2].Value.Trim()

    Write-Host "   生成中: $key ..."

    $encoded = [System.Uri]::EscapeDataString($prompt)
    # seed を毎回変えることで同じプロンプトの使い回しを避ける
    $seed = Get-Random -Minimum 1 -Maximum 999999
    $url = "https://image.pollinations.ai/prompt/$encoded" +
           "?width=1024&height=1536&seed=$seed&nologo=true&model=flux"

    $out = Join-Path $InboxDir "$key.png"

    try {
        Invoke-WebRequest -Uri $url -OutFile $out -TimeoutSec 120 -UseBasicParsing

        # 中身が本当に画像か簡易チェック(0バイトやエラーHTMLを弾く)
        if ((Test-Path $out) -and (Get-Item $out).Length -gt 5000) {
            Write-Host "     完了: inbox\$key.png" -ForegroundColor Green
            Log "生成成功: $key"
            $successCount++
            $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}生成済み"
        } else {
            Remove-Item $out -ErrorAction SilentlyContinue
            Write-Host "     画像が取得できませんでした" -ForegroundColor Yellow
            Log "生成失敗(サイズ異常): $key"
            $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}要手動"
        }
    }
    catch {
        Write-Host "     エラー: $_" -ForegroundColor Red
        Log "生成エラー: $key / $_"
        $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}要手動"
    }

    # 無料の匿名アクセスは連続リクエストに弱いので間隔を空ける
    Start-Sleep -Seconds 16
}

[System.IO.File]::WriteAllText($Queue, $content, $Utf8)

Write-Host ""
if ($successCount -gt 0) {
    Write-Host "  $successCount 件を inbox に保存しました。組み込むには  natsu art" -ForegroundColor Green
} else {
    Write-Host "  生成できませんでした。時間を置いてもう一度試すか、natsu arts で手動生成に切り替えてください" -ForegroundColor Yellow
}
Write-Host ""
