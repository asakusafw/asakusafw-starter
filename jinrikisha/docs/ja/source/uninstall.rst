===============================
Jinrikisha アンインストール手順
===============================
この文書ではJinrikishaのアンインストール手順を説明します。

アンインストール手順
====================
Jinrikishaをアンインストールするには、以下の手順に従ってアンインストール作業を行います。

1. Jinrikishaのインストールディレクトリの削除
2. Asakusa Frameworkが使用するテンポラリディレクトリの削除
3. デスクトップ上のEclipseショートカットの削除(インストール時に追加した場合のみ)
4. ユーザログイン時に適用されるプロファイル設定の削除(インストール時に追加した場合のみ)
5. 再ログイン/再起動(手順4を実施した場合のみ)

以下、個々の手順を説明します。

Jinrikishaのインストールディレクトリの削除
------------------------------------------
Jinrikishaをインストールしたディレクトリを削除します。デフォルトでは、Jinrikishaのインストールディレクトリは以下のディレクトリになっています。

* ``$HOME/asakusa-develop`` 

Asakusa Frameworkが使用するテンポラリディレクトリの削除
-------------------------------------------------------
Asakusa Frameworkのテスト実行時に生成する以下のテンポラリ用ディレクトリを削除します。

* ``$HOME/target``
* ``/tmp/windgate-$USER`` [#]_
* ``/tmp/hadoop-$USER``

..  [#] WindGateの設定を変更した場合はそのディレクトリを削除してください

デスクトップ上のEclipseショートカットの削除
-------------------------------------------
インストール時にデスクトップにEclipseのショートカットを追加した場合は、これを削除します。Eclipseのデスクトップのショートカットは以下のシンボリックリンクです。

* ``$HOME/Desktop/eclipse``

または

* ``$HOME/デスクトップ/eclipse``

ユーザログイン時に適用されるプロファイル設定の削除
--------------------------------------------------
インストール時にユーザログイン時に適用される環境変数の設定を追加した場合は、これを削除します。

インストール時にユーザログイン時に適用される環境変数の設定を追加した場合、 ``$HOME/.profile`` または ``$HOME/.bash_profile`` [#]_ 上に以下の4行が追加されているため、この部分を削除してファイルを保存します。

..  code-block:: sh

    # Configuration for Jinrikisha (Asakusa Framework Starter Package with Installer)
    if [ -f "$HOME/asakusa-develop/.rikisha_profile" ]; then 
      . "$HOME/asakusa-develop/.rikisha_profile"
    fi

``$HOME/.profile`` または ``$HOME/.bash_profile`` に上記の4行しかない場合は、ファイル自体を削除してください。

..  [#] インストール時に ``$HOME/.bash_profile`` -> ``$HOME\.profile`` の順にファイルを検索し、存在したファイルに定義が追加されます。 このため、デフォルトの環境では Ubuntu版とMacOSX版は ``$HOME\.profile`` 、CentOS版は ``$HOME/.bash_profile`` に定義が追加されます。

(MacOSX版のみ) ``/etc/launchd.conf`` の環境変数設定の削除
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
MacOSX版では、インストール時に ``/etc/launchd.conf`` に設定を追加するよう選択した場合は、 ``/etc/launchd.conf`` に以下の4行が追加されているため、この部分を削除してファイルを保存します。

..  code-block:: sh

    setenv JAVA_HOME /System/Library/Frameworks/JavaVM.framework/Home
    setenv _JAVA_OPTIONS=-Dfile.encoding=UTF-8
    setenv ASAKUSA_HOME /Users/xxx/asakusa-develop/asakusa
    setenv HADOOP_HOME /Users/xxx/asakusa-develop/hadoop

``/etc/launchd.conf`` に上記の4行しかない場合は、ファイル自体を削除してください。

再ログイン/再起動
-----------------
``$HOME/.profile`` もしくは ``$HOME/.bash_profile`` を編集した場合は、デスクトップ環境への再ログインを行なってください。

また、 ``/etc/launchd.conf`` を編集した場合は、OSの再起動を行なってください。

以上でアンインストールは完了です。

