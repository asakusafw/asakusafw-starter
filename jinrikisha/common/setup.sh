#!/bin/bash
#
# Copyright 2012-2014 Asakusa Framework Team.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

. "$(dirname $0)/VERSION"

if [ -r "$(dirname $0)/.buildinfo" ]; then
  . "$(dirname $0)/.buildinfo"
fi

#---------------------------------------
# Define Defalut Valuables
#---------------------------------------
_ASAKUSA_DEVELOP_HOME_DEFAULT="$HOME/asakusa-develop"
_ADD_PROFILE_DEFAULT="y"
_CREATE_ECLIPSE_SHORTCUT_DEFAULT="y"
_ADD_LAUNCHD_CONF_DEFAULT="y"

#---------------------------------------
# Define Functions
#---------------------------------------
exit_abort()
{
  echo "Finished: ABORT"
  exit 1
}

aptable()
{
  which apt-get > /dev/null 2>&1
}

yumable()
{
  which yum > /dev/null 2>&1
}
########################################
# Start Message
########################################
echo "
****************************************************
              Jinrikisha (人力車)                 
                                                  
      - Asakusa Framework Starter Package -
                                                  
        Version: $_RIKISHA_VERSION ($_BUILD_ID)
****************************************************
"

########################################
# Initialize and install command
########################################
which curl > /dev/null 2>&1
if [ $? -ne 0 ]; then
  aptable
  if [ $? -eq 0 ]; then
    sudo apt-get install -y curl
  else
    yumable
    if [ $? -eq 0 ]; then
      sudo yum install -y curl
    else
      echo "apt-get または yum が使用出来ないため、インストールを中断します。"
      exit_abort
    fi
  fi
fi

########################################
# Check and Install JDK
########################################
echo "
------------------------------------------------------------
インストール環境のチェックを行います...
------------------------------------------------------------
"

echo "hostname[`hostname`]からIPアドレスが解決できるか確認します..."
ping -c 1 `hostname` > /dev/null
_RET=$?
if [ $_RET -ne 0 ]; then
  echo "hostname:`hostname` からIPアドレスが解決できません。"
  exit_abort
else
  echo "OK."
  echo ""
fi

if [ `uname` = "Darwin" ]; then
### for MacOSX ###
  _JAVA_HOME_MACOSX="/System/Library/Frameworks/JavaVM.framework/Home"
  while :
  do
    if [ -r $_JAVA_HOME_MACOSX ]; then
      break
    else
      java > /dev/null 2>&1
      echo "Javaがインストールされていません。"
      read -p "Javaをインストールした後、[Enter]キーを押してインストールを続行してください。:: " _INSTR
      continue
    fi
  done
  _JAVA_HOME="$_JAVA_HOME_MACOSX"
  _EXPORT="export JAVA_HOME=$_JAVA_HOME"'\n'
  _EXPORT="${_EXPORT}export _JAVA_OPTIONS=-Dfile.encoding=UTF-8"'\n'
  _PATH='export PATH=$JAVA_HOME/bin'
