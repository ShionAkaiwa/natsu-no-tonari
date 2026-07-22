# 手動セットアップ手順

## なぜ右クリック実行で何も起きなかったか

Windowsは初期設定で `.ps1` ファイルの実行をブロックします。
右クリック実行だと、エラーが出た瞬間に窓が閉じるので「何も起きていない」ように見えます。
壊れたわけではありません。

これから手動でやるので問題ありません。**コマンドプロンプトではなく
PowerShell を使ってください**(コマンドプロンプトだとスクリプトが動きません)。

PowerShellの開き方: Windowsキー → `powershell` と入力 → Enter

---

# 【手動】ステップ1: フォルダを作る

エクスプローラーで `D:\natsu-project` を作り、ダウンロードしたファイルを全部入れる。
(Dドライブが無ければ `C:\natsu-project` でOK。以降のパスも読み替えてください)

入れるファイル:
```
natsu_no_tonari.html    ← ゲーム本体。忘れやすいので注意
natsu.ps1
natsu.bat
auto_improve.ps1
art_embed.ps1
setup.ps1
CLAUDE.md
REQUESTS.md
ART_QUEUE.md
BACKLOG.md
PROGRESS.md
IMPROVEMENTS_LOG.md
COMMANDS.md
HOW_TO_ASK.md
```

---

# 【手動】ステップ2: PowerShellでフォルダに移動

PowerShellに貼り付けてEnter:

```
cd D:\natsu-project
```

以降のコマンドは全部この状態で打ちます。

---

# 【手動】ステップ3: 必要なものが入っているか確認

1行ずつ貼り付けてEnter:

```
node -v
```
```
git --version
```
```
claude --version
```

**それぞれ何が出たか確認:**

| 結果 | 対処 |
|---|---|
| 全部バージョン番号が出た | ステップ5へ飛んでOK |
| `node` がダメ | https://nodejs.org/ のLTS版 → PC再起動 |
| `git` がダメ | https://git-scm.com/download/win → 選択肢は全部Next → PC再起動 |
| `claude` がダメ | ステップ4へ |

---

# 【手動】ステップ4: Claude Code を入れる

```
npm install -g @anthropic-ai/claude-code
```

数分かかります。終わったら**PowerShellを一度閉じて開き直してから**:

```
cd D:\natsu-project
claude --version
```

バージョンが出れば成功。出なければPCを再起動して再確認。

---

# 【手動】ステップ5: Claudeにログイン

```
claude
```

- ブラウザが開いたらClaude Proのアカウントでログイン
- すでにログイン済みなら何も聞かれません
- 画面が出たら `/exit` と打ってEnterで戻る

**ここを飛ばすと自動実行が全部失敗します。必ずやってください。**

---

# 【手動】ステップ6: GitHubのリポジトリを作る

ブラウザで:

1. https://github.com/new を開く
2. Repository name: `natsu-no-tonari`
3. **Private を選ぶ** ← 重要。Publicにするとゲームも要望も全世界に公開されます
4. 下の「Add a README file」などは**全部チェックを入れない**
5. 「Create repository」
6. 次の画面に出る `https://github.com/あなたのID/natsu-no-tonari.git` をコピー

---

# 【手動】ステップ7: GitHubにつなぐ

PowerShellで1行ずつ。`あなたのID` の部分は実際のものに置き換えてください。

```
git init
```
```
git branch -M main
```
```
git config --global user.name "あなたの名前"
```
```
git config --global user.email "GitHubのメールアドレス"
```

除外設定を作ります(コピペしてEnter):

```
"play_now.html`n.auto_running.lock`n.paused`n.claude_path`nsnapshots/`ninbox/" | Set-Content .gitignore
```

つないでアップロード:

```
git remote add origin https://github.com/あなたのID/natsu-no-tonari.git
```
```
git add -A
```
```
git commit -m "初期状態"
```
```
git push -u origin main
```

**ここでログインウィンドウが出たらログインしてください。**
GitHubは今パスワードでは入れません。パスワードを聞かれて弾かれた場合は、
GitHubの 設定 → Developer settings → Personal access tokens → Tokens (classic) →
Generate new token → repo にチェック → 作られた文字列をパスワード欄に貼ります。

**確認**: GitHubのページを開いてファイルが上がっていれば成功。
スマホのGitHubアプリからも見られるようになります。

---

# 【手動】ステップ8: natsuコマンドを使えるようにする

```
notepad $PROFILE
```

「ファイルが存在しません」と言われたら先にこれ:

```
New-Item -Path $PROFILE -Type File -Force
```

メモ帳が開いたら、次の1行を貼り付けて保存:

```
function natsu { & "D:\natsu-project\natsu.bat" $args }
```

**PowerShellを閉じて開き直す。** これで `natsu` が使えます。

```
natsu doctor
```

診断結果が出れば成功です。

---

# 【手動】ステップ9: 定期実行を登録する

PowerShellに**まるごと**貼り付けてEnter(複数行ですが1回でOK):

```
$Root = "D:\natsu-project"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$Root\auto_improve.ps1`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(3) -RepetitionInterval (New-TimeSpan -Hours 1)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -WakeToRun -ExecutionTimeLimit (New-TimeSpan -Hours 2) -MultipleInstances IgnoreNew
Register-ScheduledTask -TaskName "NatsuNoTonari_AutoImprove" -Action $action -Trigger $trigger -Settings $settings -Description "夏のとなり 自動改善"
```

エラーが出た場合はタスクスケジューラのGUIで登録します
(`SETUP_CHECKLIST.md` の「手動でタスクを登録する場合」を参照)。

**確認:**
```
natsu status
```
「次回の実行」に時刻が出ていればOK。

---

# 【手動】ステップ10: 動作テスト

```
natsu now
```

1回だけ手動で走ります。数分かかることがあります。

```
natsu log
```
```
natsu play
```

ゲームが開けば完成です。

---

---

# イラストの自動化

無料の自動生成(Pollinations.ai、APIキー不要)が定期実行のたびに
勝手に作って組み込みます。何もしなくてOKです。

気に入らない絵が出た場合は手動で差し替えられます。

1. `natsu arts` で必要なイラストとプロンプトを見る
   (スマホなら GitHub の `ART_QUEUE.md`)
2. `prompt:` の行をコピーして好きな画像生成サービス(Geminiアプリなど)に貼り、
   画像を作ってダウンロード
3. **ファイル名を `###` の後ろのキー名に変える**(例: `hanabi_kiss.png`)
   → `natsu inbox` で開くフォルダに入れる → `natsu art`

同じキー名で上書きすれば、自動生成の絵より手動の絵が優先して使われます。

(2026/07/22: Gemini APIキーを使った完全自動化ルートは、課金リスクを避けるため
廃止しました。`gemini_art.ps1` も削除済みです)

---

# セットアップ後にやること

```
natsu doctor
```

全部緑の [OK] なら完成。赤があればその画面をClaudeのチャットに送ってください。

要望の出し方は `HOW_TO_ASK.md` にまとめてあります。
