# ============================================================
#  夏のとなり 自動セットアップ
#  このファイルを右クリック →「PowerShell で実行」
#  途中で聞かれることに答えていくだけで設定が終わります
# ============================================================

$ErrorActionPreference = "Continue"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root

function Head($t)  { Write-Host ""; Write-Host "=== $t ===" -ForegroundColor Cyan }
function OK($t)    { Write-Host "  [OK] $t" -ForegroundColor Green }
function NG($t)    { Write-Host "  [NG] $t" -ForegroundColor Red }
function Warn($t)  { Write-Host "  [!]  $t" -ForegroundColor Yellow }
function Ask($t)   { Write-Host ""; $a = Read-Host "$t (y/n)"; return ($a -eq "y") }
function Has($c)   { return [bool](Get-Command $c -ErrorAction SilentlyContinue) }

Write-Host ""
Write-Host "  夏のとなり 自動セットアップ" -ForegroundColor White
Write-Host "  ------------------------------------------"
Write-Host "  フォルダ: $Root"
Write-Host ""
Write-Host "  途中で止まっても、もう一度実行すれば続きからやり直せます。"
Write-Host "  赤い [NG] が出たら、その画面をClaudeのチャットに見せてください。"
Write-Host ""
Read-Host "  Enterキーで開始"

$problems = @()

# ------------------------------------------------------------
Head "1. 必要なファイルがそろっているか"
# ------------------------------------------------------------
$need = @("natsu_no_tonari.html","CLAUDE.md","REQUESTS.md","BACKLOG.md",
          "PROGRESS.md","IMPROVEMENTS_LOG.md","COMMANDS.md",
          "auto_improve.ps1","natsu.ps1","natsu.bat")
foreach ($f in $need) {
    if (Test-Path (Join-Path $Root $f)) { OK $f }
    else { NG "$f が見つかりません"; $problems += "ファイル不足: $f" }
}
if ($problems.Count -gt 0) {
    Write-Host ""
    Warn "足りないファイルをこのフォルダに入れてから、もう一度実行してください。"
    Read-Host "Enterで終了"; exit
}

# ------------------------------------------------------------
Head "2. Node.js"
# ------------------------------------------------------------
if (Has "node") {
    $v = (node -v)
    $major = [int](($v -replace "[^0-9\.]","").Split(".")[0])
    if ($major -ge 18) { OK "Node.js $v" }
    else { NG "Node.js $v は古いです(18以上が必要)"; $problems += "Node.js更新" }
} else {
    NG "Node.js が入っていません"
    Write-Host "     https://nodejs.org/ から LTS版 を入れて、PCを再起動してから"
    Write-Host "     このセットアップをもう一度実行してください。"
    Read-Host "Enterで終了"; exit
}

# ------------------------------------------------------------
Head "3. Git"
# ------------------------------------------------------------
if (Has "git") {
    OK (git --version)
    $uname = (git config --global user.name)
    $umail = (git config --global user.email)
    if (-not $uname) {
        Write-Host ""
        $uname = Read-Host "  Gitに登録する名前(ローマ字でOK)"
        git config --global user.name $uname
    }
    if (-not $umail) {
        $umail = Read-Host "  GitHubに登録しているメールアドレス"
        git config --global user.email $umail
    }
    OK "Git設定: $uname <$umail>"
} else {
    NG "Git が入っていません"
    Write-Host "     https://git-scm.com/download/win から入れて、PCを再起動してから"
    Write-Host "     このセットアップをもう一度実行してください。"
    Write-Host "     ※インストール中の選択肢は全部そのまま「Next」で大丈夫です。"
    Read-Host "Enterで終了"; exit
}

# ------------------------------------------------------------
Head "4. Claude Code"
# ------------------------------------------------------------
if (Has "claude") {
    OK "インストール済み"
} else {
    Warn "まだ入っていません"
    if (Ask "  今インストールしますか?(数分かかります)") {
        npm install -g @anthropic-ai/claude-code
        if (Has "claude") { OK "インストール完了" }
        else {
            NG "インストールに失敗しました"
            Warn "PowerShellを開き直すと認識されることがあります。一度閉じて再実行してください。"
            Read-Host "Enterで終了"; exit
        }
    } else { Read-Host "Enterで終了"; exit }
}

# claudeの実体パスを控えておく(タスクスケジューラでPATHが通らない対策)
$claudeCmd = (Get-Command claude).Source
OK "実行ファイル: $claudeCmd"
Set-Content (Join-Path $Root ".claude_path") $claudeCmd

# ------------------------------------------------------------
Head "5. Claudeへのログイン"
# ------------------------------------------------------------
Write-Host "  ここが一番大事です。ログインしていないと自動実行が全部失敗します。"
Write-Host ""
if (Ask "  ログインの確認をしますか?(まだの人も y)") {
    Write-Host ""
    Write-Host "  これから claude を起動します。" -ForegroundColor Yellow
    Write-Host "   ・ブラウザが開いたらClaude Proのアカウントでログイン" -ForegroundColor Yellow
    Write-Host "   ・すでにログイン済みなら何も聞かれません" -ForegroundColor Yellow
    Write-Host "   ・画面が出たら  /exit  と打って Enter で戻ってきてください" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "  Enterで起動"
    claude
    Write-Host ""
    OK "戻ってきました"
}