else
### for Linux ###
  echo "Java(JDK)がインストールされているか確認します..."

  if [ -n "$JAVA_HOME" -a -r "$JAVA_HOME/bin/javac" ]; then
    _JAVA_HOME="$JAVA_HOME"
    echo "環境変数JAVA_HOMEに設定されている以下のJDKを使用します。"
    echo $_JAVA_HOME
    echo "OK."
  else
    echo "環境変数JAVA_HOMEにJDKのインストールディレクトリが設定されていません。"
    echo "JDKを検出しています..."
    # attempt to find java

    for candidate_regex in \
      /usr/lib/jvm/j2sdk1.7-oracle \
      /usr/lib/jvm/java-7-oracle* \
      /usr/java/jdk1.7* \
      /usr/lib/j2sdk1.6-sun \
      /usr/lib/jvm/java-6-sun \
      /usr/lib/jvm/java-1.6.0-sun-1.6.0.* \
      /usr/lib/jvm/j2sdk1.6-oracle \
      /usr/java/jdk1.6* \
      /Library/Java/Home \
      /usr/java/default \
      /usr/lib/jvm/default-java \
      /usr/lib/jvm/java-openjdk \
      /usr/lib/jvm/java-1.7.0-openjdk* \
      /usr/lib/jvm/java-7-openjdk* \
      /usr/lib/jvm/java-1.6.0-openjdk \
      /usr/lib/jvm/java-1.6.0-openjdk-* ; do
        for candidate in `ls -rd $candidate_regex 2>/dev/null`; do
          if [ -e $candidate/bin/javac ]; then
            _JAVA_HOME_CANDIDATE=$candidate
            break
          fi
        done
    done
    if [ -z "$_JAVA_HOME_CANDIDATE" ]; then
      echo "JDKは検出されませんでした。"
      echo '
  Java(JDK)がインストールされていないため、
  OpenJDKをインストールしてセットアップを続行します。

  ** WARNING ********************************************************
  OpenJDKを使用せず、OracleJDKを使用する場合は
  インストールを中断してください。
  
  (OracleJDKを使用するには、OracleJDKを手動でインストールしてから
  環境変数JAVA_HOMEにOracleJDKのインストールディレクトリを設定し、
  再度 setup.sh を実行してインストールを行います)
  *******************************************************************

    '
      read -p "OpenJDKをインストールしてインストールを続行しますか？:[Y/n]: " _YN
      if [ "$_YN" ]; then
        _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
      else
        _YN="y"
      fi
      if [ "$_YN" = y ]; then
        aptable
        _RET=$?
        if [ $_RET -eq 0 ]; then
          sudo apt-get update
          sudo apt-get install -y openjdk-7-jdk
        else
          yumable
          _RET=$?
          if [ $_RET -eq 0 ]; then
            sudo yum install -y java-1.7.0-openjdk-devel
          else
            echo "apt-get または yum が使用出来ないため、インストールを中断します。"
            exit_abort
          fi
        fi
        _RET=$?
        if [ $_RET -ne 0 ]; then
          exit_abort
        fi
        echo "OpenJDKのインストールが完了しました。"
        # attempt to find java
        for javahome in \
          /usr/lib/jvm/java-1.7.0-openjdk* \
          /usr/lib/jvm/java-7-openjdk* \
          /usr/lib/jvm/java-openjdk ; do
          if [ -e $javahome/bin/javac ]; then
            _JAVA_HOME=$javahome
            break
          fi  
        done
        if [ -z "$_JAVA_HOME" ]; then
          echo "OpenJDKのインストールディレクトリが検出出来ませんでした。インストールを中断します。"
          exit_abort
        fi     
        echo "JAVA_HOMEに[$_JAVA_HOME]を指定します。"
      else
        echo "インストールを中断します。"
        exit_abort
      fi
    else
      echo ""
      echo "JDKを検出しました:[$_JAVA_HOME_CANDIDATE]"
      read -p "このJDKを使用してインストールを続行しますか？:[Y/n]: " _YN
      if [ "$_YN" ]; then
        _USE_JDK=`echo $_YN | tr "[:upper:]" "[:lower:]"`
      else
        _USE_JDK="y"
      fi
      if [ "$_USE_JDK" = "y" ]; then
        _JAVA_HOME="$_JAVA_HOME_CANDIDATE"
        echo "JAVA_HOMEに[$_JAVA_HOME]を指定します。"
      else
        echo ""
        echo "インストールを中断します。"
        echo "JDKのインストールディレクトリを環境変数JAVA_HOMEに設定した後"
        echo "再度インストールを行なってください。"
        exit_abort
      fi
    fi
  fi
  _EXPORT="export JAVA_HOME=$_JAVA_HOME"'\n'
  _PATH='export PATH=$JAVA_HOME/bin'
fi

########################################
# Input Install Parameters
########################################
echo "
------------------------------------------------------------
インストールパラメータを入力します...
------------------------------------------------------------
"

while :
do
  read -p "1) Asakusa Framework開発環境のインストールディレクトリ(ASAKUSA_DEVELOP_HOME)を入力してください。: $_ASAKUSA_DEVELOP_HOME_DEFAULT: " _INSTR
  if [ "$_INSTR" ]; then
    eval _INSTR=$_INSTR
    _ABS=$(cd $(dirname "$_INSTR") && pwd)
    _RET=$?
    if [ $_RET -ne 0 ]; then
      continue
    fi
    _ASAKUSA_DEVELOP_HOME_TEMP="$_ABS"/$(basename "$_INSTR")
  else
    _ASAKUSA_DEVELOP_HOME_TEMP="$_ASAKUSA_DEVELOP_HOME_DEFAULT"
  fi

  if [ -w $(dirname "$_ASAKUSA_DEVELOP_HOME_TEMP") ]; then
    _ASAKUSA_DEVELOP_HOME="$_ASAKUSA_DEVELOP_HOME_TEMP"
    echo "OK. インストールディレクトリに以下のディレクトリを使用します"
    echo "[$_ASAKUSA_DEVELOP_HOME]"
    echo ""
    break
  else
    echo "[ERROR] 指定したディレクトリ $_ASAKUSA_DEVELOP_HOME_TEMP を作成する権限がありません。"
  fi
