=============================================================
Jinrikisha - Asakusa Framework Starter Package with Installer
=============================================================
Jinrikisha (人力車) は、Asakusa Frameworkの開発環境を手軽に構築するためのインストーラパッケージです。

同梱のインストーラを利用し、Asakusa Framework本体、Hadoop、関連ツールなどをわずかな手順でセットアップすることで、すぐにAsakusa DSLによるバッチアプリケーションの開発を始めることができます。

ダウンロード
============
各プラットフォームごとにリリース版（安定版）とスナップショット版を公開しています。

Linux版
-------
..  list-table::
    :widths: 4 6

    * - リリース版
      - `jinrikisha-linux-0.1.0-beta4.tar.gz`_
    * - スナップショット版
      - `jinrikisha-linux-0.1-snapshot.tar.gz`_

..  _`jinrikisha-linux-0.1.0-beta4.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-0.1.0-beta4.tar.gz
..  _`jinrikisha-linux-0.1-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/linux/jinrikisha-linux-0.1-snapshot.tar.gz

対応プラットフォーム
~~~~~~~~~~~~~~~~~~~~
Linux版は以下のプラットフォームで動作を検証しています。

..  list-table::
    :widths: 5 5 10
    :header-rows: 1

    * - ディストリビューション
      - バージョン
      - 備考
    * - Ubuntu Desktop
      - 11.10
      - 
    * - CentOS
      - 6.2
      - 要デスクトップ環境のインストール

使い方
======
上記のダウンロードサイトからJinrikishaのアーカイブファイルをダウンロードし、任意のディレクトリでtarアーカイブを展開します。

展開したファイルに含まれる ``setup.sh`` を実行するとインストールが開始されます。Jinrikishaのインストールディレクトリなどいくつかのインストールパラメータの入力が促されるので、インストーラの指示に従ってインストールを実行してください。

前提条件
--------
``setup.sh`` を実行するするOSユーザは ``sudo`` コマンドを実行できる必要があります。CentOSなど、デフォルトで一般ユーザがsudoコマンドを実行できない設定になっているプラットフォームを使用している場合は、必要に応じてsudoを実行できるよう設定してください。

インストールオプション
----------------------
``setup.sh`` の オプションとして ``-r [Mavenリポジトリのtarアーカイブファイル名]`` を指定すると、指定したMavenローカルリポジトリの内容をJinrikishaのインストールディレクトリ配下に展開することができます。これにより、Mavenリポジトリからのダウンロード時間を短縮することができます。

例えばJinrikishaを再インストールする場合は、以下のようにするとよいでしょう。

..  code-block:: sh
    
    tar -cf /tmp/repository.tar.gz -C ~/jinrikisha repository
    ./setup.sh -r /tmp/repository.tar.gz

インストール前にMavenの設定を行う場合
-------------------------------------
インターネットへの接続にプロキシサーバを経由する必要がある環境については、Mavenに対してプロキシの設定を行う必要があります。

Mavenの設定を変更する場合は、 ``setup.sh`` を実行する前にJinrikishaのアーカイブファイルに含まれる ``_template/maven/conf/settings.xml`` を編集し、Mavenに対して適切な設定 [#]_ を行ってください。

..  [#] Mavenのプロキシ設定については、Mavenの次のサイト等を確認してください。 http://maven.apache.org/guides/mini/guide-proxies.html

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

リソース
========
..  toctree::
    :maxdepth: 1
   
    release-notes
    feature 

* `ソースリポジトリ (GitHub)`_

..   _`ソースリポジトリ (GitHub)`: https://github.com/asakusafw/asakusafw-starter

    

