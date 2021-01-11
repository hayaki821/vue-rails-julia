# rails-vue

## 環境構築手順
```
1,git cloneを行う
2,cd vue-rails-julia
2,yarn add vue@next vue-loader@next @vue/compiler-sfc
3,yarn add vue-router@^4
4,yarn add axios --save
5,docker-compose up
```
## アプリケーションの概要
1,環境構築後docker-compose upでlocalhost:8080でホーム画面にアクセスできるようになる。その後「julia集合生成ページへ」をクリックでhttp://localhost:8080/satori/juliaへアクセスできるようになる。
2,http://localhost:8080/satori/juliaへアクセスしフロント側でジュリア集合作成に必要なパラメータを受け取るフォームがあるので値を自由に入力する。（デフォルト値が入ってます。）
3,「ジュリア集合を生成する」ボタンを押下するとフォームのパラメータがバックエンドに送られる。
4,バックエンドが受け取ったパラメータをジュリア集合生成クラスで処理し、ジュリア集合をrgba値としてフロント側に返す。
5,フロント側で受け取ったrgba値をキャンバスを用いてジュリア集合の描画を行う。（フォームの下に描画される。）
 

## julia集合生成のルール
・複素漸化式の計算回数の境界値を100回とした。計算回数が100回を超えたら収束するとみなし黒色で表示。計算回数が100回に近づくほど赤色ぽく表示し、0回に近いほど強い青色で表示される。緑要素は今回は使わなかった。計算の過程で小数点以下も出てくるがすべて四捨五入し、整数でrgb値を返している。
また色味付の式は
赤: (計算回数/100)^0.3*255,
緑:0,
青: ((1-計算回数)/100)^0.3*255

##自分の中でのテーマ
今まで触れてこなかった技術や設計を取り入れつつ、できる限り保守性を意識して作成する。

## 初めて挑戦したこと、今までやったことがないもの
・ruby,railsを用いた開発
・vue3の導入（vue2までの開発経験はあった）
・dockerでvue3,rails6の環境を構築したこと
・アトミックデザインをフロント側で取り入れた(Atom,Template以外)
・Materializeの導入

## 特に見てほしいところ、工夫したこと
（バック）
・rails側ではジュリア集合の作成のみを行いそれを返すAPIとし、フロントで描画を行うことで描画速度を早めようとしたことが特に工夫できたところです。今回はDBに保存する必要なども特にないことなどから、わざわざバックエンドで描画まで行い画像を作る必要がないと考えました。また、バックエンドでジュリア集合の描画（画像を作成）までを行いフロントに返す処理だととても重くなりそうだったことも考慮しました。rails側での計算速度は遅いということもあり、描画はcanvasを用いることで少しは処理速度が上がったと思います。

・DB,modelを作成をしない方針で進めたためmodelのバリデーションを使わず自作でバリデーションを作成しました。modelを作成するほうが楽だと思いましたが、DBを立ち上げない状態だとうまくいかないのではないかと考えmodelは作成しないことにしました。またDBを立ち上げないことで速度も早くなると考えdocker環境上にもDBを立ち上げずに、データベースを利用しないアプリケーションとして作成しました。

・Fat Controllerを防ぐためにservice層を導入し、複雑な処理をservice層に記載しました。複雑な処理をを切り離すことで責任範囲を明確にし、修正をしやすく他人が見てわかりやすいといったメリットがあると思ったのでservice層を導入しました。

・csrf tokenでのエラーをなくしました。

（フロント）
・ローディングを実装しました。ジュリア集合の生成までにある程度の時間がかるので不具合が発生しないように通信が終わるまでのローディングを実装し、ボタンの連打ができないようにしました。

・CreateJuliaForm.vueで各ジュリア集合用パラメーターの入力フォームを作成する必要がありましたが、1つずつ作成するのではなくfor文を使いながら効率よくかつコード量が減るように作成しました。また入力フォームは共通で使い回せる上にmoleculesとしての役割があると考えたためコンポーネント化しました。その他のボタンなども含めAtomも作り、さらに細かくコンポーネント化するか迷いましたが逆に見にくくなりそうだったためAtomまでは作りませんでした。

（共通）
・変数名や関数名をできるだけわかりやすい名前をつけるようにしました。また、英語でコメントを残しながら読みやすくなるように心がけました。

