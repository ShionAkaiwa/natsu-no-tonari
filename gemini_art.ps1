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

function Log($m) { Add-Content $LogFile "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - [gemini] $m" }

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
$pattern = '(?ms)^### (.+?)\r?\nstatus: 未生成\r?\nprompt: (.+?)(?=\r?\n###|\r?\n*\z)'
$matches = [regex]::Matches($content, $pattern)

if ($matches.Count -eq 0) {
    Write-Host "  生成待ちの画像はありません"
    exit
}

Write-Host ""
Write-Host "  $($matches.Count) 件の画像を生成します" -ForegroundColor Cyan

# 1回の実行で作りすぎないよう3枚まで
$limit = [Math]::Min(3, $matches.Count)

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

            # キューのステータスを更新
            $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}生成済み"
        } else {
            Write-Host "     画像が返ってきませんでした" -ForegroundColor Yellow
            Log "生成失敗(画像なし): $key"
            $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}要手動"
        }
    }
    catch {
        Write-Host "     エラー: $_" -ForegroundColor Red
        Log "生成エラー: $key / $_"
        $content = $content -replace "(### $([regex]::Escape($key))\r?\nstatus: )未生成", "`${1}要手動"
    }

    Start-Sleep -Seconds 3
}

Set-Content $Queue $content -Encoding UTF8

Write-Host ""
Write-Host "  inbox に保存しました。組み込むには  natsu art" -ForegroundColor Cyan
Write-Host ""
