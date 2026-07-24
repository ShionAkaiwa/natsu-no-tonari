# イラスト待ち行列

まだ絵になっていない場面の一覧です。上から順にどうぞ。

## 待ち行列

### chibi_run
status: 未生成
prompt: Akane in chibi/SD (super-deformed) style, roughly 2.5 heads tall, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, running energetically in a dynamic side-view pose with motion lines behind her, cheerful excited expression, arms pumping. Plain simple dark indigo night-festival background (no other characters, no background clutter, no text). Soft painterly anime style matching the other character art, warm nostalgic summer-festival color accents (lantern orange glow). No text, no watermark, no letters anywhere in the image. Square-ish composition (1:1 or 4:5), full body visible with some margin around her so she can be cropped out and used as a small running sprite during scene-transition cuts.

(2026/07/24追記: REQUESTS.mdの「場面切り替え時のトランジション演出」の話題で、
志温さんから「ミニキャラを出すプロンプトをart queueに追加して」との依頼があったため追加。
現在は光の粒が明滅するだけの1段階目が実装済みで、この絵ができたら、光の粒があった位置に
このミニキャラが一瞬駆け抜けるカットを差し込む2段階目に進める予定。単体の全身イラストとして
生成されるため、組み込み時に周囲の背景を切り抜く/馴染ませる調整が必要になる可能性がある点は
留意。)

## 使い方(Geminiなどに手動で貼る場合)

1. 下の項目から1つ選び、**「prompt:」の行をまるごとコピー**してGemini(アプリ推奨)に貼る
2. 世界観を揃えたいので、参考として `images/akane.png` と `images/bg_torii.png` を
   一緒に添付し、「この絵と同じ画風・同じ茜の顔立ちで、次の場面を描いて」と一言添えると良い
3. 出来た画像を保存し、**ファイル名をその項目の `###` の後ろのキー名に変更**
   (例: `senko.png`)
4. スマホなら GitHub アプリでこのリポジトリを開き、`images` フォルダに直接
   「Add file」→「Upload files」でアップロード(**`inbox` フォルダは `.gitignore` で
   除外されていてGitHub上に存在しないため、スマホから使えるのは `images` フォルダへの
   直接アップロードだけです**)。PCなら `images` フォルダに直接コピーでもOK
5. 次の自動実行(2時間おき)でClaude Codeが中身を確認し、問題なければゲームに組み込んで、
   この項目を `ART_QUEUE_DONE.md` に移します。何もしなくて大丈夫です

自動生成(Pollinations.ai、無料)も並行して動いているので、Geminiで作る前に
先に自動生成の絵が採用されていることもあります。手動で作った絵は自動生成より
優先されるので、気に入らなければ後からいつでも同じキー名で上書きしてください。

生成した絵についての感想・ダメ出しがあれば、各項目の「返信欄」に書いてください
(例:「顔が違う」「浴衣の色がイメージと違う」など。次回Claudeが読んで、
プロンプトの改善やコード側の対応を検討します)。

---

**2026/07/23追記**: 志温さんが以前Geminiに描いてもらっていた20場面ぶんのイラストを
まとめて`images`フォルダにアップロードしてくれた(ファイル名は端末の写真IDのまま
だったため、内容を見て`akane`・`kingyo`など正しいキー名に手動でリネームして
組み込んだ)。これにより、`onbu`を含む20場面すべてがこのGemini版に差し替わっている
(自動生成のPollinations版から置き換え)。差し替え済みだった項目のプロンプトは
志温さんの許可を得て`ART_QUEUE_DONE.md`に移した。

すでに組み込み済みの項目は `ART_QUEUE_DONE.md` に移してあります。

---

## このファイルについての感想・要望
ここに一言書いておくと、次回Claude Codeが読んで対応します(REQUESTS.mdほど
頻繁なやり取り向けの場所ではありませんが、このファイルの内容についての
意見や削除してほしい部分などがあれば、ここが窓口です)。

▼返信はここに
