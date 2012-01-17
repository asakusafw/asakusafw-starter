=============================================================
Jinrikisha - Asakusa Framework Starter Package with Installer
=============================================================
Jinrikisha (人力車) は、Asakusa Frameworkの開発環境を手軽に構築するためのインストーラパッケージです。

同梱のインストーラを利用し、Asakusa Framework本体、Hadoop、関連ツールなどをわずかな手順でセットアップすることで、すぐにAsakusa DSLによるバッチアプリケーションの開発を始めることができます。

ダウンロード
============

正式リリース版
--------------
..  list-table::
    :widths: 5 10

    * - Ubuntu版
      - `jinrikisha-ubuntu-0.1.0-beta3.tar.gz`_

..  _`jinrikisha-ubuntu-0.1.0-beta3.tar.gz`: http://www.asakusafw.com/download/jinrikisha/ubuntu/jinrikisha-ubuntu-0.1.0-beta3.tar.gz

スナップショット版
~~~~~~~~~~~~~~~~~~
..  list-table::
    :widths: 5 10

    * - Ubuntu版
      - `jinrikisha-ubuntu-0.1-snapshot.tar.gz`_

..  _`jinrikisha-ubuntu-0.1-snapshot.tar.gz`: http://www.asakusafw.com/download/jinrikisha/ubuntu/jinrikisha-ubuntu-0.1-snapshot.tar.gz


使い方
======
上記のダウンロードサイトからJinrikishaのアーカイブファイルをダウンロードし、任意のディレクトリでtarアーカイブを展開します。

展開したファイルに含まれる ``setup.sh`` を実行するとインストールが開始されます。Jinrikishaのインストールディレクトリなどいくつかのインストールパラメータの入力が促されるので、インストーラの指示に従ってインストールを実行してください。

インストールオプション
----------------------
``setup.sh`` の オプションとして ``-r [Mavenリポジトリのtarアーカイブファイル名]`` を指定すると、指定したMavenローカルリポジトリの内容をJinrikishaのインストールディレクトリ配下に展開することができます。これにより、Mavenリポジトリからのダウンロード時間を短縮することができます。

例えばJinrikishaを再インストールする場合は、以下のようにするとよいでしょう。

..  code-block:: sh
    
    tar -cf /tmp/repository.tar.gz -C ~/jinrikisha repository
    ./setup.sh -r /tmp/repository.tar.gz

インストールした開発環境を利用する
==================================
Jinkirishaのインストールが完了したら、サンプルコードを眺めたり、実際にアプリケーションを開発してみましょう。

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

    

