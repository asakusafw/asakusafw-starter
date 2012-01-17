#!/bin/bash

. "$(dirname $0)/VERSION"

#---------------------------------------
# Define Defalut Valuables
#---------------------------------------
_JAVA_HOME_DEFAULT="/usr/lib/jvm/java-6-openjdk"
_RIKISHA_HOME_DEFAULT="$HOME/jinrikisha"
_ADD_PROFILE_DEFAULT="y"
_CREATE_ECLIPSE_SHORTCUT_DEFAULT="y"

#---------------------------------------
# Define Constants
#---------------------------------------
_REPO_URL="http://asakusafw.s3.amazonaws.com/maven/"
_EXAMPLE_GROUP_ID="com.example"
_EXAMPLE_ARTIFACT_ID="example-app"
_EXAMPLE_ARCHETYPE_ID="asakusa-archetype-windgate"

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
                                                  
  Version: $_RIKISHA_VERSION
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
    echo "オプション m2repo-archive に指定したファイル ${_VAL_M2REPO_ARCHIVE} が読み込み可能ではありません。"
    exit_abort
  fi
fi

cd $(dirname $0) 
########################################
# Check and Install JDK
########################################
echo "Java(JDK)がインストールされているか確認します。"

if [ -n "$JAVA_HOME" -a -r "$JAVA_HOME/bin/javac" ]; then
  _JAVA_HOME="$JAVA_HOME"
  echo "JAVA_HOMEにJava(JDK)のパスが指定されています。 $_JAVA_HOME をJinkirikisha用のJAVA_HOMEに使用します。"
else
  which javac
  _RET=$?
  if [ $_RET -ne 0 ]; then
    echo '
Java(JDK)がインストールされていないため、
OpenJDKをインストールしてセットアップを続行します。

** WARNING ***************************************
OracleJDKを使用する場合は一旦インストールを中断し、
OracleJDKをインストール後、JAVA_HOMEにOracleJDKの
インストールディレクトリを指定してから
再度インストールを行なってください。

OracleJDKのインストール方法は以下のサイトなどを参考にしてください
http://asakusafw.s3.amazonaws.com/documents/0.2/release/ja/html/introduction/start-guide.html#java-jdk
**************************************************

  '
    read -p "OpenJDKをインストールしてインストールを続行しますか？: Y: " _YN
    if [ "$_YN" ]; then
      _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
    else
      _YN="y"
    fi
    if [ "$_YN" = y ]; then
      sudo apt-get install -y openjdk-6-jdk
      _RET=$?
      if [ $_RET -ne 0 ]; then
        exit_abort
      fi
      _JAVA_HOME="$_JAVA_HOME_DEFAULT"
      echo "OpenJDKのインストールが完了しました。"
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
        read -p "JAVA_HOMEを指定してください: $_JAVA_HOME_DEFAULT: " _INSTR
        if [ "$_INSTR" ]; then
          _JAVA_HOME_TEMP="$_INSTR"
        else
          _JAVA_HOME_TEMP="$_JAVA_HOME_DEFAULT"
        fi
        if [ -f "${_JAVA_HOME_TEMP}/bin/javac" ]; then
          _JAVA_HOME="$_JAVA_HOME_TEMP"
          echo "JAVA_HOMEに $_JAVA_HOME を指定しました。"
          break;
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

########################################
# Input Install Parameters
########################################
echo "------------------------------------------------"

while :
do
  read -p "Jinrikishaのインストールディレクトリ(RIKISHA_HOME)を入力してください。: $_RIKISHA_HOME_DEFAULT: " _INSTR
  if [ "$_INSTR" ]; then
    eval _INSTR=$_INSTR
    _RIKISHA_HOME_TEMP=$(cd $(dirname $_INSTR) && pwd)/$(basename $_INSTR)
  else
    _RIKISHA_HOME_TEMP="$_RIKISHA_HOME_DEFAULT"
  fi

  if [ -w $(dirname "$_RIKISHA_HOME_TEMP") ]; then
    _RIKISHA_HOME="$_RIKISHA_HOME_TEMP"
    echo "インストールディレクトリ(RIKISHA_HOME)に $_RIKISHA_HOME を指定しました。"
    break
  else
    echo "[ERROR] 指定したディレクトリ $_RIKISHA_HOME_TEMP を作成する権限がありません。"
  fi