## 悩んだこと
・今回ルーティングも取り入れてみたいと思い、初期画面をトップページ、ページを遷移してジュリア集合作成画面に行くようにしました。そこで、ルーティングをrails側で行うか、vue-routerを用いてSPAにするかでかなり迷いました。それぞれのメリットなどをかなり調べたり考えたりしましたが、もしどちらでルーティングを行うかの採用方法などがありましたらフィードバックいただけますと嬉しいです。
最終的にvue-routerを用いてSPAにする方針で作成しました。
理由：
1,rails側はapiの実装のみで十分だと思いました。sessionやログイン機能などを今回は実装しないためrailsのルーティング機能を使う必要がないと判断しました。
2,以前貴社のインターンシップに参加した際、rails側でルーティングをしてアプリを作成したため、今回はvue-routerを用いて挑戦してみようと思いました。また、railsでvue-routerを使ったとき注意することやどちらを優先してルーティングされるのかなどを学びたかったからです。

・複素定数の実部と虚部の受け渡し、それら値のバリデーションを含めた処理について。複素数(a+bi)でバックエンドに送る処理を実装するのはできないと思ったのでどのように処理するか迷いました。問題文では複素定数comp_constとしてやり取りを行うということだったので、最終的にはネスト構造で複素数を表現しました。

・service層の導入がアンチパターンに当たるかどうかで悩みました。今回modelを作成していないためservice層の導入が正しいのかどうかや、大規模ではないため逆に複雑になるのかではないかという点で特に悩みました。最終的にはこちらの記事（https://euglena1215.hatenablog.jp/entry/2018/03/21/220604）を参考にして考えました。また、引数の扱いがControllerで処理を書くより楽になったことからservice層を導入しました。

・vuexを導入するかどうかで悩みました。今回作成するものはそこまで状態を管理する必要がないということや、逆に複雑になるかと考え導入はしませんでした。ただ、もしもっと複数の機能をつけることになっていけば導入したほうがわかりやすかったかと思いました。

## 苦労したこと
・環境構築。rails6、vue3の環境をdockerで構築しましたが参考記事がなかなかなく、環境を構築するのに時間がかかりました。ただかなりdockerの勉強になりました。

・rails、vue3それぞれの技術のキャッチアップをしながら期限に間に合うように作成したこと。特にruby,railsは初めてだったので慣れるまで時間がかかりました。たクラスを作成したりコントローラやル−ティングについて理解することができ、だいぶ勉強になったと思います。

・rubyの浮動小数点の取り扱いについて。最初ジュリア集合生成の計算をしたときなど小数点以下が切り捨てられうまく計算できませんでした。有効数字については<input type="number"  v-model.number>のチェックをおこなうことで有効数字は１７桁までとしたが、時間があれば任意で有効数字を変えられるようにしたかったです。また有効数字に関するバリデーションも実装できたら良かったです。

・Suspenseを用いてローディングを実装しようとしたこと。Suspenseは非同期的なデータのfetchに関しての処理には使えましたが、ジュリア集合の生成を行うpostの通信にはうまく用いることができそうになかったので、単に状態管理でローディングを実装しました。
　loadingの状態管理について、今回vuexを導入しなかったことからpropsでのやり取りが複数のコンポーネントをまたぐことになると思ったのでCreateJuliaPage.vueでローディングコンポーネントを書きましたが、どういう風に設計するかで悩みました。

・フロント側でコンポーネント間でのデータの受け渡しをうまくするのに苦戦しました。親子孫の3つのコンポーネント間のやり取りで、props in / events outによって親要素から孫要素、孫要素から親要素まで伝搬を行う必要があったため少しコードの記述量が増えました。また、コードを書いてる中でリアクティブ性が失われるなどして少し苦戦しました。
 emitの使い方に関しましてもvue2と若干違った部分があり、エラーを解決するのにも時間がかかりました。

## 時間があればやってみたかったこと
・typescriptの導入
・有効桁数のバリデーションの実装
・rails側でジュリア集合生成のための計算を高速化
・スタイルをもう少しつける
・フロント、バックそれぞれのアンチパターンがあればそれらを改善する
・テストを行えるようにする

## 感想
自分で1から構成や設計、環境構築、コードをどのように書いていくかを決めてアプリを作成したのは初めてだったので苦戦した部分もいくつかありましたがとても楽しくアプリを作成することができました。特にvue3,railsなど新しいことにたくさん挑戦することができたのでとても楽しみながら開発を行うことができましたし学ぶことも多かったです。元々フルスタックエンジニアを目指していましたが、今回の開発を通して自分はフルスタックエンジニアとして働くのが一番しっくりくると感じ、改めて今後のなりたいエンジニア像を再確認できました。技術的な成長だけではなく今後のなりたいエンジニア像の再確認もできたことは、この技術選考に挑戦してよかったなと思いました。
今回作成したアプリケーションにはプロの方から見るとまだまだ直すべき欠点や足りていない部分が多々あるを思います。まずはエンジニアとしてプログラミングの技術を最大限高めていけたらいいなと思っています。そのためにはやりきって終わりではなく、足りていない部分は改善していくことで成長ができると思います。そのため、もしよろしければアドバイスなどをいただけると嬉しいです。

以上です。