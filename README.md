# OracleDatabaseの調査


## 目次

1. [検証環境](#検証環境)
    * [概要](#概要)
    * [コンテナOS情報のトレース](#コンテナos情報のトレース)
    * [Oracle Databaseのバージョンのトレース](#oracle-databaseのバージョンのトレース)
1. [テーブルデータ](#テーブルデータ)
1. [検索サンプル](#検索サンプル)
    * [マーク別集計](#マーク別集計)
    * [マーク別集計（合計行付き）](#マーク別集計合計行付き)
    * [色別集計](#色別集計)
    * [色別集計（合計行付き）](#色別集計合計行付き)


## 検証環境

### 概要

| 項目 | 詳細 | 補足 |
| :--- | :--- | :--- |
| **ホストOS** | Windows 11 Home | 25H2 |
| **仮想基盤** | Docker Desktop | **WSL2** バックエンドを使用 |
| **コンテナOS** | **Oracle Linux Server 8.10** | |
| **データベース** | **Oracle Database 23c Free** | |
| **接続ツール** | VSCode (SQL Dev拡張) | |


### コンテナOS情報のトレース

```
$ cat /etc/os-release
NAME="Oracle Linux Server"
VERSION="8.10"
ID="ol"
ID_LIKE="fedora"
VARIANT="Server"
VARIANT_ID="server"
VERSION_ID="8.10"
PLATFORM_ID="platform:el8"
PRETTY_NAME="Oracle Linux Server 8.10"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:oracle:linux:8:10:server"
HOME_URL="https://linux.oracle.com/"
BUG_REPORT_URL="https://github.com/oracle/oracle-linux"

ORACLE_BUGZILLA_PRODUCT="Oracle Linux 8"
ORACLE_BUGZILLA_PRODUCT_VERSION=8.10
ORACLE_SUPPORT_PRODUCT="Oracle Linux"
ORACLE_SUPPORT_PRODUCT_VERSION=8.10
```


### Oracle Databaseのバージョンのトレース

```
SELECT * FROM V$INSTANCE;
```

|INSTANCE_NUMBER|INSTANCE_NAME|HOST_NAME|VERSION|VERSION_LEGACY|VERSION_FULL|STARTUP_|STATUS|PAR|THREAD#|ARCHIVE|LOG_SWITCH_WAIT|LOGINS|SHU|DATABASE_STATUS|INSTANCE_ROLE|ACTIVE_ST|BLO|CON_ID|INSTANCE_MO|EDITION|FAMILY|DATABASE_TYPE|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|1|FREE|4213682a030e|23.0.0.0.0|23.0.0.0.0|23.26.0.0.0|25-11-22|OPEN|NO|1|STARTED||ALLOWED|NO|ACTIVE|PRIMARY_INSTANCE|NORMAL|NO|0|REGULAR|FREE||SINGLE|


## テーブルデータ

[こちら](TABLE_DATA.md)

※JOKERの"suji"、"mark"、"is_num"はNULL


## 検索サンプル例


### マーク別集計

![マーク別の集計結果](/img/mark_normal.jpg)


### マーク別集計（合計行付き）

![マーク別の集計結果（合計行付き）](/img/mark_rollup.jpg)


### 色別集計

![色別の集計結果](/img/color_normal.jpg)


### 色別集計（合計行付き）

![色別の集計結果（合計行付き）](/img//color_rollup.jpg)

