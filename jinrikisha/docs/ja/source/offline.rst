=========================================
Jinrikisha オフライン環境での使用について
=========================================
この文書ではJinrikishaをオフライン環境（インターネットに接続できない環境）で使用する場合の設定や注意事項を説明します。

オンライン環境でインストールした環境をオフライン環境で使用する
==============================================================
:doc:`install` に従って構築した環境をオフラインで使用するための方法を解説します。

Mavenをオフラインモードで使用する
---------------------------------
Mavenをオフラインモードで使用するための設定を行います。Asakusa Framework開発環境のインストールディレクトリ配下の ``maven/conf/settings.xml`` を編集し ``offline`` の値を ``true`` に変更してください。

..  code-block:: sh
    
    64
    65   <!-- offline
    66    | Determines whether maven should attempt to connect to the network when executing a build.
    67    | This will have an effect on artifact downloads, artifact deployment, and others.
    68    |
    69    | Default: false
    70   -->
    71   <offline>true</offline>
    72 

依存ライブラリの追加について
----------------------------
アプリケーションプロジェクトで追加のライブラリを使用する場合、Mavenでは ``pom.xml`` の ``<dependency>`` に依存ライブラリの定義を追加します。通常Mavenでは依存ライブラリの追加後にビルドを行うとインターネット環境から自動でライブラリのダウンロードが行われますが、オフライン環境で使用する場合は、Mavenのローカルリポジトリに対して手動でライブラリの追加を行う必要があります。

Jinrikishaでは、Asakusa Framework開発環境のインストールディレクトリ配下の ``repository`` ディレクトリをMavenのローカルリポジトリとして設定するため、ここにライブラリの追加を行います。

ライブラリの追加は、オンライン環境でMavenのビルドを行ってダウンロードしたMavenローカルリポジトリのディレクトリを、オフライン環境のマシンにコピーする方法があります。

..  note::
    開発環境のマシン数が多い場合は、内部ネットワーク上にMavenのインターナルリポジトリを構築するという方法もあります。ライブラリの管理を統一的に行いたい場合はこちらの方法を検討すべきです。詳しくはMavenの以下のサイトなどを参照してください。

    http://maven.apache.org/guides/introduction/introduction-to-repositories.html