done

export ASAKUSA_DEVELOP_HOME="$_ASAKUSA_DEVELOP_HOME"
_RIKISHA_PROFILE="$ASAKUSA_DEVELOP_HOME/.rikisha_profile"

_EXPORT="${_EXPORT}export ASAKUSA_DEVELOP_HOME=${ASAKUSA_DEVELOP_HOME}"'\n'
_EXPORT="${_EXPORT}"'export ASAKUSA_HOME=${ASAKUSA_DEVELOP_HOME}/asakusa\n'

read -p "2) Asakusa Frameworkのバージョンを入力してください。: $_ASAKUSAFW_VERSION_DEFAULT: " _INSTR
if [ "$_INSTR" ]; then
  _ASAKUSAFW_VERSION="$_INSTR"
else
  _ASAKUSAFW_VERSION="$_ASAKUSAFW_VERSION_DEFAULT"
fi

if [ -r "$HOME/.bash_profile" ]; then
  _TARGET_PROFILE="$HOME/.bash_profile"
else
  _TARGET_PROFILE="$HOME/.profile"
fi

echo "
3) $_TARGET_PROFILE に環境変数の設定を追加しますか？

** WARNING ********************************************************
* この設定を行う場合、以下の環境変数が設定されます。
  - JAVA_HOME="$_JAVA_HOME"
  - ASAKUSA_DEVELOP_HOME="$_ASAKUSA_DEVELOP_HOME"
  - ASAKUSA_HOME=\${ASAKUSA_DEVELOP_HOME}/asakusa
  - HADOOP_CMD=\${ASAKUSA_DEVELOP_HOME}/hadoop/bin/hadoop
  - HADOOP_CLIENT_OPTS=-Xmx512m
  - PATH: \$JAVA_HOME/bin:\${ASAKUSA_DEVELOP_HOME}/hadoop/bin: \\
          \$ASAKUSA_DEVELOP_HOME/eclipse:\$ASAKUSA_HOME/yaess/bin: \\
          \$PATH

* インストールする環境にすでに
  Java,Hadoop,Asakusa Frameworkがインストールされている場合、
  これらの環境変数による影響に注意してください。

* この設定を行わない場合、
  Jinrikishaでインストールした各ソフトウェアを使用する前に、
  シェルに対して以下のように環境変数を適用する必要があります。

### シェルに対して環境変数を追加
\$ . $_RIKISHA_PROFILE

*******************************************************************
"

read -p "$_TARGET_PROFILE に環境変数の設定を追加しますか？:[Y/n]: " _YN
if [ "$_YN" ]; then
  _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
else
  _YN="$_ADD_PROFILE_DEFAULT"
fi
if [ "$_YN" = "y" ]; then
  _ADD_PROFILE="y"
  echo ""
  read -p "4) デスクトップにEclipseのショートカットを追加しますか？:[Y/n]: " _YN
  if [ "$_YN" ]; then
    _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
  else
    _YN="$_CREATE_ECLIPSE_SHORTCUT_DEFAULT"
  fi
  if [ "$_YN" = "y" ]; then
    _CREATE_ECLIPSE_SHORTCUT="y"
  else
    _CREATE_ECLIPSE_SHORTCUT="n"
  fi

  if [ `uname` = "Darwin" ]; then
    echo "
5) EclipseをGUI(Finder,Dock,Spotlightなど)から起動するために
   必要な環境変数を /etc/launchd.conf に追加しますか？

** WARNING **********************************************
この設定はOS全体に適用されるため、
他のアプリケーションに影響を与える可能性があります。

この設定を行わない場合、
Eclipseはターミナルまたはデスクトップのショートカットから
起動してください。

