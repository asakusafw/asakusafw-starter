======================
DMDL Editorプラグイン
======================
この文書ではEclipseのDMDL Editorプラグインを紹介します。

DMDL Editorプラグインとは
==========================
`DMDL Editor <https://github.com/hishidama/dmdl-editor-plugin>`_ は ひしだま氏が開発しているOSSのEclipseプラグインで、
DMDLスクリプトファイルに関する編集機能を追加します。 [#]_

まだ開発途上ですが、DMDLの編集が便利になります。

* DMDLスクリプトのキーワードに色が付きます。
* 別のデータモデルを参照しているデータモデルにおいて、参照元データモデルへジャンプすることが出来ます。
* Mavenを使わずにEclipse上でDMDLスクリプトのコンパイルを行い、Javaのデータモデルクラスを生成することが出来ます。
* Javaソース上のデータモデルのクラス名あるいはメソッド名からDMDLスクリプトファイルへジャンプすることが出来ます。

..  [#] 機能やインストール手順の詳細については、DMDL Editorのサイトを確認してください。 https://github.com/hishidama/dmdl-editor-plugin

DMDL Editorプラグインのインストール手順
=======================================
ここでは主にUbuntu DesktopへLinux-32bit版を使ってインストールする手順を説明しますが、他のプラットフォームにおいてもインストール手順は同様です。

1. Eclipseを起動します。

2. Eclipseのメニューバーの「ヘルプ（Help）」から「新規ソフトウェアのインストール（Install New Software）」を選択し、インストールダイアログを開きます。

3. 「作業対象（Work with）」の右側にある「追加（Add）」ボタンを押して以下のリポジトリの情報を入力し、「OK」ボタンを押します。

..  list-table::
    :widths: 2 8
    :header-rows: 1

    * - 項目
      - 説明
    * - 名前（Name）
      - サイトの名前を入力します。（例：「dmdl-editor」）
    * - ロケーション（Location）
      - DMDL EditorのダウンロードサイトのURL（ http://hishidama.github.com/dmdl-editor-plugin/site/ ）を入力します。

4. 「名前（Name）」に表示されている「DMDL Editor」にチェックを入れます。

..  attention::
   「DMDL Editor」が表示されず、「カテゴリー化された項目がありません（There are no categorized items）」というメッセージが表示されている場合は、
   「項目をカテゴリー別にグループ化（Group items by category）」のチェックを外す必要があります。

5. 「次へ（Next）」ボタンを押していき、最後に「完了（Finish）」ボタンを押すと DMDL Editorプラグインがダウンロード・インストールされます。

6. Eclipseを再起動します。

DMDL Editorプラグインの機能の紹介
=================================
DMDL Editorには色々な機能がありますが、簡単に役立つものを紹介します。

参照元データモデルへのジャンプ
------------------------------
別のデータモデルを参照しているデータモデルにおいて、参照元データモデルの定義場所へジャンプする機能です。

例えば以下のような集計モデルのモデル定義において、 ``joined_sales_info`` をマウスでクリックすると、joined_sales_infoが定義されているモデルの定義行へジャンプします。

..  code-block:: text

    summarized category_summary = joined_sales_info => {
      ...
    }

DMDLソースの整形
----------------
DMDLのソースの整形を行う機能です。

``Ctrl + Shift + F`` を押すとソースが整形されます。

DMDLのコンパイル
----------------
DMDLのコンパイルを行う機能です。

..  note::

    通常は `MavenのコマンドでDMDLのコンパイル <http://asakusafw.s3.amazonaws.com/documents/latest/release/ja/html/dmdl/start-guide.html#java>`_ を行ってJavaのデータモデルクラスを生成しますが、
    DMDL EditorではMavenを使わずにコンパイルすることが出来ます。

ツールバーの「DMDL compile」のアイコンをクリックすると、コンパイルが実行されます。（コンソール上にコンパイルメッセージが表示されます）

JavaソースからDMDLへのジャンプ
------------------------------
Javaのソースコード上のデータモデルのクラスやメソッドから定義元のDMDLへジャンプする機能です。

例えば以下のような演算子クラスのソースコードにおいて、 ``ErrorRecord`` （データモデルのクラス名）や ``setMessageAsString`` （データモデルのメソッド名）を
``Ctrl`` キーを押しながらマウスでクリックすると、ジャンプ先の選択肢が表示されます。
ここで「Open DMDL」を選ぶとDMDLスクリプトファイルへジャンプします。

..  code-block:: text

    @Update
    public void setErrorMessage(ErrorRecord record, String message) {
        record.setMessageAsString(message);
    }



