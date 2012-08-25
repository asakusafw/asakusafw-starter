=========================================
Jinrikisha オフライン環境での使用について
=========================================
この文書ではJinrikishaをオフライン環境（インターネットに接続できない環境）で使用する場合の設定や注意事項を説明します。

インストール
============
Jinrikishaを使ったAsakusa Frameworkのインストールはオンライン環境（インターネットに接続出来る環境）でのみ可能です。

インストール後の環境は、後述する手順に従って設定を行うことで、オフライン環境での開発が可能です。

インストールした環境をオフライン環境で使用する
==============================================
:doc:`install` に従って構築した環境をオフラインで使用するための方法を解説します。

Mavenをオフラインモードで使用する
---------------------------------
Mavenをオフラインモードで使用するための設定を行います。 ``$M2_HOME/conf/settings.xml`` を編集し ``offline`` の値を ``true`` に変更してください。

..  code-block:: xml
     
    64
    65   <!-- offline
    66    | Determines whether maven should attempt to connect to the network when executing a build.
    67    | This will have an effect on artifact downloads, artifact deployment, and others.
    68    |
    69    | Default: false
    70   -->
    71   <offline>true</offline>
    72 
    

アプリケーション開発プロジェクトの作成
--------------------------------------
新規でアプリケーション開発プロジェクトを作成する場合、通常は `Mavenアーキタイプ利用ガイド`_ に従い、Asakusa Frameworkが公開しているアーキタイプカタログを参照してプロジェクトを選択しますが、Jinrikishaでインストールした環境では、 ``$M2_HOME/conf/archetype-catalog.xml`` にもアーキタイプカタログが配置されます。

これを使ってオフライン環境でアプリケーション開発プロジェクトを作成するには、ターミナル上で以下のコマンドを実行します。

..  code-block:: sh
    
    mvn archetype:generate -DarchetypeCatalog=file:///$M2_HOME/conf/archetype-catalog.xml
    
..  attention::
    アーキタイプカタログから ``asakusa-archetype-windgate`` 以外のアーキタイプを選択した場合で、かつオンライン上でそのアーキタイプから作られたプロジェクトのビルドが一度も行われていない場合、そのアーキタイプで使用するライブラリが不足しているためにビルドが失敗するかもしれません。
    その場合、一度Mavenをオンラインモードに戻してオンライン環境でプロジェクトのビルドを行い、必要なライブラリをダウンロードしてください。

..  attention::
    このアーキタイプカタログを使って選択できるAsakusa Frameworkのバージョンは、 :doc:`install` で指定したAsakusa Frameworkのバージョンのみになります。

..  attention::
    ThunderGate用のアーキタイプ ``asaksua-archetype-thundergate`` を選択した場合、MySQLなどのThunderGateが使用するソフトウェアを追加でインストールする必要があります。くわしくは `ThunderGate スタートガイド`_ を参照してください。

..  _`Mavenアーキタイプ利用ガイド`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/application/maven-archetype.html
..  _`ThunderGate スタートガイド`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/thundergate/start-guide.html

依存ライブラリの追加について
----------------------------
アプリケーションプロジェクトで追加のライブラリを使用する場合、Mavenでは ``pom.xml`` の ``<dependency>`` に依存ライブラリの定義を追加します。通常Mavenでは依存ライブラリの追加後にビルドを行うとインターネット環境から自動でライブラリのダウンロードが行われますが、オフライン環境で使用する場合は、Mavenのローカルリポジトリに対して手動でライブラリの追加を行う必要があります。

Jinrikishaでは、Asakusa Framework開発環境のインストールディレクトリ配下の ``repository`` ディレクトリをMavenのローカルリポジトリとして設定するため、ここにライブラリの追加を行います。これには、以下のような方法があります。

* オンライン環境でMavenのビルドを行ってダウンロードしたMavenローカルリポジトリのディレクトリを、オフライン環境のマシンにコピーする
* ``mvn install:intall-file`` コマンドを利用する [#]_

..  note::
    依存ライブラリの追加は上記で説明した方法のほか、内部ネットワーク上にMavenのインターナルリポジトリを構築するという方法もあります。複数の開発環境でライブラリの管理を統一的に行いたい場合はこちらの方法を検討すべきです。詳しくはMavenの以下のサイトなどを参照してください。

    http://maven.apache.org/guides/introduction/introduction-to-repositories.html

..  [#] 詳しくは、 http://maven.apache.org/plugins/maven-install-plugin/usage.html などを参照してください。
