#!/bin/bash

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
# Define Constants
#---------------------------------------
_REPO_URL="http://asakusafw.s3.amazonaws.com/maven/"
_EXAMPLE_GROUP_ID="com.example"
_EXAMPLE_ARTIFACT_ID="example-app"
_EXAMPLE_ARCHETYPE_ID="asakusa-archetype-windgate"
_EXAMPLE_BATCH_ID="example.summarizeSales"
_RIKISHA_PROFILE="$ASAKUSA_DEVELOP_HOME/.rikisha_profile"

#---------------------------------------
# Define Functions
#---------------------------------------
exit_abort()
{
  echo "Finished: ABORT"
  exit 1
}

########################################
# Start Message
########################################
echo "
****************************************************
              Jinrikisha (人力車)                 
                                                  
- Asakusa Framework Starter Package with Installer -
                                                  
  Version: $_RIKISHA_VERSION ($_BUILD_ID)
****************************************************
"

########################################
# Parse Command Parameter
########################################
_CMDNAME=`basename $0`

while getopts r: _OPTWORK
do
  case "$_OPTWORK" in
    "r" ) _OPT_M2REPO_ARCHIVE="true" ; _VAL_M2REPO_ARCHIVE="$OPTARG" ;;
                   * ) echo Usage: "${_CMDNAME}" [-r path_of_m2repo_tar_archive] 1>&2
                       exit 1 ;;
  esac
done

if [ -n "${_OPT_M2REPO_ARCHIVE}" ]; then
  _VAL_M2REPO_ARCHIVE=$(cd $(dirname "${_VAL_M2REPO_ARCHIVE}") && pwd)/$(basename "$_VAL_M2REPO_ARCHIVE")
  if [ ! -r "${_VAL_M2REPO_ARCHIVE}" ]; then
    echo "オプション [-r] に指定したファイル ${_VAL_M2REPO_ARCHIVE} が読み込み可能ではありません。"
    exit_abort
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
    which javac
    _RET=$?
    if [ $_RET -ne 0 ]; then
      echo '
  Java(JDK)がインストールされていないため、
  OpenJDKをインストールしてセットアップを続行します。

  ** WARNING ********************************************************
  OpenJDKを使用せず、OracleJDKを使用する場合は
  インストールを中断してください。
  
  (OracleJDKを使用するには、OracleJDKを手動でインストールしてから
  環境変数JAVA_HOMEにOracleJDKのインストールディレクトリを設定し、
  再度 setup.sh を実行してインストールを行います)

  OracleJDKのインストール方法は以下のサイトなどを参考にしてください。
  http://java.sun.com/javase/ja/6/webnotes/install/index.html
  *******************************************************************

    '
      read -p "OpenJDKをインストールしてインストールを続行しますか？:[Y/n]: " _YN
      if [ "$_YN" ]; then
        _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
      else
        _YN="y"
      fi
      if [ "$_YN" = y ]; then
        which apt-get > /dev/null 2>&1
        _RET=$?
        if [ $_RET -eq 0 ]; then
          _JAVA_HOME="/usr/lib/jvm/java-6-openjdk"
          sudo apt-get install -y openjdk-6-jdk
        else
          which yum > /dev/null 2>&1
          _RET=$?
          if [ $_RET -eq 0 ]; then
            _JAVA_HOME="/usr/lib/jvm/java-openjdk"
            sudo yum install java-1.6.0-openjdk-devel
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
        echo "JAVA_HOMEに $_JAVA_HOME を指定しました。"
      else
        echo "インストールを中断します。"
        exit_abort
      fi
    else
      if [ -z "$JAVA_HOME" ]; then
        echo "PATHにJDKが存在しますが、JAVA_HOMEが指定されていません。"
        echo ""
        while :
        do
          read -p "JAVA_HOMEを指定してください:: " _INSTR
          if [ "$_INSTR" ]; then
            _JAVA_HOME_TEMP="$_INSTR"
          else
            continue
          fi
          if [ -f "${_JAVA_HOME_TEMP}/bin/javac" ]; then
            _JAVA_HOME="$_JAVA_HOME_TEMP"
            echo "JAVA_HOMEに $_JAVA_HOME を指定しました。"
            break
          else
            echo "[ERROR] 指定したディレクトリ $_JAVA_HOME_TEMP にはJava(JDK)がインストールされていません。"
          fi
        done
      else
        _JAVA_HOME="$JAVA_HOME"
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
    echo "$_ASAKUSA_DEVELOP_HOME"
    echo ""
    break
  else
    echo "[ERROR] 指定したディレクトリ $_ASAKUSA_DEVELOP_HOME_TEMP を作成する権限がありません。"
  fi
