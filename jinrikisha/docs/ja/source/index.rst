================================================
Jinrikisha - Asakusa Framework Starter Package -
================================================

Jinrikisha (人力車) は、 `Asakusa Framework`_ の開発環境を手軽に構築するためのインストーラパッケージです。

同梱のインストーラを利用し、Asakusa Framework本体、Hadoop、関連ツールなどをわずかな手順でセットアップすることで、すぐにAsakusa DSLによるバッチアプリケーションの開発を始めることができます。

..  _`Asakusa Framework`: http://docs.asakusafw.com/latest/release/ja/html/index.html

より詳しくは、 :doc:`feature` も参照してください。

ダウンロード
============

Linux-64bit版
-------------

* `jinrikisha-linux-64bit-0.9.1.tar.gz`_

..  _`jinrikisha-linux-64bit-0.9.1.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-64bit-0.9.1.tar.gz

対応プラットフォーム
--------------------

Jinrikishaは以下のプラットフォームで動作を検証しています。

..  list-table::
    :widths: 5 5 10
    :header-rows: 1

    * - ディストリビューション
      - バージョン
      - 備考
    * - Ubuntu Desktop [#]_
      - 16.04
      - 推奨環境
    * - CentOS [#]_
      - 7.2
      - 要デスクトップ環境のインストール

..  [#] http://www.ubuntu.com/
..  [#] http://www.centos.org/

使い方
======

ダウンロードしたインストールアーカイブを任意のディレクトリで展開します。

展開したファイルに含まれる :program:`setup.sh` を実行するとインストールが開始されます。
Jinrikishaのインストールディレクトリなどいくつかのインストールパラメータの入力が促されるので、インストーラの指示に従ってインストールを実行してください。

インストール手順の詳細やインストール時の注意事項は、 :doc:`install` を参照して下さい。

インストールした開発環境を利用する
----------------------------------

Jinrikishaのインストールが完了したら、サンプルコードを確認したり、実際にアプリケーションを開発してみましょう。

インストールディレクトリ配下の :file:`README` には、インストールした後にAsakusa Frameworkの開発環境で使用するコマンドやEclipseの使い方などを簡単にまとめた Getting Started が記述されています。

サンプルアプリケーションの内容や、アプリケーションの実行方法についてのより詳しい情報は、 `Asakusa Framework入門`_ の `Asakusa Framework スタートガイド`_ を参照してください。

Eclipseのカスタマイズ
---------------------

Jinrikishaに同梱されているEclipseをAsakusa Frameworkを使った開発用により使いやすくカスタマイズしてみましょう。

:doc:`Shafu (車夫) - Asakusa Gradle Plug-in Helper for Eclipse - <shafu>` を導入するとAsakusa Frameworkのアプリケーション開発準備やGradleを使ったビルド作業のほぼすべてをEclipseから行うことができるようになり、アプリケーション開発時のターミナル上でのコマンド操作がほぼ不要になります。

:doc:`DMDL Editor プラグイン <introduction/dmdl-editor>` を導入するとDMDLに対する構文ハイライトや入力補完機能やソース間のジャンプ機能など強力な編集サポート機能が利用できるようになります。

:doc:`introduction/localize` ではEclipseを日本語化する手順を紹介しています。

バッチアプリケーションを開発する
--------------------------------

`Asakusa Framework入門`_ の `開発の流れ`_ を参考にして、バッチアプリケーションを開発してみましょう。

また、Asakusa Frameworkのコミュニティサイトには以下に示すAsakusa Frameworkのバッチアプリケーションを設計、実装するための各種ガイドが公開されているので、これに沿ってバッチアプリケーションを開発してみるのもよいでしょう。

..  list-table:: Asakusa Frameworkによるバッチアプリケーション開発のための参考資料
    :widths: 4 6
    :header-rows: 1

    * - ドキュメント
      - URL
    * - バッチ設計と実装ガイド
      - http://www.asakusafw.com/techinfo/methodology.html

..  _`Asakusa Framework入門`: http://docs.asakusafw.com/latest/release/ja/html/introduction/index.html
..  _`Asakusa Framework スタートガイド`: http://docs.asakusafw.com/latest/release/ja/html/introduction/start-guide.html
..  _`開発の流れ`: http://docs.asakusafw.com/latest/release/ja/html/introduction/next-step.html

同梱ソフトウェア
================

Jinrikishaには以下のソフトウェアが含まています。

..  list-table:: 同梱ソフトウェア一覧
    :widths: 4 2 4
    :header-rows: 1

    * - プロダクト
      - バージョン
      - ライセンス
    * - Apache Hadoop [#]_
      - 2.7.3
      - Apache License, Version 2.0 [#]_
    * - Apache Spark [#]_
      - 2.1.0
      - Apache License, Version 2.0
    * - Apache Hive [#]_
      - 1.2.1
      - Apache License, Version 2.0
    * - Eclipse IDE for Java Developers [#]_
      - 4.6.3 [#]_
      - Eclipse Public License - Version 1.0 [#]_

..  [#] http://hadoop.apache.org/
..  [#] http://www.apache.org/licenses/
..  [#] http://spark.apache.org/
..  [#] http://hive.apache.org/
..  [#] http://eclipse.org/
..  [#] Linux-64bit版が同梱されています。
..  [#] http://www.eclipse.org/legal/epl-v10.html

ライセンス
==========

Jinrikishaは `Apache License, Version 2.0`_ の元で公開しています。

..  _`Apache License, Version 2.0`: http://www.apache.org/licenses/

リソース
========

..  toctree::
    :maxdepth: 1

    release-notes
    install
    feature
    uninstall
    offline
    download-archive
    introduction/localize
    introduction/dmdl-editor
    shafu

* `ソースリポジトリ (GitHub)`_

..   _`ソースリポジトリ (GitHub)`: https://github.com/asakusafw/asakusafw-starter

