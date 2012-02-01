================================================
Jinrikisha - Asakusa Framework Starter Package -
================================================
Jinrikisha (人力車) は、 `Asakusa Framework`_ の開発環境を手軽に構築するためのインストーラパッケージです。

同梱のインストーラを利用し、Asakusa Framework本体、Hadoop、関連ツールなどをわずかな手順でセットアップすることで、すぐにAsakusa DSLによるバッチアプリケーションの開発を始めることができます。

..  _`Asakusa Framework`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/index.html

ダウンロード
============
各プラットフォームごとにリリース版（安定版）とスナップショット版を公開しています。

Linux-32bit版
-------------
..  list-table::
    :widths: 5 5
    :header-rows: 1

    * - リリース版
      - スナップショット版
    * - `jinrikisha-linux-32bit-0.1.0-beta5.tar.gz`_
      - `jinrikisha-linux-32bit-0.1-snapshot.tar.gz`_

..  _`jinrikisha-linux-32bit-0.1.0-beta5.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-32bit-0.1.0-beta5.tar.gz
..  _`jinrikisha-linux-32bit-0.1-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-32bit-0.1-snapshot.tar.gz

Linux-64bit版
-------------
..  list-table::
    :widths: 5 5
    :header-rows: 1

    * - リリース版
      - スナップショット版
    * - `jinrikisha-linux-64bit-0.1.0-beta5.tar.gz`_
      - `jinrikisha-linux-64bit-0.1-snapshot.tar.gz`_

..  _`jinrikisha-linux-64bit-0.1.0-beta5.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-64bit-0.1.0-beta5.tar.gz
..  _`jinrikisha-linux-64bit-0.1-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-64bit-0.1-snapshot.tar.gz

MacOSX版
--------
..  list-table::
    :widths: 5 5
    :header-rows: 1

    * - リリース版
      - スナップショット版
    * - `jinrikisha-macosx-0.1.0-beta5.tar.gz`_
      - `jinrikisha-macosx-0.1-snapshot.tar.gz`_

..  _`jinrikisha-macosx-0.1.0-beta5.tar.gz`: http://www.asakusafw.com/download/jinrikisha/macosx/jinrikisha-macosx-0.1.0-beta5.tar.gz
..  _`jinrikisha-macosx-0.1-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/macosx/jinrikisha-macosx-0.1-snapshot.tar.gz

..  attention::
    version ``0.1.0`` 時点では、MacOSX版は基本的な動作確認テストのみが行われています。

対応プラットフォーム
--------------------
Jinrikishaは以下のプラットフォームで動作を検証しています。

..  list-table::
    :widths: 5 5 10
    :header-rows: 1

    * - ディストリビューション
      - バージョン
      - 備考
    * - Ubuntu Desktop
      - 11.10
      - 推奨環境
    * - CentOS
      - 6.2
      - 要デスクトップ環境のインストール
    * - MacOSX
      - 10.7.2 (Lion)
      -

使い方
======
ダウンロードしたインストールアーカイブを任意のディレクトリで展開します。

展開したファイルに含まれる ``setup.sh`` を実行するとインストールが開始されます。Jinrikishaのインストールディレクトリなどいくつかのインストールパラメータの入力が促されるので、インストーラの指示に従ってインストールを実行してください。

インストール手順の詳細やインストール時の注意事項は、 :doc:`install` を参照して下さい。 

インストールした開発環境を利用する
==================================
Jinrikishaのインストールが完了したら、サンプルコードを確認したり、実際にアプリケーションを開発してみましょう。

Eclipseでサンプルアプリケーションを見る
---------------------------------------
Eclipseからサンプルアプリケーションのプロジェクトをインポートします。

1. デスクトップのショートカットからEclipseを起動します。
2. Eclipseのメニューから [File] -> [Import] -> [General] -> [Existing Projects into Workspace]を選択します。
3. Importダイアログで右上の [Browse]ボタンを押して、表示されたダイアログでそのまま[OK]ボタンを押します。 
4. ``example-app`` というプロジェクトが選択されていることを確認したら、そのまま右下の [Finish]ボタンを押します。

これでサンプルアプリケーションのプロジェクトがEclipseにインポートされました。 この後は、 ``src`` ディレクトリ配下のソースコードをチェックしたり、 `Asakusa Framework入門`_ の `Asakusa Framework スタートガイド`_  を参考にして、バッチアプリケーションを実行してみてもよいでしょう。

バッチアプリケーションを開発する
--------------------------------
`Asakusa Framework入門`_ の `開発の流れ`_ を参考にして、バッチアプリケーションを開発してみましょう。

また、Asakusa Frameworkのコミュニティサイトには、Asakusa Frameworkのバッチアプリケーションを設計、実装するための各種ガイド [#]_ が公開されているので、これに沿ってバッチアプリケーションを開発してみるのもよいでしょう。

..  [#] バッチ設計と実装ガイド: http://www.asakusafw.com/techinfo/methodology.html

..  _`Asakusa Framework入門`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/index.html
..  _`Asakusa Framework スタートガイド`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/start-guide.html
..  _`開発の流れ`: http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/next-step.html

アンインストール
================
JirikishaによってインストールしたAsakusa Frameworkの開発環境をアンインストールする手順は、 :doc:`uninstall` を参照してください。

リソース
========
..  toctree::
    :maxdepth: 1
   
    release-notes
    install
    feature
    uninstall


* `ソースリポジトリ (GitHub)`_

..   _`ソースリポジトリ (GitHub)`: https://github.com/asakusafw/asakusafw-starter

