# イラスト待ち行列

まだ絵になっていない場面の一覧です。上から順にどうぞ。

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

### bg_title — タイトル画面の背景イラスト(茜が写らないバージョンに差し替え希望)
どこで使う: ゲーム起動直後、一番最初のタイトル画面([はじめから]ボタンが出る画面)の背景
status: 未生成
(2026/07/23: 現在組み込み済みの`bg_title`(鳥居の前に立つ茜)について、志温さんから
「タイトル画面がなんとなくさみしい気がする」「茜が登場しないイラストの方がいいかも」
との希望があった。同じキー名`bg_title`で新しい画像を上書きアップロードすれば
自動的に差し替わる。風景だけの画作りなので、既存11枚と違って人物の顔・体型の
一致確認は不要)
prompt: A quiet Japanese summer festival entrance at dusk with absolutely no people or human figures anywhere in the scene, an old stone torii gate at the top of a stone stairway, rows of glowing paper lanterns strung along both sides of the path leading up to it, warm orange and deep magenta sunset sky fading into the coming night, fireflies and floating embers drifting softly in the air, faint smoke haze, a sense of quiet anticipation before the festival truly begins. Soft painterly anime background art style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting, atmospheric depth. No text, no watermark, no letters anywhere in the image. No human figures, no silhouettes of people, empty scene. Vertical portrait composition (9:16), leave the lower third relatively open/uncluttered since UI buttons will be overlaid there.
> 返信欄:

---

すでに組み込み済みの項目は `ART_QUEUE_DONE.md` に移してあります。
