# イラスト待ち行列

Claude Code が「この場面に絵が欲しい」と判断したものを、
そのままGeminiに投げられるプロンプト付きでここに書き出します。

## 使い方

**自動でやる場合(APIキー設定済み)**
何もしなくていいです。`natsu gemini` または定期実行が勝手に作って
`inbox` に保存し、次の実行でゲームに組み込まれます。

**手動でやる場合**
1. 下の `prompt:` の行をコピーしてGeminiに貼る
2. できた画像をダウンロード
3. **ファイル名を `###` の後ろのキー名に変える**(例: `hanabi_kiss.png`)
4. `inbox` フォルダに入れる
5. PCで `natsu art` を実行(または次の自動実行を待つ)

これだけでゲームに組み込まれます。

## status の意味
- `未生成` … これから作る
- `生成済み` … 作成済み。inbox または images にある
- `要手動` … 自動生成に失敗した。手でやってほしい
- `組込済` … ゲームに組み込み済み

---

## 書式の例(Claude Codeがこの形で書き足します)

### hanabi_kiss
status: 要手動
prompt: Anime style illustration, warm summer festival night. A young Japanese woman around 20 years old with chestnut brown hair in a high bun, wearing a dark navy blue yukata with a floral pattern. She is looking up at large fireworks bursting in the night sky, her face lit softly by the golden light, expression of quiet joy. Viewed from slightly behind and to the side. Soft painterly anime style, warm color palette, bokeh lights from festival stalls in the background. No text, no watermark, no letters anywhere in the image. Vertical composition.

---

(ここから下にClaudeが書き足していきます)
