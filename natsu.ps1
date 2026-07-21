param(
    [Parameter(Position=0)][string]$Command = "help",
    [Parameter(Position=1, ValueFromRemainingArguments=$true)][string[]]$Rest
)

$Root      = Split-Path -Parent $MyInvocation.MyCommand.Path
$GameFile  = Join-Path $Root "natsu_no_tonari.html"
$PlayFile  = Join-Path $Root "play_now.html"
$PauseFlag = Join-Path $Root ".paused"
$LockFile  = Join-Path $Root ".auto_running.lock"
$LogFile   = Join-Path $Root "auto_run.log"
$Requests  = Join-Path $Root "REQUESTS.md"
$SnapDir   = Join-Path $Root "snapshots"

$Utf8 = New-Object System.Text.UTF8Encoding($false)
function Log($m)  { [System.IO.File]::AppendAllText($LogFile, "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - $m`r`n", $Utf8) }
function OK($t)   { Write-Host "  [OK] $t" -ForegroundColor Green }
function NG($t)   { Write-Host "  [NG] $t" -ForegroundColor Red }
function Warn($t) { Write-Host "  [!]  $t" -ForegroundColor Yellow }

# 古いロックの自動解除(2時間以上前のものは異常終了とみなす)
if (Test-Path $LockFile) {
    $age = (Get-Date) - (Get-Item $LockFile).CreationTime
    if ($age.TotalHours -gt 2) {
        Remove-Item $LockFile -ErrorAction SilentlyContinue
        Log "古いロックを自動解除しました"
    }
}

# ゲームファイルが壊れていないかの簡易チェック
function Test-GameFile {
    if (-not (Test-Path $GameFile)) { return $false }
    $size = (Get-Item $GameFile).Length
    if ($size -lt 10000) { return $false }
    $tail = (Get-Content $GameFile -Tail 5 -Encoding UTF8) -join "`n"
    return ($tail -match "</html>")
}

