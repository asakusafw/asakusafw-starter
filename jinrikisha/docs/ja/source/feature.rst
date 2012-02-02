==================
Jinrikisha の 特徴
==================
この文書ではJinrikishaの特徴を紹介します。

開発環境向けの All in One パッケージ
====================================
JinrikishaはAsakusa Frmaeworkによるアプリケーション開発に必要なライブラリやツールをパッケージングしています。このパッケージ1つで開発に必要な環境がすべて整います。

`Asakusa Framework入門`_ の `Asakusa Framework スタートガイド`_ で説明されている開発環境の構築手順は、Jinrikishaを使ったインストールによってほとんどの手順が不要になります。以下に `Asakusa Framework スタートガイド`_ で必要となる個々の手順がJinrikishaを使ってインストールした場合、どのようになるかを説明します。

Javaのインストール
------------------
Ubuntu版では、Javaのインストールが行われていない場合、 `OpenJDK`_ を自動インストールすることでJavaのインストールを自動化することができます。本格的なアプリケーションの開発時にはOpenJDKの使用は推奨しませんが、Asakusa Frameworkを簡単に試すには便利なオプションです。

とりあえずOpenJDKで試用し、後からOracleJDKに切り替えることもできます。JDKを切り替える場合、Jinrikishaのインストールディレクトリ配下の ``.rikisha_profile`` に定義されているJAVA_HOMEの値を変更してください。

Mavenのインストールとセットアップ
---------------------------------
Jinrikishaはインストールパッケージに Maven を同梱しています。

MavenはJinrikishaによって自動的にインストールされます。

Hadoopのインストールとセットアップ
----------------------------------
Jinrikishaはインストールパッケージに Hadoop( `Cloudera's Distribution including Apache Hadoop Version 3 (CDH3)`_ )を同梱しています。 

HadoopはJinrikishaによって自動的にインストールされ、スタンドアロンモードで動作するよう設定されます。

環境変数の設定
--------------
環境変数の設定はJinrikishaによって自動的に行われます。

Eclipseのインストール
---------------------
Jinrikishaはインストールパッケージに Eclipse を同梱しています。

EclipseはJinrikishaによって自動的にインストールされます。

Asakusa Frameowrkのインストール
-------------------------------
Asakusa Frameworkのインストールとサンプルアプリケーションの作成、ビルド、デプロイがJinrikishaによって自動的に行われます。

1つのディレクトリ配下にすべてのコンポーネントをインストール
===========================================================
Jinrikisha のインストール時に指定した単一のディレクトリ配下に、HadoopやEclipseなど、Asakusa Frameworkの開発に必要なすべてのコンポーネントをインストールします [#]_ 。既にHadoopやMavenが入っている環境と共存することなども容易になっています。

..  [#] Java本体についてはOSのパッケージ管理システムの仕様に依存します。また、OSユーザのプロファイル設定ファイル( ``$HOME/.profile`` または ``$HOME/.bash_profile`` )に対する設定の追加や、デスクトップに対するショートカットを加えるような処理については、インストール時にこれらの設定を行うかどうかを選択します。

..  _`Asakusa Framework入門`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/index.html
..  _`Asakusa Framework スタートガイド`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/start-guide.html
..  _`開発の流れ`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/next-step.html
..  _`OpenJDK`: http://openjdk.java.net/
..  _`Cloudera's Distribution including Apache Hadoop Version 3 (CDH3)`: https://ccp.cloudera.com/display/CDHDOC/CDH3+Documentation

