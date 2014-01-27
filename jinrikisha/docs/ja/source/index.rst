================================================
Jinrikisha - Asakusa Framework Starter Package -
================================================
Jinrikisha (人力車) は、 `Asakusa Framework`_ の開発環境を手軽に構築するためのインストーラパッケージです。

同梱のインストーラを利用し、Asakusa Framework本体、Hadoop、関連ツールなどをわずかな手順でセットアップすることで、すぐにAsakusa DSLによるバッチアプリケーションの開発を始めることができます。

..  _`Asakusa Framework`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/index.html

より詳しくは、 :doc:`feature` も参照してください。

ダウンロード
============

Linux-32bit版
-------------
* `jinrikisha-linux-32bit-0.6.0.tar.gz`_

..  _`jinrikisha-linux-32bit-0.6.0.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-32bit-0.6.0.tar.gz

Linux-64bit版
-------------
* `jinrikisha-linux-64bit-0.6.0.tar.gz`_

..  _`jinrikisha-linux-64bit-0.6.0.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-64bit-0.6.0.tar.gz

MacOSX版 (Experimental)
-----------------------
* `jinrikisha-macosx-0.6.0.tar.gz`_

..  _`jinrikisha-macosx-0.6.0.tar.gz`: http://www.asakusafw.com/download/jinrikisha/macosx/jinrikisha-macosx-0.6.0.tar.gz

..  attention::
    version |version| 時点では、MacOSX版は基本的な動作確認テストのみが行われています。

スナップショット版
------------------
* `jinrikisha-linux-32bit-0.6-snapshot.tar.gz`_
* `jinrikisha-linux-64bit-0.6-snapshot.tar.gz`_
* `jinrikisha-macosx-0.6-snapshot.tar.gz`_

..  _`jinrikisha-linux-32bit-0.6-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-32bit-0.6-snapshot.tar.gz
..  _`jinrikisha-linux-64bit-0.6-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-64bit-0.6-snapshot.tar.gz
..  _`jinrikisha-macosx-0.6-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/macosx/jinrikisha-macosx-0.6-snapshot.tar.gz

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
      - 12.04
      - 推奨環境
    * - CentOS [#]_
      - 6.2
      - 要デスクトップ環境のインストール
    * - MacOSX [#]_
      - 10.7.2 (Lion)
      -

..  [#] http://www.ubuntu.com/
..  [#] http://www.centos.org/
..  [#] http://www.apple.com/macosx/

使い方
======
ダウンロードしたインストールアーカイブを任意のディレクトリで展開します。

展開したファイルに含まれる ``setup.sh`` を実行するとインストールが開始されます。Jinrikishaのインストールディレクトリなどいくつかのインストールパラメータの入力が促されるので、インストーラの指示に従ってインストールを実行してください。

インストール手順の詳細やインストール時の注意事項は、 :doc:`install` を参照して下さい。 

インストールした開発環境を利用する
----------------------------------
Jinrikishaのインストールが完了したら、サンプルコードを確認したり、実際にアプリケーションを開発してみましょう。

インストールディレクトリ配下の ``README`` には、インストールした後にAsakusa Frameworkの開発環境で使用するコマンドやEclipseの使い方などを簡単にまとめた Getting Started が記述されています。

サンプルアプリケーションの内容や、アプリケーションの実行方法についてのより詳しい情報は、 `Asakusa Framework入門`_ の `Asakusa Framework スタートガイド`_ を参照してください。

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

..  _`Asakusa Framework入門`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/introduction/index.html
..  _`Asakusa Framework スタートガイド`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/introduction/start-guide.html
..  _`開発の流れ`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/introduction/next-step.html

アンインストール
----------------
JirikishaによってインストールしたAsakusa Frameworkの開発環境をアンインストールする手順は、 :doc:`uninstall` を参照してください。

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
      - 1.2.1
      - Apache License, Version 2.0 [#]_
    * - Eclipse IDE for Java Developers [#]_
      - 4.3.1 [#]_
      - Eclipse Public License - Version 1.0 [#]_

..  [#] http://hadoop.apache.org/
..  [#] http://www.apache.org/licenses/
..  [#] http://eclipse.org/
..  [#] Linux-32bit版、Linux-64bit版、MacOSX版それぞれに対応したプラットフォーム版が同梱されています。
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

