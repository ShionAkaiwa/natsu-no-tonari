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

### omikuji — おみくじを引く茜(境内)
どこで使う: 屋台「おみくじ」を選んだときの一枚絵
status: 組込済
retries: 2
(2026/07/22: 1回目は提灯に読める文字が写り込んでいたため差し戻し。2回目は提灯は消えたが、
手に持つおみくじの紙自体に手紙のような文字列がはっきり書き込まれてしまっていたため再度差し戻し。
紙が完全に白紙であることをより強く指定する形に書き直した。2026/07/23、3回目の生成で紙が完全に
白紙になっていることを確認し、組み込み済みとした)
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing alone in a quiet shrine courtyard at night lit only by plain moonlight and one unlit stone lantern (toro), holding a completely blank plain white paper strip with absolutely no writing, no printed characters, no ink marks, no lines of any kind on it (a pure blank sheet of paper, not a letter, not a card with text), curious hopeful expression looking at the blank paper, empty background with no hanging paper lanterns, no chochin, no signage, no kanji or text of any kind anywhere in the scene. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters, no handwriting, no readable characters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### yokogao — 花火を見上げる茜の横顔
どこで使う: 丘ルート、クライマックス直前
status: 組込済
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, shown in profile close-up looking up at fireworks bursting in the night sky, soft golden fireworks light reflected on her face, quiet awed expression, gentle wind in her hair. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### nakiwarai — 泣き笑いの茜(アップ)
どこで使う: 丘ルート、告白直後
status: 組込済
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, extreme close-up portrait, tearful eyes with a single tear but smiling warmly at the same time, soft warm night lighting, tender emotional expression. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### geta — 壊れた下駄を持つ茜(夜道)
どこで使う: 鼻緒(hanao)ルートの開始場面(鼻緒が切れる)
status: 組込済
retries: 2
(2026/07/23: 3回目の生成で、両手に持つ茶色い木製の台に鼻緒のついた本物の下駄の形に
なっていることを確認。容姿設定・場面の雰囲気とも問題なし。採用)
> 返信欄:

### onbu — おんぶされる茜(夜道)
どこで使う: 鼻緒ルート、おぶっていく場面
status: 要手動
retries: 3
(2026/07/23: 3回目の生成も、正面の人物が茜をおぶっているというよりは背後から
抱きついているだけの構図になっており、脚が地面から離れて相手の腰に回っている
様子が確認できず、加えて浴衣の背中が大きく開いて素肌が露出してしまっており
「濃紺の花柄浴衣」の容姿設定とも食い違っていた。retriesが3に達したため
CLAUDE.mdのルールに従い自動でのやり直しを停止し、IMPROVEMENTS_LOGに
要ユーザー判断として記録した。このプロンプトでの自動生成は一旦保留)
prompt: A close-up night-time piggyback ride scene filling most of the frame with two full figures, both large and clearly visible, NOT a solo portrait of one person alone: in front, the broad back and shoulders of a faceless young man (back view only, face not shown) bent slightly forward, actively carrying a woman on his back. Riding on his back is Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata fully closed and covering her back with no exposed skin on the back; her chest and body pressed against his back, both her arms wrapped around his neck and shoulders from behind, both her legs lifted completely off the ground and wrapped around his sides at waist height, her feet clearly not touching the road, her cheek resting near his shoulder with a soft embarrassed happy smile. This must depict active carrying/lifting, not two people merely standing, walking side by side, or hugging from behind. Quiet night road, moonlight and warm distant lantern glow. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### fukuro — 線香花火の袋を掲げる茜(玄関)
どこで使う: 鼻緒ルート中盤(線香花火を買ってくる場面)
status: 組込済
(2026/07/23確認: 玄関先で線香花火の袋を掲げて笑う構図・容姿設定とも問題なし。採用)
> 返信欄:

### senko — 川辺で線香花火をする茜(月)
どこで使う: 鼻緒ルートのクライマックス
status: 組込済
(2026/07/23確認: 川辺にしゃがみ線香花火を持つ構図・満月・容姿設定とも問題なし。採用)
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, crouching by a quiet riverbank at night holding a lit sparkler firework (senko-hanabi), small delicate spark of light illuminating her gentle focused face, full moon reflecting on the dark water behind her. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).
> 返信欄:

### senko2 — 二人の手元の線香花火(川辺・アップ)
どこで使う: 鼻緒ルートのラストカット
status: 組込済
retries: 2
(2026/07/23: 1回目の生成は、二人の手元ではなく一人の女性の横顔と片手だけが
写った構図になっており(yokogaoに近い絵)、「二人の手元」という意図と
食い違っていたため差し戻し。顔を一切写さず、手と線香花火だけのアップに
限定する形にプロンプトを書き直した。2回目の生成は構図自体(二人の手・線香花火)は
指定通りだったが、仕上がりが実写風の写真そのもの(人物写真)になっており、
他の11枚すべてが持つ「Soft painterly anime style」の絵柄と明確に食い違っていた
ため差し戻し。プロンプトに"Soft painterly anime style"の指定はあったが実写に
寄ってしまったため、実写・写真であることを明確に禁止する記述を追加した。
3回目の生成で、はっきりとした線画・塗りのアニメ塗り(実写ではない)になっており、
顔を写さず二人の手と線香花火のアップという構図・浴衣の柄も指定通りで確認できたため採用)
prompt: A hand-drawn digital illustration, NOT a photograph, NOT photorealistic, NOT a real photo — an anime/manga style painting with visible painterly brushstrokes. Extreme close-up illustration showing ONLY two hands and nothing else, no faces, no heads, no upper bodies visible in frame: two separate hands from two different people holding their own lit sparkler fireworks (senko-hanabi) close together near a riverbank at night, the hands almost touching, one hand belonging to Akane emerging from a dark navy blue floral yukata sleeve visible at the very edge of frame, the other hand belonging to a man emerging from plain dark clothing sleeve at the opposite edge of frame. Tiny glowing spark and soft falling embers between the two sparklers, dark water faintly reflecting light in the blurred background, intimate quiet mood. This is a hand-only macro illustration; do not show any face or profile. Soft painterly anime style illustration, cel-shaded or painterly digital art, cool nostalgic night color palette, gentle brush texture, cinematic lighting, stylized proportions (not photorealistic skin texture). No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).
> 返信欄:

### bg_title — タイトル画面の背景イラスト(新規追加)
どこで使う: ゲーム起動直後、一番最初のタイトル画面([はじめから]ボタンが出る画面)の背景
status: 組込済
(2026/07/23確認: 鳥居と提灯の並ぶ夏祭りの入口に立つ茜、容姿設定・画風とも
既存11枚と一致。下段はUIボタンと重ならない程度に開いている。採用)
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing at the entrance of a night summer festival with a torii gate and glowing paper lanterns behind her, gentle warm smile looking toward the viewer, fireflies and floating embers drifting in the air, a sense of quiet anticipation for the night ahead. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting, atmospheric depth. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16), leave the lower third relatively open/uncluttered since UI buttons will be overlaid there.
> 返信欄:

---

すでに組み込み済みの項目は `ART_QUEUE_DONE.md` に移してあります。