done

export ASAKUSA_DEVELOP_HOME="$_ASAKUSA_DEVELOP_HOME"

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
  - M2_HOME=\${ASAKUSA_DEVELOP_HOME}/maven
  - HADOOP_HOME=\${ASAKUSA_DEVELOP_HOME}/hadoop
  - PATH: \$JAVA_HOME/bin:\$M2_HOME/bin:\$HADOOP_HOME/bin: \\
          \$ASAKUSA_DEVELOP_HOME/eclipse:\$ASAKUSA_HOME/yaess/bin: \\
          \$PATH

* インストールする環境にすでに
  Java,Maven,Hadoop,Asakusa Frameworkがインストールされている場合、
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
1) Mavenリモートリポジトリからライブラリをダウンロードするため、
   インストールには10分以上かかる可能性があります。

2) インストールを実行することにより、
   ホームディレクトリ[$HOME]のパーミッションに対して
   OTHERに対するread,execute権限が付与されます。
   (Ubuntu,MacOSXなどではデフォルトでこれらの権限が付与されていますが、
    CentOSなどではデフォルトに対して権限が追加になります)
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
# Install Maven
########################################
echo "Mavenをインストールしています。"

cd archives
tar xf apache-maven-*-bin.tar.gz
mv apache-maven-*/ maven
mv maven "$ASAKUSA_DEVELOP_HOME"
cd ..

cp -p "$ASAKUSA_DEVELOP_HOME"/maven/conf/settings.xml "$ASAKUSA_DEVELOP_HOME"/maven/conf/settings.xml.ORG
cp _templates/maven/conf/settings.xml "$ASAKUSA_DEVELOP_HOME"/maven/conf
sed -i -e "s;/path/to/local/repo;$ASAKUSA_DEVELOP_HOME/repository;" "$ASAKUSA_DEVELOP_HOME"/maven/conf/settings.xml

if [ "${_OPT_M2REPO_ARCHIVE}" ]; then
  tar -xf "${_VAL_M2REPO_ARCHIVE}"
  mv repository "$ASAKUSA_DEVELOP_HOME"
fi

_EXPORT="${_EXPORT}"'export M2_HOME=${ASAKUSA_DEVELOP_HOME}/maven\n'
_PATH="${_PATH}":'$M2_HOME/bin'

########################################
# Install Hadoop
########################################
echo "Hadoopをインストールしています。"

cd archives
tar xf hadoop-0.20.*.tar.gz
mv hadoop-0.20.*/ hadoop
mv hadoop "$ASAKUSA_DEVELOP_HOME"
_EXPORT="${_EXPORT}"'export HADOOP_HOME=${ASAKUSA_DEVELOP_HOME}/hadoop\n'
_PATH="${_PATH}":'$HADOOP_HOME/bin'
cd ..

########################################
# Install Eclipse
########################################
echo "Eclipseをインストールしています。"

cd archives
tar xf eclipse-*.tar.gz
mv eclipse "$ASAKUSA_DEVELOP_HOME"
mkdir "$ASAKUSA_DEVELOP_HOME"/workspace
cd ..