switch ($Command.ToLower()) {

    # --- 遊ぶ(止めない) ---------------------------------------
    "play" {
        if (-not (Test-GameFile)) {
            NG "ゲームファイルが壊れているようです"
            Warn "natsu undo で直前の変更を取り消せます"
            break
        }
        Copy-Item $GameFile $PlayFile -Force
        Write-Host ""
        Write-Host "  今のゲームを開きます(自動改善は止まっていません)" -ForegroundColor Cyan
        Write-Host "  ※ 遊んでいる最中に裏で更新されても、この画面には影響しません"
        Write-Host ""
        Start-Process $PlayFile
    }

    # --- 止めて遊ぶ ---------------------------------------------
    "pause" {
        if (-not (Test-Path $PauseFlag)) { New-Item $PauseFlag -ItemType File | Out-Null }
        Log "ユーザーが一時停止"

        $waited = 0
        while ((Test-Path $LockFile) -and $waited -lt 180) {
            Write-Host "  作業中です。キリのいいところまで待っています... ($waited 秒)"
            Start-Sleep -Seconds 5; $waited += 5
        }
        if (Test-Path $LockFile) {
            Warn "作業が長引いています。今の時点のファイルで開きます"
        }

        Copy-Item $GameFile $PlayFile -Force
        Write-Host ""
        Write-Host "  一時停止しました。natsu resume まで自動改善は動きません" -ForegroundColor Cyan
        Write-Host ""
        Start-Process $PlayFile
    }

    # --- 再開 ---------------------------------------------------
    "resume" {
        Remove-Item $PauseFlag -ErrorAction SilentlyContinue
        Remove-Item $LockFile  -ErrorAction SilentlyContinue
        Log "ユーザーが再開"
        Write-Host ""
        Write-Host "  再開しました" -ForegroundColor Green
        Write-Host "  次の定期実行から動きます。すぐ動かすなら  natsu now"
        Write-Host ""
    }

    # --- 今すぐ1回 ----------------------------------------------
    "now" {
        if (Test-Path $PauseFlag) {
            Warn "一時停止中です。先に natsu resume を実行してください"
            break
        }
        & (Join-Path $Root "auto_improve.ps1")
    }

    # --- 要望を出す ---------------------------------------------
    "req" {
        $text = ($Rest -join " ").Trim()
        if (-not $text) {
            Write-Host ""
            Write-Host '  使い方: natsu req "花火のシーンをもっと長くしてほしい"'
            Write-Host '  長文なら natsu talk'
            Write-Host ""
            break
        }
        [System.IO.File]::AppendAllText($Requests, "`r`n## $(Get-Date -Format 'MM/dd HH:mm') 志温`r`n$text`r`n`r`n> (未読)`r`n", $Utf8)
        git -C $Root add REQUESTS.md 2>&1 | Out-Null
        git -C $Root commit -m "req: 要望を追加" 2>&1 | Out-Null
        git -C $Root push 2>&1 | Out-Null
        Write-Host ""
        Write-Host "  伝えました。次の実行でClaudeが読んで、下に返事を書きます" -ForegroundColor Green
        Write-Host "  すぐ処理させたいなら  natsu now"
        Write-Host ""
    }

    "talk" { Start-Process notepad.exe $Requests }

    # --- 状態 ---------------------------------------------------
    "status" {
        Write-Host ""
        if     (Test-Path $PauseFlag) { Write-Host "  状態: 一時停止中" -ForegroundColor Yellow; Write-Host "        natsu resume で再開" }
        elseif (Test-Path $LockFile)  { Write-Host "  状態: 作業中" -ForegroundColor Cyan }
        else                          { Write-Host "  状態: 稼働中(次のタイミング待ち)" -ForegroundColor Green }

        if (Test-GameFile) { OK "ゲームファイル 正常" } else { NG "ゲームファイルが壊れている可能性" }

        $unread = 0
        if (Test-Path $Requests) {
            $unread = (Select-String -Path $Requests -Pattern "\(未読\)" -Encoding UTF8 -ErrorAction SilentlyContinue).Count
        }
        Write-Host "  未読の要望: $unread 件"

        $t = Get-ScheduledTask -TaskName "NatsuNoTonari_AutoImprove" -ErrorAction SilentlyContinue
        if ($t) {
            $info = Get-ScheduledTaskInfo -TaskName "NatsuNoTonari_AutoImprove"
            Write-Host "  前回の実行: $($info.LastRunTime)"
            Write-Host "  次回の実行: $($info.NextRunTime)"
        } else {
            Warn "定期実行が登録されていません(setup.ps1 を実行してください)"
        }

        Write-Host ""
        Write-Host "  --- 直近のログ ---" -ForegroundColor DarkGray
        if (Test-Path $LogFile) { Get-Content $LogFile -Tail 6 -Encoding UTF8 }
        Write-Host ""
    }

    # --- 診断 ---------------------------------------------------
    "doctor" {
        Write-Host ""
        Write-Host "  環境チェック" -ForegroundColor Cyan
        Write-Host "  ------------------------------------------"
        $bad = 0

        if (Get-Command node -ErrorAction SilentlyContinue) { OK "Node.js $(node -v)" } else { NG "Node.js が無い"; $bad++ }
        if (Get-Command git  -ErrorAction SilentlyContinue) { OK "Git" } else { NG "Git が無い"; $bad++ }
        if (Get-Command claude -ErrorAction SilentlyContinue) { OK "Claude Code" } else { NG "Claude Code が無い"; $bad++ }

        if (Test-Path (Join-Path $Root ".git")) { OK "gitリポジトリ" } else { NG "git init されていない"; $bad++ }

        $remote = (git -C $Root remote get-url origin 2>$null)
        if ($remote) { OK "GitHub: $remote" } else { NG "GitHubの接続先が未設定"; $bad++ }

        # 認証が通るかを実際に確認(何も送らずに疎通だけ見る)
        git -C $Root ls-remote --exit-code origin 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) { OK "GitHub認証 通っています" }
        else { NG "GitHubに繋がりません(自動pushが失敗します)"; $bad++ }

        $unpushed = (git -C $Root log origin/main..HEAD --oneline 2>$null)
        if ($unpushed) { Warn "まだGitHubに送られていない変更があります" }

        if (Test-GameFile) { OK "ゲームファイル 正常" } else { NG "ゲームファイルが壊れている"; $bad++ }

        $t = Get-ScheduledTask -TaskName "NatsuNoTonari_AutoImprove" -ErrorAction SilentlyContinue
        if ($t) { OK "定期実行 登録済み ($($t.State))" } else { NG "定期実行が未登録"; $bad++ }

        if (Test-Path $PauseFlag) { Warn "一時停止中です(natsu resume で再開)" }

        Write-Host "  ------------------------------------------"
        if ($bad -eq 0) { Write-Host "  問題なし。放っておけば勝手に進みます" -ForegroundColor Green }
        else { Write-Host "  $bad 件の問題があります。この画面をClaudeに見せてください" -ForegroundColor Red }
        Write-Host ""
    }

    # --- 成果を見る ---------------------------------------------
    "log" {
        Write-Host ""
        Write-Host "  --- 実装された改善 ---" -ForegroundColor Green
        Get-Content (Join-Path $Root "PROGRESS.md") -Tail 25 -Encoding UTF8
        Write-Host ""
        Write-Host "  --- 判断が保留された項目 ---" -ForegroundColor Yellow
        Get-Content (Join-Path $Root "IMPROVEMENTS_LOG.md") -Tail 25 -Encoding UTF8
        Write-Host ""
        Write-Host "  --- 直近の変更履歴 ---" -ForegroundColor DarkGray
        git -C $Root log --oneline -10
        Write-Host ""
    }

    # --- 手動バックアップ ---------------------------------------
    "snapshot" {
        if (-not (Test-Path $SnapDir)) { New-Item $SnapDir -ItemType Directory | Out-Null }
        $name = "natsu_$(Get-Date -Format 'yyyyMMdd_HHmm').html"
        Copy-Item $GameFile (Join-Path $SnapDir $name)
        Write-Host ""
        Write-Host "  保存しました: snapshots\$name" -ForegroundColor Green
        Write-Host ""
    }

    # --- 画像を組み込む -----------------------------------------
    "art" {
        & (Join-Path $Root "art_embed.ps1")
    }

    # --- inboxフォルダを開く ------------------------------------
    "inbox" {
        $InboxDir = Join-Path $Root "inbox"
        if (-not (Test-Path $InboxDir)) { New-Item $InboxDir -ItemType Directory | Out-Null }
        Write-Host ""
        Write-Host "  ここに画像を入れて、natsu art を実行してください" -ForegroundColor Cyan
        Write-Host "  ファイル名は ART_QUEUE.md のキー名に合わせると自動で紐づきます"
        Write-Host ""
        Start-Process explorer.exe $InboxDir
    }

    # --- Geminiで自動生成 ---------------------------------------
    "gemini" {
        & (Join-Path $Root "gemini_art.ps1")
    }

    # --- 必要なイラスト一覧を見る -------------------------------
    "arts" {
        Write-Host ""
        Get-Content (Join-Path $Root "ART_QUEUE.md") -Encoding UTF8
        Write-Host ""
    }

    # --- 取り消し -----------------------------------------------
    "undo" {
        Write-Host ""
        Write-Host "  直前の変更内容:" -ForegroundColor Cyan
        git -C $Root log -1 --oneline
        Write-Host ""
        if ((Read-Host "  これを取り消しますか? (y/n)") -eq "y") {
            git -C $Root revert --no-edit HEAD
            git -C $Root push 2>&1 | Out-Null
            Write-Host "  取り消しました" -ForegroundColor Green
        } else { Write-Host "  やめました" }
        Write-Host ""
    }

    # --- ヘルプ -------------------------------------------------
    default {
        Write-Host @"

  夏のとなり コマンド一覧
  ============================================================
  よく使う
    natsu play          今のゲームを遊ぶ(自動改善は止めない)
    natsu req "内容"    Claudeに要望を伝える
    natsu status        今どうなっているか
    natsu log           何が実装され、何が保留されたか

  止める / 動かす
    natsu pause         止めて、その時点のゲームを開く
    natsu resume        再開する(何日止まっていてもOK)
    natsu now           今すぐ1回だけ走らせる

  イラスト
    natsu arts          今どんな絵が必要とされているか見る
    natsu gemini        Geminiで自動生成する(APIキー設定時)
    natsu inbox         画像を置くフォルダを開く
    natsu art           inboxの画像をゲームに組み込む

  困ったとき
    natsu doctor        環境をまるごと診断する
    natsu undo          直前の自動改善を取り消す
    natsu snapshot      今のゲームを手動でバックアップ
  ============================================================
  スマホからは GitHub の REQUESTS.md を直接編集しても伝わります

"@
    }
}
