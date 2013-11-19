======================
DMDL Editorプラグイン
======================
この文書ではEclipseのDMDL Editorプラグインを紹介します。

DMDL Editorプラグインとは
==========================
`DMDL EditorX <https://github.com/hishidama/xtext-dmdl-editor>`_ は ひしだま氏が開発しているOSSのEclipseプラグインで、
DMDLスクリプトファイルに関する編集機能を追加します。 [#]_

まだ開発途上ですが、DMDLの編集が便利になります。

* DMDLスクリプトのキーワードに色が付きます。
* 別のデータモデルを参照しているデータモデルにおいて、参照元データモデルへジャンプすることが出来ます。
* Mavenを使わずにEclipse上でDMDLスクリプトのコンパイルを行い、Javaのデータモデルクラスを生成することが出来ます。
* Javaソース上のデータモデルのクラス名あるいはメソッド名からDMDLスクリプトファイルへジャンプすることが出来ます。

..  [#] 機能やインストール手順の詳細については、DMDL EditorXのサイトを確認してください。 https://github.com/hishidama/xtext-dmdl-editor

..  note::

    以前は `DMDL Editor <https://github.com/hishidama/dmdl-editor-plugin>`_ を紹介していましたが、
    新たに `Xtext <http://www.eclipse.org/Xtext/>`_ を使ったXtext版DMDL Editor（DMDL EditorX）が開発され、古い方はメンテナンスされなくなりました。
    インストール方法に少し違いがありますが、基本的な機能に変わりはありません。

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
      - サイトの名前を入力します。（例：「Xtext」）
    * - ロケーション（Location）
      - XtextのダウンロードサイトのURL（ http://download.eclipse.org/modeling/tmf/xtext/updates/composite/releases/ ）を入力します。

4. 「名前（Name）」に表示されているXtext2.4系の最新バージョン（例：「Xtext-2.4.3」）にチェックを入れます。

..  attention::
   似た名前で「Xtend」という選択肢がありますので、間違えないようにしてください。

5. 「次へ（Next）」ボタンを押していき、最後に「完了（Finish）」ボタンを押すと Xtextプラグインがダウンロード・インストールされます。

6. 再びEclipseのメニューバーの「ヘルプ（Help）」から「新規ソフトウェアのインストール（Install New Software）」を選択し、インストールダイアログを開きます。

7. 「作業対象（Work with）」の右側にある「追加（Add）」ボタンを押して以下のリポジトリの情報を入力し、「OK」ボタンを押します。

..  list-table::
    :widths: 2 8
    :header-rows: 1

    * - 項目
      - 説明
    * - 名前（Name）
      - サイトの名前を入力します。（例：「dmdl-editor」）
    * - ロケーション（Location）
      - DMDL EditorXのダウンロードサイトのURL（ http://hishidama.github.io/xtext-dmdl-editor/site/ ）を入力します。

8. 「名前（Name）」に表示されている「DMDL EditorX」にチェックを入れます。

9. 「次へ（Next）」ボタンを押していき、最後に「完了（Finish）」ボタンを押すと DMDL Editorプラグインがダウンロード・インストールされます。

10. Eclipseを再起動します。

11. DMDLスクリプトファイルを開きます。

..  attention::
   もし「Do you want to add the Xtext nature to the project 'プロジェクト名'?」というメッセージのダイアログが表示されたら、「Yes」ボタンを押してください。
   これは、プロジェクトにXtextネイチャーを追加するもので、追加しないとXtextの機能を使うことが出来ません。


DMDL Editorプラグインの機能の紹介
=================================
DMDL EditorXには色々な機能がありますが、簡単に役立つものを紹介します。

参照元データモデルへのジャンプ
------------------------------
別のデータモデルを参照しているデータモデルにおいて、参照元データモデルの定義場所へジャンプする機能です。

例えば以下のような集計モデルのモデル定義において、 ``Ctrl`` キーを押しながら ``joined_sales_info`` をマウスでクリックすると、joined_sales_infoが定義されているモデルの定義行へジャンプします。

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
    DMDL EditorXではMavenを使わずにコンパイルすることが出来ます。

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



