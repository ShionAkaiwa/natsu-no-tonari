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

### kitsune — お面屋の茜(狐面を頭に乗せて笑う)
どこで使う: 屋台「お面屋」を選んだときの一枚絵
status: 未生成
retries: 1
prompt: Akane, a young Japanese woman around 20 years old, fully human with normal human ears (absolutely no animal ears, no fox ears, no kemonomimi), chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, holding a traditional flat white fox festival mask (kitsune-men, a solid painted paper/ceramic mask like a Noh mask) tilted up and resting on top of her head like a hat so her own human face is fully visible and laughing brightly, warm golden lantern light at a night festival. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### omikuji — おみくじを引く茜(境内)
どこで使う: 屋台「おみくじ」を選んだときの一枚絵
status: 未生成
retries: 1
(2026/07/22: 提灯に読める文字が写り込んでいたため差し戻し。提灯・文字を消す指定に書き直し済み)
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing alone in a quiet shrine courtyard at night lit only by plain moonlight and one unlit stone lantern (toro), holding a thin blank paper fortune slip (omikuji) with no writing or printed characters on it, curious hopeful expression reading it, empty background with no hanging paper lanterns, no chochin, no signage, no kanji or text of any kind anywhere in the scene. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters, no readable characters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### bg_oka — 丘から見る夜景(背景のみ・人物なし)
どこで使う: 丘(oka)ルート、告白直前の静かな場面の背景
status: 未生成
prompt: Empty quiet hilltop overlooking a distant town at night, scattered warm city lights below, deep blue night sky with soft stars, gentle grass in the foreground swaying, tranquil peaceful atmosphere, no people. Soft painterly anime background art style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).
> 返信欄:

### yokogao — 花火を見上げる茜の横顔
どこで使う: 丘ルート、クライマックス直前
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, shown in profile close-up looking up at fireworks bursting in the night sky, soft golden fireworks light reflected on her face, quiet awed expression, gentle wind in her hair. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### nakiwarai — 泣き笑いの茜(アップ)
どこで使う: 丘ルート、告白直後
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, extreme close-up portrait, tearful eyes with a single tear but smiling warmly at the same time, soft warm night lighting, tender emotional expression. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### geta — 壊れた下駄を持つ茜(夜道)
どこで使う: 鼻緒(hanao)ルートの開始場面(鼻緒が切れる)
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing barefoot on a quiet night road holding her broken wooden sandal (geta) in one hand, looking down at it with a rueful gentle smile, soft moonlight and distant streetlight glow. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### onbu — おんぶされる茜(夜道)
どこで使う: 鼻緒ルート、おぶっていく場面
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, being given a piggyback ride along a quiet night road, seen from the side, her arms gently around the shoulders of the person carrying her (faceless or back-view male silhouette), soft embarrassed happy smile, moonlight and warm distant lantern glow. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### fukuro — 線香花火の袋を掲げる茜(玄関)
どこで使う: 鼻緒ルート中盤(線香花火を買ってくる場面)
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing at a traditional wooden entryway (genkan) at night, cheerfully holding up a small paper bag of sparkler fireworks (senko-hanabi), bright happy smile, warm porch light. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### senko — 川辺で線香花火をする茜(月)
どこで使う: 鼻緒ルートのクライマックス
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, crouching by a quiet riverbank at night holding a lit sparkler firework (senko-hanabi), small delicate spark of light illuminating her gentle focused face, full moon reflecting on the dark water behind her. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### senko2 — 二人の手元の線香花火(川辺・アップ)
どこで使う: 鼻緒ルートのラストカット
status: 未生成
prompt: Close-up of two hands holding lit sparkler fireworks (senko-hanabi) close together by a riverbank at night, one hand belonging to Akane, a young Japanese woman around 20 years old wearing a dark navy blue floral yukata sleeve visible at the edge of frame, tiny glowing spark and soft falling embers, dark water faintly reflecting light in the background, intimate quiet mood. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).
> 返信欄:

### bg_title — タイトル画面の背景イラスト(新規追加)
どこで使う: ゲーム起動直後、一番最初のタイトル画面([はじめから]ボタンが出る画面)の背景
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing at the entrance of a night summer festival with a torii gate and glowing paper lanterns behind her, gentle warm smile looking toward the viewer, fireflies and floating embers drifting in the air, a sense of quiet anticipation for the night ahead. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting, atmospheric depth. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16), leave the lower third relatively open/uncluttered since UI buttons will be overlaid there.
> 返信欄:

---

すでに組み込み済みの項目は `ART_QUEUE_DONE.md` に移してあります。
