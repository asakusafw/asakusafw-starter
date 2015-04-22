================================
Jinrikisha Eclipse日本語化手順
================================

この文書ではJinrikishaでインストールしたEclipseを日本語化する手順を説明します。

Eclipse日本語化手順
===================

Eclipseの日本語化にはPleiadesプラグイン（日本語化プラグイン）を使用します。
以下にインストール手順を説明します。 [#]_

ここでは主にUbuntu DesktopへLinux-32bit版を使ってインストールする手順を説明しますが、他のプラットフォームにおいてもインストール手順は同様です。

Pleiadesプラグインのインストール
--------------------------------

まず、Pleiadesプラグインのサイト（ http://mergedoc.sourceforge.jp/ ）の「Pleiades プラグイン・ダウンロード」から安定版をダウンロードします。
本文書では、ブラウザ標準のダウンロードディレクトリ :file:`~/Downloads` にダウンロードしたものとして説明を進めます。

ダウンロードしたPleiadesプラグインのアーカイブを展開し、展開したディレクトリに含まれる :file:`features` および :file:`plugins` ディレクトリをEclipseのディレクトリにコピーします。

..  code-block:: sh

    cd ~/Downloads
    unzip pleiades_*.zip
    cp -rp features plugins $ASAKUSA_DEVELOP_HOME/eclipse/

..  note::
    ``$ASAKUSA_DEVELOP_HOME`` は、JinrikishaによるAsakusa Framework開発環境のインストールディレクトリを指しています。
    Jinrikishaのインストール時に :ref:`ログインプロファイルに対する環境変数追加の設定<configure-profile>` でログインプロファイルに環境変数を追加していると、環境変数 ``ASAKUSA_DEVELOP_HOME`` を使用することが出来ます。

つぎに :file:`$ASAKUSA_DEVELOP_HOME/eclipse/eclipse.ini` の最下行に以下の指定を追加します。
:file:`/home/asakusa/asakusa-develop` はAsakusa Framework開発環境のインストールディレクトリです。お使いの環境に合わせて変更してください。

..  code-block:: text

    -javaagent:/home/asakusa/asakusa-develop/eclipse/plugins/jp.sourceforge.mergedoc.pleiades/pleiades.jar

..  attention::
    :file:`eclipse.ini` 内では環境変数 ``$ASAKUSA_DEVELOP_HOME`` を指定することは出来ません

これでEclipseを起動すると日本語化されます。
初回起動時に英語から日本語への変換作業が実行される為、初回起動時は多少の時間がかかります

..  [#] インストール手順の詳細については、Pleiadesプラグインのリリースノートサイトを確認してください

        http://sourceforge.jp/projects/mergedoc/releases/58165/note

