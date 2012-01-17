==================
Jinrikisha の 特徴
==================
この文書ではJinrikishaの特徴を紹介します。

開発環境向けの All in One パッケージ
====================================
JinrikishaはAsakusa Frmaeworkによるアプリケーション開発に必要なライブラリやツールをすべてパッケージングしています。このパッケージ1つで開発に必要な環境がすべて整います。

`Asakusa Framework入門`_ の `Asakusa Framework スタートガイド`_ で説明されている開発環境の構築手順は、Jinrikishaを使ったインストールによってほとんどの手順が不要になります。以下に `Asakusa Framework スタートガイド`_ で必要となる個々の手順がJinrikishaを使ってインストールした場合、どのようになるかを説明します。

Javaのインストール
------------------
Ubuntu版では、Javaのインストールが行われていない場合、 `OpenJDK`_ を自動インストールすることでJavaのインストールを自動化することができます。本格的なアプリケーションの開発時にはOpenJDKの使用は推奨しませんが、Asakusa Frameworkを簡単に試すには便利なオプションです [#]_ 。

..  [#] とりあえずOpenJDKで試用し、後からOracleJDKに切り替えることもできます。

Mavenのインストールとセットアップ
---------------------------------
MavenはJinrikishaによって自動的にインストールされます。

Hadoopのインストールとセットアップ
----------------------------------
HadoopはJinrikishaによって自動的にインストールされます。JinrikishaはHadoopのディストリビューションとして、 `Cloudera's Distribution including Apache Hadoop Version 3 (CDH3)`_ をイ
ンストールします。

環境変数の設定
--------------
環境変数の設定はJinrikishaによって自動的に行われます。

Eclipseのインストール
---------------------
EclipseはJinrikishaによって自動的にインストールされます。

Asakusa Frameowrkのインストール
-------------------------------
Asakusa Frameworkのインストールとサンプルアプリケーションの作成、ビルドがJinrikishaによって自動的に行われます。

1つのディレクトリ配下にすべてのコンポーネントをインストール
-----------------------------------------------------------
Jinrikisha のインストール時に指定した単一のディレクトリ配下に、HadoopやEclipseなど、Asakusa Frameworkの開発に必要なすべてのコンポーネントをインストールします [#]_ 。環境を汚さない
ため、とりあえず触ってみようという方でも安心して使えるでしょう。

また、既にHadoopやMavenが入っている環境と共存することなども容易になっています。

例外的に、JinrikishaのインストーラがOSユーザのプロファイル設定ファイル( ``$HOME/.profile`` )やデスクトップのショートカットなどに設定を加えるような処理については、インストール時に>設定を行うかどうかを選択することができます。

..  [#] Java本体についてはOSのパッケージ管理システムの仕様に依存します。

..  _`Asakusa Framework入門`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/index.html
..  _`Asakusa Framework スタートガイド`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/start-guide.html
..  _`開発の流れ`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/next-step.html
..  _`OpenJDK`: http://openjdk.java.net/
..  _`Cloudera's Distribution including Apache Hadoop Version 3 (CDH3)`: https://ccp.cloudera.com/display/CDHDOC/CDH3+Documentation

