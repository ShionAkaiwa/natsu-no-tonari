# ============================================================
#  夏のとなり 自動改善スクリプト
#  タスクスケジューラから定期実行される。手動なら natsu now。
#  ※このファイルは基本的に触らなくて大丈夫です
# ============================================================

$Root      = Split-Path -Parent $MyInvocation.MyCommand.Path
$GameFile  = Join-Path $Root "natsu_no_tonari.html"
$LockFile  = Join-Path $Root ".auto_running.lock"
$PauseFlag = Join-Path $Root ".paused"
$LogFile   = Join-Path $Root "auto_run.log"
$SnapDir   = Join-Path $Root "snapshots"

$Utf8 = New-Object System.Text.UTF8Encoding($false)
function Log($m) { [System.IO.File]::AppendAllText($LogFile, "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - $m`r`n", $Utf8) }

# --- 一時停止中なら何もしない -------------------------------
if (Test-Path $PauseFlag) { Log "一時停止中のためスキップ"; exit }

# --- 古いロックは異常終了とみなして解除 ---------------------
if (Test-Path $LockFile) {
    $age = (Get-Date) - (Get-Item $LockFile).CreationTime
    if ($age.TotalHours -gt 2) {
        Remove-Item $LockFile -ErrorAction SilentlyContinue
        Log "古いロックを解除しました"
    } else {
        Log "前回の実行が進行中のためスキップ"
        exit
    }
}
New-Item $LockFile -ItemType File | Out-Null

try {
    Set-Location $Root
    Log "----- 実行開始 -----"

    # --- バックアップ(1日1つ) ------------------------------
    if (-not (Test-Path $SnapDir)) { New-Item $SnapDir -ItemType Directory | Out-Null }
    $snap = Join-Path $SnapDir "natsu_$(Get-Date -Format 'yyyyMMdd').html"
    if (-not (Test-Path $snap)) { Copy-Item $GameFile $snap }
    # 30日より古いバックアップは削除
    Get-ChildItem $SnapDir -Filter *.html -ErrorAction SilentlyContinue |
        Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-30) } |
        Remove-Item -ErrorAction SilentlyContinue

    # --- スマホからGitHubで書いた要望を取り込む --------------
    # エディタが開いて固まらないよう GIT_EDITOR を無効化しておく
    $env:GIT_EDITOR = "true"
    $pull = (git pull --rebase 2>&1 | Out-String)
    if ($pull -match "(?i)conflict") {
        Log "取り込みで衝突しました。ローカル側を優先して続行します"
        git rebase --abort 2>&1 | Out-Null
    }

    # --- 届いた画像を取り込む --------------------------------
    & (Join-Path $Root "art_embed.ps1") 2>&1 | Out-Null

    # --- 無料で画像を自動生成(Pollinations.ai。課金なし) ----
    & (Join-Path $Root "auto_art_gen.ps1") 2>&1 | Out-Null
    & (Join-Path $Root "art_embed.ps1") 2>&1 | Out-Null

    # --- スマホ公開用コピーを更新(GitHub Pagesが/docsを自動デプロイする) --
    $SiteDir = Join-Path $Root "docs"
    if (-not (Test-Path $SiteDir)) { New-Item $SiteDir -ItemType Directory | Out-Null }
    Copy-Item $GameFile (Join-Path $SiteDir "index.html") -Force

    # --- Claude Code に作業させる ----------------------------
    $prompt = "CLAUDE.mdの指示に従って作業してください。REQUESTS.mdの未読要望を最優先し、なければBACKLOG.mdから1件処理し、最後に必ずgit commitとgit pushまで行ってください。"

    # claude の場所(setup.ps1 が控えたもの)を優先して使う
    $claudeExe = "claude"
    $pathFile = Join-Path $Root ".claude_path"
    if (Test-Path $pathFile) { $claudeExe = (Get-Content $pathFile -Raw).Trim() }

    # --dangerously-skip-permissions は無人実行のため確認を省略するオプション。
    # 変更は全てgitに記録されるので、おかしければ natsu undo で戻せる。
    $output = & $claudeExe -p $prompt --dangerously-skip-permissions 2>&1 | Out-String
    [System.IO.File]::AppendAllText($LogFile, $output + "`r`n", $Utf8)

    # --- 制限に当たったかを判定 ------------------------------
    if ($output -match "(?i)usage limit|rate limit|quota|too many requests") {
        Log "利用制限に到達。次回のタイミングで自動的に再試行します"
    } else {
        Log "作業完了"
    }

    # --- ファイルが壊れていないか確認 ------------------------
    # 過去に art_embed.ps1 のバグで本体スクリプトが丸ごと消えたことがあり、
    # そのときもサイズは10000バイトを超え末尾も </html> のままだったため
    # このチェックをすり抜けた。ゲーム本体に必ず存在するはずの目印
    # (function boot と Audio_ モジュール)の有無も見る。
    $broken = $false
    if (-not (Test-Path $GameFile)) { $broken = $true }
    elseif ((Get-Item $GameFile).Length -lt 50000) { $broken = $true }
    elseif ((((Get-Content $GameFile -Tail 5 -Encoding UTF8) -join "`n")) -notmatch "</html>") { $broken = $true }
    else {
        $gameText = Get-Content $GameFile -Raw -Encoding UTF8
        if ($gameText -notmatch "function boot" -or $gameText -notmatch "const Audio_") { $broken = $true }
    }

    if ($broken) {
        Log "!!! ゲームファイルが壊れています。直前の状態に戻します"
        git checkout -- $GameFile 2>&1 | Out-Null
        Log "復旧しました"
    }

    # --- Claudeがpushし損ねていた場合の保険 ------------------
    git add -A 2>&1 | Out-Null
    git commit -m "auto: 自動改善セッション" 2>&1 | Out-Null
    $push = (git push 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { Log "GitHubへの送信に失敗: $push" }

    Log "----- 実行終了 -----"
}
catch {
    Log "エラー: $_"
}
finally {
    Remove-Item $LockFile -ErrorAction SilentlyContinue
    # ログが肥大化しないよう直近1000行だけ残す
    if ((Test-Path $LogFile) -and (Get-Content $LogFile -Encoding UTF8).Count -gt 1000) {
        $keep = (Get-Content $LogFile -Tail 1000 -Encoding UTF8) -join "`r`n"
        [System.IO.File]::WriteAllText($LogFile, $keep, $Utf8)
    }
}