done

export RIKISHA_HOME="$_RIKISHA_HOME"
_RIKISHA_PROFILE="$RIKISHA_HOME/.rikisha_profile"

_EXPORT="${_EXPORT}export RIKISHA_HOME=${RIKISHA_HOME}"'\n'
_EXPORT="${_EXPORT}"'export ASAKUSA_HOME=${RIKISHA_HOME}/asakusa\n'

read -p "Asakusa Frameworkのバージョンを入力してください。: $_ASAKUSAFW_VERSION_DEFAULT: " _INSTR
if [ "$_INSTR" ]; then
  _ASAKUSAFW_VERSION="$_INSTR"
else
  _ASAKUSAFW_VERSION="$_ASAKUSAFW_VERSION_DEFAULT"
fi

read -p "$HOME/.profile に $_RIKISHA_PROFILE を実行する定義を追加しますか？: Y: " _YN
if [ "$_YN" ]; then
  _YN=`echo $_YN | tr "[:upper:]" "[:lower:]"`
else
  _YN="$_ADD_PROFILE_DEFAULT"
fi
if [ "$_YN" = "y" ]; then
  _ADD_PROFILE="y"

  read -p "デスクトップ に Eclipseのショートカットを追加しますか？: Y: " _YN
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
else
  _ADD_PROFILE="n"
  _CREATE_ECLIPSE_SHORTCUT="n"
fi

########################################
# Start Install
########################################
echo "
************************************************************
インストールの準備が完了しました。

Mavenリモートリポジトリからライブラリをダウンロードするため、
インストールには10分以上かかる可能性があります。
"
read -p "インストールを続行するには[Enter]キーを押してください。: " _DUMMY

if [ -d "$RIKISHA_HOME" ]; then
  _RIKISHA_BACKUP="${RIKISHA_HOME}_`date +%Y%m%d%H%M%S`"
  echo "インストールディレクトリ $RIKISHA_HOME に既にディレクトリが存在するため、$_RIKISHA_BACKUP に退避します。"
  mv "$RIKISHA_HOME" "$_RIKISHA_BACKUP"
fi
mkdir "$RIKISHA_HOME"

########################################
# Install Maven
########################################
echo "Mavenをインストールしています。"

cd archives
tar xf apache-maven-*-bin.tar.gz
mv apache-maven-*/ maven
mv maven "$RIKISHA_HOME"
cd ..

cp -p "$RIKISHA_HOME"/maven/conf/settings.xml "$RIKISHA_HOME"/maven/conf/settings.xml.ORG
cp _templates/maven/conf/settings.xml "$RIKISHA_HOME"/maven/conf
sed -i -e "s;/path/to/local/repo;$RIKISHA_HOME/repository;" "$RIKISHA_HOME"/maven/conf/settings.xml

if [ "${_OPT_M2REPO_ARCHIVE}" ]; then
  tar -xf "${_VAL_M2REPO_ARCHIVE}"
  mv repository "$RIKISHA_HOME"
fi

_EXPORT="${_EXPORT}"'export M2_HOME=${RIKISHA_HOME}/maven\n'
_PATH="${_PATH}":'$M2_HOME/bin'

########################################
# Install Hadoop
########################################
echo "Hadoopをインストールしています。"

cd archives
tar xf hadoop-0.20.*.tar.gz
mv hadoop-0.20.*/ hadoop
mv hadoop "$RIKISHA_HOME"
_EXPORT="${_EXPORT}"'export HADOOP_HOME=${RIKISHA_HOME}/hadoop\n'
_PATH="${_PATH}":'$HADOOP_HOME/bin'
cd ..

########################################
# Install Eclipse
########################################
echo "Eclipseをインストールしています。"

cd archives
tar xf eclipse-*.tar.gz
mv eclipse "$RIKISHA_HOME"
mkdir "$RIKISHA_HOME"/workspace
cd ..