(EclipseをGUIから起動してもAsakusa Frameworkを使った
アプリケーションのテストが正常に動作しません)
*********************************************************
"
    read -p "/etc/launchd.conf に環境変数を追加しますか？:[Y/n]: " _YN
    if [ "$_YN" ]; then
      _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
    else
      _YN="$_ADD_LAUNCHD_CONF_DEFAULT"
    fi
    if [ "$_YN" = "y" ]; then
      _ADD_LAUNCHD_CONF="y"
    else
      _ADD_LAUNCHD_CONF="n"
    fi
  else
     _ADD_LAUNCHD_CONF="n"
  fi
else
  _ADD_PROFILE="n"
  _CREATE_ECLIPSE_SHORTCUT="n"
  _ADD_LAUNCHD_CONF="n"
fi

########################################
# Start Install
########################################
echo "
------------------------------------------------------------
インストールの準備が完了しました。
以下の注意事項を確認した上で、[Enter]キーを押してください。
------------------------------------------------------------

** WARNING ***********************************************************
1) リモートリポジトリからライブラリをダウンロードするため、
   インストールには10分以上かかる可能性があります。
**********************************************************************
"
read -p "インストールを続行するには[Enter]キーを押してください。: " _DUMMY

if [ -d "$ASAKUSA_DEVELOP_HOME" ]; then
  _ASAKUSA_DEVELOP_BACKUP="${ASAKUSA_DEVELOP_HOME}_`date +%Y%m%d%H%M%S`"
  echo "インストールディレクトリ $ASAKUSA_DEVELOP_HOME に既にディレクトリが存在するため、$_ASAKUSA_DEVELOP_BACKUP に退避します。"
  mv "$ASAKUSA_DEVELOP_HOME" "$_ASAKUSA_DEVELOP_BACKUP"
  _RET=$?
  if [ $_RET -ne 0 ]; then
    exit_abort
  fi
fi
mkdir "$ASAKUSA_DEVELOP_HOME"
cd $(dirname $0)

########################################
# Install Hadoop
########################################
echo "Hadoopをインストールしています。"

cd archives
tar xf hadoop-*.tar.gz
mv hadoop-*/ hadoop
mv hadoop "$ASAKUSA_DEVELOP_HOME"
_EXPORT="${_EXPORT}"'export HADOOP_CMD=${ASAKUSA_DEVELOP_HOME}/hadoop/bin/hadoop\n'
_EXPORT="${_EXPORT}"'export HADOOP_CLIENT_OPTS=-Xmx512m\n'
_PATH="${_PATH}":'${ASAKUSA_DEVELOP_HOME}/hadoop/bin'
cd -

########################################
# Install Eclipse
########################################
echo "Eclipseをインストールしています。"

cd archives
tar xf eclipse-*.tar.gz
mv eclipse "$ASAKUSA_DEVELOP_HOME"
mkdir "$ASAKUSA_DEVELOP_HOME"/workspace
cd -

cp -r _templates/eclipse "$ASAKUSA_DEVELOP_HOME"
sed -i -e "s;/path/to/workspace;$ASAKUSA_DEVELOP_HOME/workspace;" "$ASAKUSA_DEVELOP_HOME"/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs

_PATH="${_PATH}":'$ASAKUSA_DEVELOP_HOME/eclipse'

########################################
# Setup Environment Variables
########################################
echo "環境変数を設定しています。"

_PATH="${_PATH}":'$ASAKUSA_HOME/yaess/bin'
_PATH="${_PATH}":'$PATH'
printf "${_EXPORT}${_PATH}\n" > "${_RIKISHA_PROFILE}"

. "${_RIKISHA_PROFILE}"

########################################
# Install Asakusa Framework
#######################################
echo "Asakusa Frameworkをインストールしています。"

cd "${ASAKUSA_DEVELOP_HOME}"/workspace
curl -O "http://www.asakusafw.com/download/gradle-plugin/asakusa-example-project-${_ASAKUSAFW_VERSION}.tar.gz"
tar xf "asakusa-example-project-${_ASAKUSAFW_VERSION}.tar.gz"
cd -

cd "${ASAKUSA_DEVELOP_HOME}"/workspace/asakusa-example-project
./gradlew installAsakusafw build eclipse
if [ $? -ne 0 ]; then
  exit_abort 
fi

