# イラスト待ち行列

Claude Code が「この場面に絵が欲しい」と判断したものを、
自動生成 or 手動でGeminiに投げられるプロンプト付きでここに書き出します。

## 使い方

**自動(何もしなくていい)**
定期実行のたびに、無料の画像生成(課金なし・登録不要)で勝手に作られ、
`inbox` に保存されて次の実行でゲームに組み込まれます。
今すぐ試したいときは `natsu autoart`。

**手動でやりたい場合**
自動生成の絵が気に入らない、または自分でクオリティにこだわりたいときは:
1. 下の `prompt:` の行をコピーしてGeminiアプリ(gemini.google.com)に貼る
2. できた画像をダウンロード
3. **ファイル名を `###` の後ろのキー名に変える**(例: `hanabi_kiss.png`)
4. `inbox` フォルダに入れる
5. PCで `natsu art` を実行(または次の自動実行を待つ)

自動で作られた絵を、あとから手動の絵で上書きすることもできます。

## status の意味
- `未生成` … これから作る
- `生成済み` … 作成済み。inbox または images にある
- `要手動` … 自動生成では思うようにならなかった。手でやってほしい
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
