# 対話ノート

ここが志温とClaude Codeの会話の場です。

## 書き込み方

**PCから**
- 一言: `natsu req "花火をもっと長くしてほしい"`
- 長文: `natsu talk`(メモ帳が開く)

**スマホから(GitHubアプリ)**
1. リポジトリを開く →「Code」タブ → `REQUESTS.md` をタップ
2. 右上の鉛筆マーク(編集)をタップ
3. 一番下までスクロール
4. 思ったことをそのまま1行書く(下の書式は気にしなくてOK)
5. 右上のチェック →「Commit directly to the main branch」

書式は厳密でなくて構いません。Claudeが文章として読んで理解します。
たとえば一番下にこう書くだけでも伝わります:

```
金魚すくいのシーン、もう少しはしゃいでる感じにしてほしい
```

Claude Codeは毎回の実行でこのファイルを最初に読み、まだ返事のついていない
要望を最優先で処理して、その下に返事を書きます。返事は次にGitHubを開いたときや
PCで `natsu status` を打ったときに読めます。

---

## 記入例(こう書けるとより伝わりやすい、という参考)

## 07/21 12:25 志温
金魚すくいのシーン、茜がもうちょっとはしゃいでる感じにしてほしい

> **Claude 07/21 14:10** — 対応しました。金魚すくいの台詞を3箇所書き換え、
> はしゃいだ反応の分岐を1つ追加しています。`natsu play` で確認してみてください。
> なお「金魚を逃がしてしまう」パターンも作れそうですが、切ない方向になるので
> 追加するか迷っています。欲しければここに一言ください。

---

(ここから下に書き足していってください。書式は自由です)

## 07/21 19:47 志温
タイトル画面の「イラストを読み込む」機能をやめて、既存の11枚も含めて全部このHTMLファイル1つで完結する形(images/ART_DATAの仕組み)に統一してほしい。スマホなど別の端末にこのファイル1つだけコピーしても、絵込みでそのまま遊べるようにしたい

> **Claude 07/21 20:15** — タイトル画面の「イラストを読み込む」(ファイルを毎回選んで
> このPCのブラウザに読み込む方式)は完全に削除しました。ゲームは今後
> `<script id="ART_DATA">`(`window.ART`)に焼き込まれた絵だけを使います。
> `art_embed.ps1`(`natsu art`、および1時間おきの自動実行でも毎回走ります)が
> `images` フォルダの中身をbase64化してHTMLに直接埋め込む仕組みは、実は前回の
> セッションが並行してすでに作りかけていたので、それを完成させる形になりました。
>
> ただ1つ確認したいことがあります。`images` フォルダの中身を見たところ、
> **今は0枚**でした(gitの履歴にも一度も入っていません)。「既存の11枚」は、
> おそらく前に「イラストを読み込む」でこのPCのブラウザにだけ読み込んでいた
> 11枚のことだと思うのですが、それはブラウザのIndexedDBの中にあるだけで、
> ファイルとしてはこちらから触れない場所にあります。
>
> お手数ですが、その11枚の画像ファイルを `D:\natsu-project\images` フォルダに
> 直接コピーしてもらえますか(ファイル名は場面のキー名+拡張子、例:
> `akane.jpg`)。使えるキー名は以下の20種類です:
> `bg_torii, akane, bg_yatai, ringo, kingyo, shateki, kakigori, kitsune,
> bonodori, omikuji, maigo, sashidashi, bg_oka, yokogao, nakiwarai, geta,
> onbu, fukuro, senko, senko2`
> 置いてもらえれば、次の自動実行(または `natsu art`)で自動的にHTMLへ
> 焼き込まれます。ファイル名がどれに対応するか分からない場合は、
> とりあえず `inbox` フォルダに好きな名前で入れて教えてもらえれば、
> 次回こちらで振り分けます。

20260722
[Netlify] Action needed: shion has used all available credits — upgrade to restore full service
shion has used its full credit allowance for this billing cycle. We’ve added 30 operational credits to keep your published sites online. These credits can’t be used for production deploys or Agent Runners, so those stay paused until you upgrade.
ってのがメールできてたよ。じょうげんが来た的なやつかな?どうする?