rm -fr "$ASAKUSA_HOME"/batchapps/*
cp -pr build/batchc/* $ASAKUSA_HOME/batchapps
cd -

########################################
# Configuration to OS
########################################
if [ "$_ADD_PROFILE" = "y" ]; then
  echo "$_TARGET_PROFILE に $_RIKISHA_PROFILE を実行する定義を追加します。"

  echo "# Configuration for Jinrikisha (Asakusa Framework Starter Package with Installer)
if [ -f \"${_RIKISHA_PROFILE}\" ]; then
  . \"${_RIKISHA_PROFILE}\"
fi" >> $_TARGET_PROFILE

  if [ "$_CREATE_ECLIPSE_SHORTCUT" = "y" ]; then
    echo "デスクトップにEclipseのショートカットを追加します。"

    if [ -d ~/Desktop ]; then
      ln -fs "$ASAKUSA_DEVELOP_HOME"/eclipse/eclipse ~/Desktop
    elif [ -d ~/デスクトップ ]; then
      ln -fs "$ASAKUSA_DEVELOP_HOME"/eclipse/eclipse ~/デスクトップ
    fi
  fi

  if [ "$_ADD_LAUNCHD_CONF" = "y" ]; then
    echo "/etc/launchd.confに環境変数の設定を追加します。"
    echo "(sudoのパスワード入力が必要となる場合があります)"

    _SETENV="setenv JAVA_HOME $_JAVA_HOME"'\n'
    _SETENV="${_SETENV}setenv _JAVA_OPTIONS=-Dfile.encoding=UTF-8"'\n'
    _SETENV="${_SETENV}setenv ASAKUSA_HOME ${ASAKUSA_DEVELOP_HOME}/asakusa"'\n'
    _SETENV="${_SETENV}setenv HADOOP_CMD ${ASAKUSA_DEVELOP_HOME}/hadoop/bin/hadoop"'\n'
    printf "${_SETENV}\n" | sudo tee /etc/launchd.conf
  fi
fi

########################################
# Finish
########################################
echo "
------------------------------------------------------------
インストールが成功しました。
------------------------------------------------------------
"

if [ "$_ADD_PROFILE" = "y" ]; then
  echo "デスクトップ環境に対して $_TARGET_PROFILE の変更を反映するためOSを再起動してください。"
  while :
  do
    read -p "今すぐにOSを再起動しますか？:[y/n]: " _YN
    if [ -z "$_YN" ]; then
      continue
    else
      _YN=`echo ${_YN: -1} | tr "[:upper:]" "[:lower:]"`
      break
    fi
  done
  if [ "$_YN" = "y" ]; then
    sudo reboot
  fi
else
  echo "
ターミナルからインストールした各ソフトウェアを使用するには、
${_RIKISHA_PROFILE} をシェルに反映し、環境変数を追加してください。
"
fi

echo "${ASAKUSA_DEVELOP_HOME}"/README の内容を表示します...
echo "
===============
Getting Started
===============

# シェルに対して環境変数を追加 
# ----------------------------
. ${_RIKISHA_PROFILE}

# サンプルアプリケーションの実行
# ------------------------------

# サンプルテストデータの配置
cd ~
hadoop fs -rmr target/testing/directio
hadoop fs -put $ASAKUSA_DEVELOP_HOME/workspace/asakusa-example-project/src/test/example-dataset/master target/testing/directio/master
hadoop fs -put $ASAKUSA_DEVELOP_HOME/workspace/asakusa-example-project/src/test/example-dataset/sales target/testing/directio/sales

# バッチの実行
yaess-batch.sh example.summarizeSales -A date=2011-04-01


# アプリケーションの開発
# ----------------------

# Eclipseの起動
eclipse &

# サンプルアプリケーションをワークスペースへインポート
1. Eclipseのメニューから [File] -> [Import] -> [General] -> [Existing Projects into Workspace]を選択
2. Importダイアログで右上の [Browse]ボタンを押して、表示されたダイアログでそのまま[OK]ボタンを押す
3. example-app というプロジェクトが選択されていることを確認したら、そのまま右下の [Finish]ボタンを押す

# モデルクラスの生成
cd $ASAKUSA_DEVELOP_HOME/workspace/asakusa-example-project
./gradlew compileDMDL

# バッチコンパイル
cd $ASAKUSA_DEVELOP_HOME/workspace/asakusa-example-project
./gradlew compileBatchapp

------------------------------------------------------------------
" > "$ASAKUSA_DEVELOP_HOME"/README

cat "$ASAKUSA_DEVELOP_HOME"/README

