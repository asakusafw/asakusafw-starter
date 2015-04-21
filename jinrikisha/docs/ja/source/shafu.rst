===================================================
Shafu - Asakusa Gradle Plug-in Helper for Eclipse -
===================================================

Shafu (車夫) は、 `Asakusa Framework`_ のバッチアプリケーション開発をサポートするEclipseプラグインです。

Shafu は バッチアプリケーション開発にGradleを利用する際に、Eclipseから透過的にビルドツール上の操作を行えます。
Shafuを使うことで、ターミナル上でのビルドツールの操作が不要となり、Eclipse上でアプリケーション開発に必要なほとんどの作業を行うことができるようになります。

Shafu は Jinrikisha でセットアップしたEclipse環境ではもちろんのこと、単体でセットアップしたEclipse上での利用も可能です。

..  _`Asakusa Framework`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/index.html
  
..  note::
    Asakusa Frameworkが提供するGradle上のビルド機能についての詳細は、Asakusa Frameworkのドキュメント `Asakusa Gradle Plugin利用ガイド`_ を参照してください。

..  _`Asakusa Gradle Plugin利用ガイド`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/application/gradle-plugin.html

対応プラットフォーム
====================

Shafuは以下のプラットフォームで動作を検証しています。

..  list-table::
    :widths: 2 3 2 3
    :header-rows: 1

    * - プラットフォーム
      - ソフトウェア
      - バージョン
      - 備考
    * - IDE
      - Eclipse
      - 4.4.1 / 4.4.2
      - 
    * - Java
      - Oracle JDK
      - JDK6 / JDK7
      - 推奨環境
    * - Java
      - Open JDK
      - JDK7
      - 基本的な動作確認のみ
    * - OS
      - Ubuntu Desktop (32bit/64bit)
      - 12.04 / 14.04
      - 推奨環境
    * - OS
      - CentOS (32bit/64bit)
      - 6.2
      - 
    * - OS
      - MacOSX
      - 10.7 / 10.9
      - [#]_
    * - OS
      - Windows
      - 7 SP1 / 8.1
      -

..  [#] MacOSXでJDK6を利用する場合、Eclipse実行時の文字エンコーディングをUTF-8などの日本語を利用できる環境にする必要があります。 `Eclipseの公式サイト`_ などを参考に、 ``eclipse.ini`` ファイルの ``-vmargs`` 以降の行に ``-Dfile.encoding=UTF-8`` の記述を追加してください。なおJinrikishaで構築した環境では環境変数 ``_JAVA_OPTIONS`` 経由で ``file.encoding`` が設定されるためこの設定は不要です。

..  _`Eclipseの公式サイト`: http://wiki.eclipse.org/Eclipse.ini

インストール
============

Shafu は次のアップデートサイトを使用してインストールすることができます。

* http://www.asakusafw.com/eclipse/jinrikisha/updates/

インストール手順
----------------

Eclipse上でShafu のアップデートサイトを利用したインストール手順例を説明します。

#. Eclipseのメニューから :menuselection:`Help --> Install New Software...` を選択します。
#. :guilabel:`Install` ダイアログで :guilabel:`Work with:` の項目右の :guilabel:`Add` ボタンを押下します。
#. :guilabel:`Add Repository` ダイアログで :guilabel:`Name:` に任意の名前(例: ``Jinrikisha`` )、:guilabel:`Location:` に上記アップデートサイトのURLを入力して :guilabel:`OK` ボタンを押下します。
#. :guilabel:`Install` ダイアログに表示された ``[Jinrikisha (人力車)]`` カテゴリを展開して ``[Asakusa Gradle プラグインサポート]`` を選択し、 :guilabel:`Next >` ボタンを押下します。
#. 以降、画面の指示に従いインストールを進めます。Eclipseの再起動を促されたら :guilabel:`Yes` を選択します。
#. Eclipse再起動が完了したら、Javaパースペクティブを表示して :menuselection:`Window --> Reset Perspective..` を選択してJavaパースペクティブを初期化します。

使い方
======

Shafu が提供する各機能の使い方を説明します。

Gradleプロジェクトをテンプレートから生成
----------------------------------------

オンライン上に公開されているAsakusa Frameworkのプロジェクトテンプレートや、ローカルに配置したプロジェクトテンプレートを利用して、Eclipse上に新規プロジェクトを作成することができます。

..  figure:: images/shafu-create-project.png
    :width: 100%

#. Javaパースペクティブ上のメインメニューなどから :menuselection:`File --> New --> Gradleプロジェクトをテンプレートから生成` を選択します。
#. 新規プロジェクト情報ダイアログで、プロジェクト名などを入力します。
#. プロジェクトテンプレートの選択ダイアログで、オンラインまたはローカルのテンプレートファイルを指定します。URL入力ボックス右の :guilabel:`選択` ボタンを押すと、オンラインに公開されているプロジェクトテンプレートを一覧から選択することができます。
#. :guilabel:`Finish` ボタンを押すと選択したプロジェクトテンプレートを読み込み、Eclipseプロジェクトとして新規プロジェクトが作成されます。

Gradleプロジェクトのインポート
------------------------------

ローカルに配置したGradleベースのプロジェクトをEclipseワークスペース上にインポートすることができます。
単体のプロジェクトをインポートするほか、複数のプロジェクトから構成されるマルチプロジェクト構成のプロジェクトを一括してインポートすることもできます。

#. Javaパースペクティブ上のメインメニューなどから :menuselection:`File --> Import` を選択します。
#. インポート選択画面で :menuselection:`Jinrikisha (人力車) --> Gradle プロジェクト` を選択して :guilabel:`Next >` ボタンを押します。
#. プロジェクトディレクトリーの選択ダイアログで、ローカルに配置されているGradleプロジェクトのディレクトリーパスを選択して :guilabel:`Next >` ボタンを押します。
#. インポート対象のプロジェクト選択で、インポート対象のプロジェクトを選択して :guilabel:`Finish` ボタンを押します。

プロジェクトのビルド
--------------------

プロジェクトのデータモデルクラスの生成やAsakusa DSLのコンパイルなど、Asakusa FrameworkがGradleを利用する各ビルド機能を実行することができます。

..  figure:: images/shafu-build-project.png
    :width: 100%

#. プロジェクトを選択してコンテキストメニュー(右クリックなどで表示されるメニュー)を表示します。
#. コンテキストメニューの :guilabel:`Jinrikisha (人力車)` を選択し、サブメニューとして表示される以下の各ビルド機能を選択します。

..  list-table:: :guilabel:`Jinrikisha (人力車)` メニュー
    :widths: 3 5 2
    :header-rows: 1

    * - メニュー名
      - 説明
      - Gradleタスク [#]_
    * - :guilabel:`タスク名を指定してビルド`
      - 任意のGradleタスクを入力して実行する
      - ``-``
    * - :guilabel:`DMDLからデータモデルクラスを生成`
      - DMDLスクリプトからデータモデルクラスを生成
      - :program:`compileDMDL`
    * - :guilabel:`テストデータ・テンプレートを生成`
      - DMDLスクリプトからTestDriverのテストデータを定義するExcelブックを生成する
      - :program:`generateTestbook`
    * - :guilabel:`Asakusaバッチアプリケーションを生成`
      - Asakusa DSLをバッチコンパイルして、バッチアプリケーションアーカイブファイルを生成する
      - :program:`jarBatchapp`
    * - :guilabel:`Asakusaデプロイメントアーカイブを生成`
      - Asakusa Frameworkの実行環境一式を含むデプロイメントアーカイブファイルを生成する
      - :program:`assemble`
    * - :guilabel:`Asakusa開発環境の構成`
      - Asakusa Frameworkの開発環境をセットアップするためのサブメニューを表示する
      - ``-``
    * - :guilabel:`Eclipseプロジェクト情報を再構成`
      - Eclipseのプロジェクト定義ファイルを再作成する [#]_
      - :program:`eclipse`

..  list-table:: :guilabel:`Asakusa開発環境の構成` サブメニュー
    :widths: 3 5 2
    :header-rows: 1

    * - メニュー名
      - 説明
      - Gradleタスク
    * - :guilabel:`Asakusa Frameworkのインストール`
      - 開発用のAsakusa Frameworkをインストールする
      - :program:`installAsakusafw`

..  [#] 各メニューの選択時に実行されるAsakusa Gradle PluginのGradleタスクです。
        詳しくはAsakusa Frameworkのドキュメント `Asakusa Gradle Plugin利用ガイド`_ を参照してください。
..  [#] Asakusa Frameworkのバージョンアップやアプリケーションライブラリの追加などで、Eclipseプロジェクトのクラスパス情報を更新する場合に使用します。

設定
====

Eclipseの設定画面からShafuの設定を変更することができます。

..  figure:: images/shafu-preferences.png
    :width: 100%

#. メニューバーから :menuselection:`Window --> Preferences` を選択します。
#. Eclipse設定画面のサイドメニューから :guilabel:`Jinrikisha  (人力車)` を選択します。

Jinrikisha (人力車) ページ
--------------------------

:guilabel:`基本`
  Gradleのログレベルやバージョン、オフラインモードの設定など、Gradleの動作に関する設定を行います。

:guilabel:`プロジェクト`
  Gradleのプロジェクトビルド時に使用するプロジェクトプロパティーを設定することができます。

:guilabel:`Java VM`
  Gradleのビルドで使用するJava VMやJavaプロセスに対するシステムプロパティーを指定します。

Asakusa Framework ページ
~~~~~~~~~~~~~~~~~~~~~~~~

:guilabel:`テンプレートカタログURL`
  `Gradleプロジェクトをテンプレートから生成`_ でプロジェクトテンプレートを選択する際に使用する、プロジェクトテンプレートの一覧を定義したテンプレートカタログファイルを指定します。
  デフォルトでは Asakusa Frameworkが公開しているリリースバージョンの一覧を含むテンプレートカタログが指定されています。

..  tip::
    Asakusa Frameworkが公開しているテスト用のバージョン (スナップショットビルドやRC版）を使用したい場合は、テンプレートカタログURLを以下のURLに変更します。

    http://www.asakusafw.com/download/gradle-plugin/template-catalog-develop.txt

拡張機能
^^^^^^^^

:guilabel:`テスト時にエミュレーションモードを有効にする`
  `Gradleプロジェクトをテンプレートから生成`_  を使った新規プロジェクトの作成時やプロジェクトに対して :guilabel:`Eclipseプロジェクト情報を再構成` を実行した場合に、プロジェクトに対してエミュレーションモード [#]_ を利用する設定を追加します。

..  [#] エミュレーションモードについては、Asakusa Frameworkのドキュメント `エミュレーションモードによるアプリケーションテスト`_ を参照してください。

..  _`エミュレーションモードによるアプリケーションテスト`: http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/testing/emulation-mode.html

現在の設定
^^^^^^^^^^

現在の環境の設定に関する情報を表示します。この画面から各項目の値を編集することはできません。

:guilabel:`フレームワークのインストール先 (ASAKUSA_HOME)`
  現在の環境で設定されている環境変数 ``ASAKUSA_HOME`` の値を表示します。

:guilabel:`Hadoopコマンドの場所`
  現在の環境で使用するHadoopコマンドのパスを表示します。

ネットワークプロキシの設定
==========================

オンラインとの接続にプロキシサーバを経由する必要がある場合は、Eclipseのプロキシ設定画面でプロキシの設定を行います。

#. メインメニューから :menuselection:`Window --> Preferences` を選択します。
#. プリファレンス画面のサイドメニューから :menuselection:`General --> Network Connections` を選択します。
#. プロキシ設定画面で、 :guilabel:`Active Provider:` を ``Manual`` に変更し、 :guilabel:`Proxy entries` や :guilabel:`Proxy bypass` の内容を編集して :guilabel:`OK` ボタンを押します。

リソース
========

* `ソースリポジトリ (GitHub)`_

..   _`ソースリポジトリ (GitHub)`: https://github.com/asakusafw/asakusafw-shafu

