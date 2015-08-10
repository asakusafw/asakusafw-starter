======================
DMDL Editorプラグイン
======================

この文書ではEclipseのDMDL Editorプラグインを紹介します。

DMDL Editorプラグインとは
==========================

`DMDL EditorX`_ は ひしだま氏が開発しているOSSのEclipseプラグインで、DMDLスクリプトファイルに関する編集機能 [#]_ を追加します。

まだ開発途上ですが、DMDLの編集が便利になります。

* DMDLスクリプトのキーワードに色が付きます。
* 別のデータモデルを参照しているデータモデルにおいて、参照元データモデルへジャンプすることが出来ます。
* GradleやMavenを使わずにEclipse上でDMDLスクリプトのコンパイルを行い、Javaのデータモデルクラスを生成することが出来ます。
* Javaソース上のデータモデルのクラス名あるいはメソッド名からDMDLスクリプトファイルへジャンプすることが出来ます。

..  [#] 機能やインストール手順の詳細については、 `DMDL EditorX`_ のサイトを確認してください。 

..  _`DMDL EditorX`: https://github.com/hishidama/xtext-dmdl-editor

DMDL Editorプラグインのインストール
===================================

前提条件
--------

DMDL Editorプラグインを利用するには、Eclipse環境に `Xtext <http://www.eclipse.org/Xtext/>`_ がインストールされている必要があります。

Jinrikisha バージョン |version| に同梱されているEclipseにはXtextが含まれていますが、異なるEclipse環境を利用する場合、必要に応じてXtextをインストール [#]_ してください。

..  [#] Xtextのインストールについては、 `Xtextのダウンロードサイト <https://eclipse.org/Xtext/download.html>`_ などを確認してください。

インストール手順
----------------

1. Eclipseを起動します。

2. Eclipseのメニューバーの :guilabel:`ヘルプ（Help）` から :guilabel:`新規ソフトウェアのインストール（Install New Software）` を選択し、インストールダイアログを開きます。

3. :guilabel:`作業対象（Work with）` の右側にある :guilabel:`追加（Add）` ボタンを押して以下のリポジトリの情報を入力し、 :guilabel:`OK` ボタンを押します。

..  list-table::
    :widths: 4 6
    :header-rows: 1

    * - 項目
      - 説明
    * - :guilabel:`名前（Name）`
      - サイトの名前（例： ``dmdl-editor`` ）
    * - :guilabel:`ロケーション（Location）`
      - ``http://hishidama.github.io/xtext-dmdl-editor/site/``

4. :guilabel:`名前（Name）` に表示されている :guilabel:`DMDL EditorX` にチェックを入れます。

5. :guilabel:`次へ（Next）` ボタンを押していき、最後に :guilabel:`完了（Finish）` ボタンを押すと DMDL Editorプラグインがダウンロード・インストールされます。

6. Eclipseを再起動します。

..  attention::
   もし「 ``Do you want to add the Xtext nature to the project 'プロジェクト名'?`` 」というメッセージのダイアログが表示されたら、「Yes」ボタンを押してください。
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

    通常は `GradleやMavenのコマンドでDMDLのコンパイル <http://docs.asakusafw.com/latest/release/ja/html/dmdl/start-guide.html#java>`_ を行ってJavaのデータモデルクラスを生成しますが、
    DMDL EditorXではGradleやMavenを使わずにコンパイルすることが出来ます。

ツールバーの「DMDL compile」のアイコンをクリックすると、コンパイルが実行されます（コンソール上にコンパイルメッセージが表示されます）。

JavaソースからDMDLへのジャンプ
------------------------------

Javaのソースコード上のデータモデルのクラスやメソッドから定義元のDMDLへジャンプする機能です。

例えば以下のような演算子クラスのソースコードにおいて、 ``ErrorRecord`` （データモデルのクラス名）や ``setMessageAsString`` （データモデルのメソッド名）を ``Ctrl`` キーを押しながらマウスでクリックすると、ジャンプ先の選択肢が表示されます。
ここで「 `guilabel:`Open DMDL` 」を選ぶとDMDLスクリプトファイルへジャンプします。

..  code-block:: java

    @Update
    public void setErrorMessage(ErrorRecord record, String message) {
        record.setMessageAsString(message);
    }



