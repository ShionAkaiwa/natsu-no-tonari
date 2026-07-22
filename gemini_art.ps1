# ============================================================
#  Gemini で画像を自動生成する(任意の機能)
#  ART_QUEUE.md に書かれた未生成のプロンプトを読んで、
#  Gemini API に投げて画像を作り、inbox に保存します。
#
#  使うには先に APIキーの設定が必要です:
#    setx GEMINI_API_KEY "取得したキー"
#  (詳しくは MANUAL_SETUP.md のステップ8)
#
#  この機能を使わなくても、手動ルートで問題なく回ります。
# ============================================================

$Root     = Split-Path -Parent $MyInvocation.MyCommand.Path
$Queue    = Join-Path $Root "ART_QUEUE.md"
$InboxDir = Join-Path $Root "inbox"
$LogFile  = Join-Path $Root "auto_run.log"

# モデル名。将来変わったらここだけ書き換えれば動きます。
$Model = "gemini-2.5-flash-image"

$Utf8 = New-Object System.Text.UTF8Encoding($false)
function Log($m) { [System.IO.File]::AppendAllText($LogFile, "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - [gemini] $m`r`n", $Utf8) }

$apiKey = $env:GEMINI_API_KEY
if (-not $apiKey) {
    Write-Host ""
    Write-Host "  GEMINI_API_KEY が設定されていません" -ForegroundColor Yellow
    Write-Host "  自動生成を使わない場合はこのままで大丈夫です。"
    Write-Host "  ART_QUEUE.md のプロンプトを手でGeminiに投げて、"
    Write-Host "  できた画像を inbox フォルダに入れてください。"
    Write-Host ""
    exit
}

if (-not (Test-Path $Queue))    { Write-Host "  ART_QUEUE.md がありません"; exit }
if (-not (Test-Path $InboxDir)) { New-Item $InboxDir -ItemType Directory | Out-Null }

$content = Get-Content $Queue -Raw -Encoding UTF8

# ART_QUEUE.md の書式:
#   ### key_name
#   status: 未生成
#   prompt: <英語のプロンプト>
$pattern = '(?m)^### ([^\r\n]+)\r?\nstatus: 未生成\r?\nprompt: ([\s\S]+?)(?=\r?\n### |\r?\n*\z)'
$matches = [regex]::Matches($content, $pattern)

if ($matches.Count -eq 0) {
    Write-Host "  生成待ちの画像はありません"
    exit
}

Write-Host ""
Write-Host "  $($matches.Count) 件の画像を生成します" -ForegroundColor Cyan

# 1回の実行で作りすぎないよう3枚まで
$limit = [Math]::Min(3, $matches.Count)
$successCount = 0
$quotaBlocked = $false

for ($i = 0; $i -lt $limit; $i++) {
    $key    = $matches[$i].Groups[1].Value.Trim()
    $prompt = $matches[$i].Groups[2].Value.Trim()

    Write-Host "   生成中: $key ..."

    $body = @{
        contents = @(@{ parts = @(@{ text = $prompt }) })
    } | ConvertTo-Json -Depth 10

    $url = "https://generativelanguage.googleapis.com/v1beta/models/$Model" + ":generateContent"

    try {
        $res = Invoke-RestMethod -Uri $url -Method Post `
                 -Headers @{ "x-goog-api-key" = $apiKey; "Content-Type" = "application/json" } `
                 -Body $body -TimeoutSec 180

        # 返ってきたパーツから画像データを探す
        $imgData = $null
        foreach ($part in $res.candidates[0].content.parts) {
            if ($part.inlineData -and $part.inlineData.data) { $imgData = $part.inlineData.data; break }
            if ($part.inline_data -and $part.inline_data.data) { $imgData = $part.inline_data.data; break }
        }

        if ($imgData) {
            $out = Join-Path $InboxDir "$key.png"
            [IO.File]::WriteAllBytes($out, [Convert]::FromBase64String($imgData))
            Write-Host "     完了: inbox\$key.png" -ForegroundColor Green
            Log "生成成功: $key"
            $successCount++

            # キューのステータスを更新
            $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}生成済み"
        } else {
            Write-Host "     画像が返ってきませんでした" -ForegroundColor Yellow
            Log "生成失敗(画像なし): $key"
            $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}要手動"
        }
    }
    catch {
        $errMsg = "$_"
        if ($errMsg -match "429") {
            Write-Host "     利用枠の上限(429)。課金を有効にしていない場合、画像生成の無料枠は現在0件です" -ForegroundColor Yellow
            $quotaBlocked = $true
        } else {
            Write-Host "     エラー: $errMsg" -ForegroundColor Red
        }
        Log "生成エラー: $key / $errMsg"
        $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}要手動"
    }

    Start-Sleep -Seconds 3
}

[System.IO.File]::WriteAllText($Queue, $content, $Utf8)

Write-Host ""
if ($successCount -gt 0) {
    Write-Host "  $successCount 件を inbox に保存しました。組み込むには  natsu art" -ForegroundColor Green
} elseif ($quotaBlocked) {
    Write-Host "  生成できませんでした(利用枠の上限)。" -ForegroundColor Yellow
    Write-Host "  課金を有効にしていない場合、画像生成の無料枠は現在0件です。"
    Write-Host "  手動ルートに切り替える場合は  natsu arts  でプロンプトを確認してください。"
} else {
    Write-Host "  生成できませんでした。auto_run.log を確認してください。" -ForegroundColor Yellow
}
Write-Host ""
