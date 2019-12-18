==================
Jinrikisha の 特徴
==================

この文書ではJinrikishaの特徴を紹介します。

開発環境向けの All in One パッケージ
====================================

JinrikishaはAsakusa Frmaeworkによるアプリケーション開発に必要なライブラリやツールをパッケージングしています。
このパッケージ1つで開発に必要な環境がすべて整います。

`Asakusa Framework入門`_ の `Asakusa Framework スタートガイド`_ で説明されている開発環境の構築手順は、Jinrikishaを使ったインストールによってほとんどの手順が不要になります。
以下に `Asakusa Framework スタートガイド`_ で必要となる個々の手順がJinrikishaを使ってインストールした場合、どのようになるかを説明します。

Javaのインストール
------------------

Ubuntu版では、Javaのインストールが行われていない場合、 `OpenJDK`_ を自動インストールすることでJavaのインストールを自動化することができます。
本格的なアプリケーションの開発時にはOpenJDKの使用は推奨しませんが、Asakusa Frameworkを簡単に試すには便利なオプションです。

とりあえずOpenJDKで試用し、後からOracleJDKに切り替えることもできます。
JDKを切り替える場合、Jinrikishaのインストールディレクトリ配下の :file:`.rikisha_profile` に定義されているJAVA_HOMEの値を変更してください。

Hadoopのインストールとセットアップ
----------------------------------

Jinrikishaはインストールパッケージに `Apache Hadoop`_ を同梱しています。

HadoopはJinrikishaによって自動的にインストールされ、スタンドアロンモードで動作するよう設定されます。

Sparkのインストールとセットアップ
----------------------------------

Jinrikishaはインストールパッケージに `Apache Spark`_ を同梱しています。

SparkもHadoopと同様、Jinrikishaによって自動的にインストールされ、スタンドアロンモードで動作するよう設定されます。

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

Hiveのインストール
------------------

Jinrikishaはインストールパッケージに `Apache Hive`_ を同梱しています。

HiveはJinrikishaによって自動的にインストールされます。

標準の設定ではHiveのメタストアには組み込みのデータベースを使用する「エンベデッドモード」が使用され、メタストアのデータストアにはローカルファイル（デフォルトでは :program:`hive` コマンドを起動したパス上の :file:`metastore_db` ディレクトリ）が使用されます。

Akakusa FrameworkとHiveの連携については、Asakusa Frameworkのドキュメント `Asakusa FrameworkとHiveを連携して利用する`_ を参考にしてください。

Hiveをはじめて利用する場合、Hiveのドキュメント `GettingStarted`_ も参考になります。

1つのディレクトリ配下にすべてのコンポーネントをインストール
===========================================================

Jinrikisha のインストール時に指定した単一のディレクトリ配下に、HadoopやEclipseなど、Asakusa Frameworkの開発に必要なすべてのコンポーネントをインストールします。
既にHadoopやEclipseが入っている環境と共存することなども容易になっています。

なお、Java本体のインストールについてはOSのパッケージ管理システムの仕様に依存します。
また、OSユーザのプロファイル設定ファイル( :file:`$HOME/.profile` または :file:`$HOME/.bash_profile` )に対する設定の追加や、デスクトップに対するショートカットを加えるような処理については、インストール時にこれらの設定を行うかどうかを選択します。

..  _`Asakusa Framework入門`: https://docs.asakusafw.com/latest/release/ja/html/introduction/index.html
..  _`Asakusa Framework スタートガイド`: https://docs.asakusafw.com/latest/release/ja/html/introduction/start-guide.html
..  _`開発の流れ`: https://docs.asakusafw.com/latest/release/ja/html/introduction/next-step.html
..  _`OpenJDK`: https://openjdk.java.net/
..  _`Apache Hadoop`: https://hadoop.apache.org/
..  _`Apache Spark`: https://spark.apache.org/
..  _`Apache Hive`: https://hive.apache.org/
..  _`Asakusa FrameworkとHiveを連携して利用する`: https://docs.asakusafw.com/latest/release/ja/html/administration/asakusa-with-hive.html
..  _`GettingStarted`: https://cwiki.apache.org/confluence/display/Hive/GettingStarted