cp -r _templates/eclipse "$RIKISHA_HOME"
sed -i -e "s;/path/to/workspace;$RIKISHA_HOME/workspace;" "$RIKISHA_HOME"/eclipse/configuration/.settings/org.eclipse.ui.ide.prefs

cp -r _templates/workspace "$RIKISHA_HOME"
sed -i -e "s;/path/to/settings.xml;$RIKISHA_HOME/maven/conf/settings.xml;" "$RIKISHA_HOME"/workspace/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.m2e.core.prefs

_PATH="${_PATH}":'$RIKISHA_HOME/eclipse'

########################################
# Setup Environment Variables
########################################
echo "環境変数を設定しています。"

_PATH="${_PATH}":'$PATH'
printf "${_EXPORT}${_PATH}" > "${_RIKISHA_PROFILE}"

. "${_RIKISHA_PROFILE}"

########################################
# Install Asakusa Framework
#######################################
echo "Asakusa Frameworkをインストールしています。"

case "$_ASAKUSAFW_VERSION" in
  *-SNAPSHOT ) _REPO_SUFFIX="snapshots" ;;
  * ) _REPO_SUFFIX="releases" ;;
esac

cd "${RIKISHA_HOME}"/workspace
mvn archetype:generate -DarchetypeRepository="${_REPO_URL}${_REPO_SUFFIX}" -DarchetypeCatalog="${_REPO_URL}"archetype-catalog.xml -DinteractiveMode=false -DarchetypeGroupId="com.asakusafw" -DarchetypeArtifactId="$_EXAMPLE_ARCHETYPE_ID" -DarchetypeVersion="$_ASAKUSAFW_VERSION" -DgroupId="$_EXAMPLE_GROUP_ID" -DartifactId="$_EXAMPLE_ARTIFACT_ID" -Dversion="1.0-SNAPSHOT" -Dpackage="$_EXAMPLE_GROUP_ID"
if [ $? -ne 0 ]; then
  exit_abort
fi

cd "$_EXAMPLE_ARTIFACT_ID"
mvn clean assembly:single antrun:run package eclipse:eclipse
if [ $? -ne 0 ]; then
  exit_abort 
fi

########################################
# Configuration to OS
########################################
if [ "$_ADD_PROFILE" = "y" ]; then
  echo "~/.profileに${_RIKISHA_PROFILE}を実行する定義を追加します。"

  echo "# Configuration for Jinrikisha (Asakusa Framework Starter Package with Installer)
if [ -f \"${_RIKISHA_PROFILE}\" ]; then
  . \"${_RIKISHA_PROFILE}\"
fi" >> ~/.profile
fi

if [ "$_CREATE_ECLIPSE_SHORTCUT" = "y" ]; then
  echo "デスクトップにEclipseのショートカットを追加します。"

  if [ -d ~/Desktop ]; then
    ln -fs "$RIKISHA_HOME"/eclipse/eclipse ~/Desktop
  elif [ -d ~/デスクトップ ]; then
    ln -fs "$RIKISHA_HOME"/eclipse/eclipse ~/デスクトップ
  fi
fi

########################################
# Finish
########################################
echo "
*** Jinrikishaのインストールが成功しました。***
"

if [ "$_ADD_PROFILE" = "y" ]; then
  echo "デスクトップ環境に対して ~/.profile の変更を反映するにはOSの再起動が必要です。"
  read -p "今すぐにOSを再起動しますか？: Y: " _YN
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
ターミナルからJinkikishaによってインストールされた各ソフトウェアは
${_RIKISHA_PROFILE} をシェルに反映してから使用してください。
-------------------------------
### Jinrikisha用プロファイルをカレントシェルに反映
. ${_RIKISHA_PROFILE}

### Mavenコマンドの実行
cd "$RIKISHA_HOME"/workspace/$_EXAMPLE_ARTIFACT_ID
mvn clean generate-sources
mvn clean package
...

### Eclipseの起動
eclipse &
-------------------------------
"
fi

