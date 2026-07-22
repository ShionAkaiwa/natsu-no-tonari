# イラスト待ち行列

Claude Code が「この場面に絵が欲しい」と判断したものを、
無料の自動生成に投げられるプロンプト付きでここに書き出します。

## 使い方

**自動(何もしなくていい)**
定期実行のたびに、無料の画像生成(Pollinations.ai。課金なし・登録不要)で
勝手に作られ、`inbox` に保存されて次の実行でゲームに組み込まれます。
今すぐ試したいときは `natsu autoart`。

自動生成の絵が気に入らない場合は、`images` フォルダに手持ちの画像を
直接置いて `natsu art` を実行すれば、自動生成より優先して使われます。

## status の意味
- `未生成` … これから作る
- `生成済み` … 作成済み。inbox または images にある
- `要手動` … 自動生成では思うようにならなかった。手を入れてほしい
- `組込済` … ゲームに組み込み済み

`retries: N` という行が付いていることがありますが、これは
Claudeが生成結果を見て「イマイチだから作り直す」を何回試したかの
記録です。触らなくて大丈夫です。

---

## 書式の例(Claude Codeがこの形で書き足します)

### hanabi_kiss
status: 要手動
prompt: Anime style illustration, warm summer festival night. A young Japanese woman around 20 years old with chestnut brown hair in a high bun, wearing a dark navy blue yukata with a floral pattern. She is looking up at large fireworks bursting in the night sky, her face lit softly by the golden light, expression of quiet joy. Viewed from slightly behind and to the side. Soft painterly anime style, warm color palette, bokeh lights from festival stalls in the background. No text, no watermark, no letters anywhere in the image. Vertical composition.

---

(ここから下にClaudeが書き足していきます)

### bg_torii
status: 組込済
prompt: Empty stone approach path to a traditional Japanese shrine torii gate at dusk, summer festival lanterns strung along the path, warm orange and deep magenta sunset sky, soft atmospheric haze, no people. Soft painterly anime background art style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).

### akane
status: 組込済
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair styled in a high bun, wearing a dark navy blue yukata with a delicate floral pattern, standing in front of a shrine torii gate at dusk, warm orange and magenta sunset light glowing behind her, gentle shy smile, looking toward the viewer, soft summer breeze. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### bg_yatai
status: 組込済
prompt: Empty Japanese summer festival stall street at night, rows of glowing paper lanterns, warm orange lantern light against a deep indigo night sky, faint smoke and steam from food stalls, bustling atmosphere but no people visible. Soft painterly anime background art style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).

### ringo
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, happily holding up a shiny red candied apple (ringo-ame) at a night festival, warm lantern light on her face, playful joyful expression. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### kingyo
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, crouched at a goldfish scooping (kingyo-sukui) stall, holding a paper poi scoop over a shallow water tub with orange goldfish, intensely focused expression, warm festival lantern light reflecting on the water. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### shateki
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, seen from behind and slightly to the side, aiming a cork gun at a shooting gallery (shateki) stall lined with prize toys, focused posture, warm lantern light, festival night atmosphere. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### kakigori
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, happily eating shaved ice (kakigori) with bright red strawberry syrup from a paper cup, sitting on a bench at a night festival, warm lantern light, sweet contented expression. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### kitsune
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, playfully wearing a traditional fox (kitsune) festival mask pushed up on top of her head, laughing brightly, warm golden lantern light at a night festival. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### bonodori
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata with wide sleeves flowing, dancing joyfully in a bon-odori circle dance under a wooden yagura tower strung with red lanterns, warm night festival glow, motion and energy in her pose. Soft painterly anime style, warm nostalgic summer-festival color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### omikuji
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing in a quiet shrine courtyard at night, holding a thin paper fortune slip (omikuji), curious hopeful expression reading it, soft lantern and moonlight, rows of tied fortune papers faintly visible in the background. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### maigo
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, crouching down at eye level talking gently to a small lost child at a night festival, warm caring expression, soft lantern light, blurred festival crowd and stalls in the background. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### sashidashi
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, looking back over her shoulder and reaching out her hand toward the viewer, fireworks bursting in the night sky behind her, warm golden light on her face, inviting gentle smile. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### bg_oka
status: 未生成
prompt: Empty quiet hilltop overlooking a distant town at night, scattered warm city lights below, deep blue night sky with soft stars, gentle grass in the foreground swaying, tranquil peaceful atmosphere, no people. Soft painterly anime background art style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).

### yokogao
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, shown in profile close-up looking up at fireworks bursting in the night sky, soft golden fireworks light reflected on her face, quiet awed expression, gentle wind in her hair. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### nakiwarai
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, extreme close-up portrait, tearful eyes with a single tear but smiling warmly at the same time, soft warm night lighting, tender emotional expression. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### geta
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing barefoot on a quiet night road holding her broken wooden sandal (geta) in one hand, looking down at it with a rueful gentle smile, soft moonlight and distant streetlight glow. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### onbu
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, being given a piggyback ride along a quiet night road, seen from the side, her arms gently around the shoulders of the person carrying her (faceless or back-view male silhouette), soft embarrassed happy smile, moonlight and warm distant lantern glow. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### fukuro
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, standing at a traditional wooden entryway (genkan) at night, cheerfully holding up a small paper bag of sparkler fireworks (senko-hanabi), bright happy smile, warm porch light. Soft painterly anime style, warm nostalgic color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### senko
status: 未生成
prompt: Akane, a young Japanese woman around 20 years old, chestnut brown hair in a high bun, wearing a dark navy blue floral yukata, crouching by a quiet riverbank at night holding a lit sparkler firework (senko-hanabi), small delicate spark of light illuminating her gentle focused face, full moon reflecting on the dark water behind her. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical portrait composition (9:16).

### senko2
status: 未生成
prompt: Close-up of two hands holding lit sparkler fireworks (senko-hanabi) close together by a riverbank at night, one hand belonging to Akane, a young Japanese woman around 20 years old wearing a dark navy blue floral yukata sleeve visible at the edge of frame, tiny glowing spark and soft falling embers, dark water faintly reflecting light in the background, intimate quiet mood. Soft painterly anime style, cool nostalgic night color palette, gentle brush texture, cinematic lighting. No text, no watermark, no letters anywhere in the image. Vertical composition (9:16).