# ------------------------------------------------------------
Head "6. GitHubとつなぐ"
# ------------------------------------------------------------
if (-not (Test-Path (Join-Path $Root ".git"))) {
    git init | Out-Null
    git branch -M main | Out-Null
    OK "gitリポジトリを作成しました"
} else { OK "gitリポジトリは作成済み" }

# .gitignore(遊ぶ用のコピーや作業ファイルは記録しない)
$gitignore = @"
play_now.html
.auto_running.lock
.paused
.claude_path
snapshots/
"@
Set-Content (Join-Path $Root ".gitignore") $gitignore -Encoding UTF8

$remote = (git remote get-url origin 2>$null)
if (-not $remote) {
    Write-Host ""
    Write-Host "  GitHubでリポジトリを作ります:"
    Write-Host "   1) https://github.com/new を開く"
    Write-Host "   2) Repository name に  natsu-no-tonari"
    Write-Host "   3) 【重要】Private を選ぶ"
    Write-Host "   4) 下の Add a README などは全部チェックを入れない"
    Write-Host "   5) Create repository"
    Write-Host "   6) 次の画面に出る https://github.com/～.git をコピー"
    Write-Host ""
    $url = Read-Host "  コピーしたURLを貼り付けてEnter"
    if ($url) { git remote add origin $url.Trim(); OK "接続先を設定しました" }
} else { OK "接続先: $remote" }

git add -A | Out-Null
git commit -m "setup: 初期状態" 2>&1 | Out-Null
OK "初回コミット完了"

Write-Host ""
Write-Host "  GitHubへの初回アップロードを行います。" -ForegroundColor Yellow
Write-Host "  ブラウザやウィンドウでGitHubログインを求められたら、ログインしてください。" -ForegroundColor Yellow
Write-Host "  ここでログイン情報を一度保存しておくと、以後は自動で送信されます。" -ForegroundColor Yellow
Read-Host "  Enterで実行"

$pushOut = (git push -u origin main 2>&1 | Out-String)
Write-Host $pushOut
if ($LASTEXITCODE -eq 0) {
    OK "GitHubへのアップロード成功"
} else {
    NG "アップロードに失敗しました"
    $problems += "git push失敗"
    Warn "自動実行の前に必ずここを解決してください。この画面をClaudeに見せてください。"
}

# ------------------------------------------------------------
Head "7. natsuコマンドをどこからでも使えるように"
# ------------------------------------------------------------
if (Ask "  設定しますか?(おすすめ)") {
    if (-not (Test-Path $PROFILE)) { New-Item -Path $PROFILE -Type File -Force | Out-Null }
    $line = "function natsu { & `"$Root\natsu.bat`" `$args }"
    $cur = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
    if ($cur -notmatch "function natsu") {
        Add-Content $PROFILE "`n$line"
        OK "設定しました(PowerShellを開き直すと有効になります)"
    } else { OK "設定済み" }
}

# ------------------------------------------------------------
Head "8. 定期実行の登録"
# ------------------------------------------------------------
Write-Host "  何時間おきに自動改善を走らせますか?"
Write-Host "   1時間 … 制限を使い切るペース(希望通りならこれ)"
Write-Host "   2時間 … 自分のチャット用に少し残したい場合"
Write-Host ""
$hoursIn = Read-Host "  数字を入力(何も入れずEnterなら1)"
if (-not $hoursIn) { $hoursIn = "1" }
$hours = [int]$hoursIn

$taskName = "NatsuNoTonari_AutoImprove"
if (Ask "  「$taskName」を$hours時間おきに登録しますか?") {
    try {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

        $action = New-ScheduledTaskAction -Execute "powershell.exe" `
            -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$Root\auto_improve.ps1`""

        $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(3) `
            -RepetitionInterval (New-TimeSpan -Hours $hours)

        $settings = New-ScheduledTaskSettingsSet `
            -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries `
            -StartWhenAvailable -WakeToRun `
            -ExecutionTimeLimit (New-TimeSpan -Hours 2) `
            -MultipleInstances IgnoreNew

        Register-ScheduledTask -TaskName $taskName -Action $action `
            -Trigger $trigger -Settings $settings `
            -Description "夏のとなり 自動改善" | Out-Null

        OK "登録しました(3分後から$hours時間おきに動きます)"
        Write-Host "     ・スリープ中でもPCを起こして実行します"
        Write-Host "     ・バッテリー駆動でも実行します"
        Write-Host "     ・止めたいときは  natsu pause"
    } catch {
        NG "自動登録に失敗しました: $_"
        $problems += "タスク登録失敗"
        Warn "SETUP_CHECKLIST.md の『手動でタスクを登録する場合』を見てください。"
    }
}

# ------------------------------------------------------------
Head "結果"
# ------------------------------------------------------------
if ($problems.Count -eq 0) {
    Write-Host ""
    Write-Host "  セットアップ完了です。" -ForegroundColor Green
    Write-Host ""
    Write-Host "  次にやること:"
    Write-Host "   1) PowerShellを開き直す"
    Write-Host "   2)  natsu doctor   と打って全項目が緑になるか確認"
    Write-Host "   3)  natsu now      で1回だけ動かしてみる"
    Write-Host "   4)  natsu play     でゲームが開くか確認"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "  未解決の項目があります:" -ForegroundColor Yellow
    foreach ($p in $problems) { Write-Host "   ・$p" }
    Write-Host ""
    Write-Host "  この画面のスクショをClaudeのチャットに送れば一緒に直せます。"
    Write-Host ""
}
Read-Host "Enterで終了"