cp -r _templates/eclipse "$ASAKUSA_DEVELOP_HOME"
sed -i -e "s;/path/to/workspace;$ASAKUSA_DEVELOP_HOME/workspace;" "$ASAKUSA_DEVELOP_HOME"/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs

cp -r _templates/workspace "$ASAKUSA_DEVELOP_HOME"
sed -i -e "s;/path/to/settings.xml;$ASAKUSA_DEVELOP_HOME/maven/conf/settings.xml;" "$ASAKUSA_DEVELOP_HOME"/workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.m2e.core.prefs

_PATH="${_PATH}":'$ASAKUSA_DEVELOP_HOME/eclipse'

########################################
# Setup Environment Variables
########################################
echo "環境変数を設定しています。"

_PATH="${_PATH}":'$ASAKUSA_HOME/yaess/bin'
_PATH="${_PATH}":'$PATH'
printf "${_EXPORT}${_PATH}" > "${_RIKISHA_PROFILE}"

. "${_RIKISHA_PROFILE}"

########################################
# Install Asakusa Framework
#######################################
echo "Asakusa Frameworkをインストールしています。"

chmod a+rx $HOME

case "$_ASAKUSAFW_VERSION" in
  *-SNAPSHOT ) _REPO_SUFFIX="snapshots" ;;
  * ) _REPO_SUFFIX="releases" ;;
esac

cd "${ASAKUSA_DEVELOP_HOME}"/workspace
mvn archetype:generate -DarchetypeRepository="${_REPO_URL}${_REPO_SUFFIX}" -DarchetypeCatalog="${_REPO_URL}"archetype-catalog.xml -DinteractiveMode=false -DarchetypeGroupId="com.asakusafw" -DarchetypeArtifactId="$_EXAMPLE_ARCHETYPE_ID" -DarchetypeVersion="$_ASAKUSAFW_VERSION" -DgroupId="$_EXAMPLE_GROUP_ID" -DartifactId="$_EXAMPLE_ARTIFACT_ID" -Dversion="1.0-SNAPSHOT" -Dpackage="$_EXAMPLE_GROUP_ID"
if [ $? -ne 0 ]; then
  exit_abort
fi

cd "$_EXAMPLE_ARTIFACT_ID"
mvn clean assembly:single antrun:run package eclipse:eclipse
if [ $? -ne 0 ]; then
  exit_abort 
fi

rm -fr "$ASAKUSA_HOME"/batchapps/*
jar -xf target/"$_EXAMPLE_ARTIFACT_ID"-batchapps-*.jar "$_EXAMPLE_BATCH_ID"
mv "$_EXAMPLE_BATCH_ID" $ASAKUSA_HOME/batchapps
rm -fr /tmp/windgate-"$USER"
mkdir /tmp/windgate-"$USER"
cp -pr src/test/example-dataset/* /tmp/windgate-"$USER"

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
    _SETENV="${_SETENV}setenv HADOOP_HOME ${ASAKUSA_DEVELOP_HOME}/hadoop"'\n'
    printf "$_SETENV" | sudo tee /etc/launchd.conf
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
  read -p "今すぐにOSを再起動しますか？:[Y/n]: " _YN
  if [ -z "$_YN" ]; then
    _YN="y"
  else
    _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
  fi
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
コマンド例
------------------------------------------------------------------
### シェルに対して環境変数を追加
. ${_RIKISHA_PROFILE}

### サンプルアプリケーションの実行
yaess-batch.sh example.summarizeSales -A date=2011-04-01

### Mavenコマンドの実行
cd $ASAKUSA_DEVELOP_HOME/workspace/$_EXAMPLE_ARTIFACT_ID

###### モデルクラスの生成
mvn clean generate-sources

###### バッチコンパイル
mvn clean package

### Eclipseの起動
eclipse &
------------------------------------------------------------------
" > "$ASAKUSA_DEVELOP_HOME"/README

cat "$ASAKUSA_DEVELOP_HOME"/README

