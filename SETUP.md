# dart-typing(構築例 GenBy GPT)

Dart と Flutterでweb application を構築してみる

このプロジェクトは、DartとFlutterを使用してWebアプリケーションを構築するためのものです。フロントエンドにはFlutter、バックエンドにはServerpodを使用します。

## 環境構築

### frontend (Flutter)

Flutterプロジェクトのセットアップは以下の手順で行います。

1.  **Flutter SDKのインストール:**
    まだFlutter SDKをインストールしていない場合は、公式ドキュメントに従ってインストールしてください。
    [Flutter SDKのインストール](https://flutter.dev/docs/get-started/install)

2.  **VS Code (または任意のIDE) のセットアップ:**
    Flutter開発にはVS Codeが推奨されます。VS Codeを使用する場合は、`Flutter`拡張機能と`Dart`拡張機能をインストールしてください。

3.  **プロジェクトのクローン:**
    このリポジトリをクローンします。
    ```bash
    git clone [あなたのリポジトリURL]
    cd dart-typing/dart_typing_flutter # Flutterプロジェクトのディレクトリに移動
    ```

4.  **依存関係の取得:**
    Flutterプロジェクトの依存関係を解決します。
    ```bash
    flutter pub get
    ```

5.  **開発サーバーとの接続設定:**
    Serverpodクライアントは、バックエンドサーバーのアドレスを必要とします。通常、Serverpodプロジェクトを生成すると、`lib/main.dart`のようなファイルにクライアントの初期化コードが含まれています。開発時には、`http://localhost:8080/`（Serverpodのデフォルトポート）を指すように設定されていることを確認してください。

    例:
    ```dart
    import 'package:dart_typing_client/dart_typing_client.dart'; // あなたのプロジェクト名に合わせる
    import 'package:serverpod_flutter/serverpod_flutter.dart';

    late Client client;

    void main() {
      // 開発環境の場合
      client = Client(
        'http://localhost:8080/', // Serverpodサーバーのアドレス
        authenticationKeyManager: ServerpodAuthenticationKeyManager(),
      )..connectivityMonitor = ServerpodConnectivityMonitor();

      // 本番環境の場合（必要に応じて設定を切り替えるロジックを追加）
      // client = Client(
      //   '[https://api.yourdomain.com/](https://api.yourdomain.com/)',
      //   authenticationKeyManager: ServerpodAuthenticationKeyManager(),
      // )..connectivityMonitor = ServerpodConnectivityMonitor();

      runApp(const MyApp());
    }
    ```

6.  **Flutterアプリケーションの実行:**
    Webブラウザでアプリケーションを実行します。
    ```bash
    flutter run -d web
    ```
    または、お好みのデバイスで実行してください。

### backend (Serverpod)

Serverpodバックエンドのセットアップは以下の手順で行います。

1.  **Dart SDKのインストール:**
    ServerpodはDartベースなので、Dart SDKがインストールされていることを確認してください。
    [Dart SDKのインストール](https://dart.dev/get-dart)

2.  **PostgreSQLのインストールと設定:**
    ServerpodはデータベースにPostgreSQLを使用します。PostgreSQLをインストールし、Serverpodが接続できるユーザーとデータベースを設定してください。

    * **Dockerを使用する場合（推奨）:**
        Serverpodのセットアップ時に提供されるDocker Composeファイルを使用すると、PostgreSQLとRedis（オプション）を簡単に起動できます。

        プロジェクトのルートディレクトリで、以下のコマンドを実行してDockerコンテナを起動します。
        ```bash
        docker-compose up -d
        ```

    * **手動でインストールする場合:**
        お使いのOSに合った方法でPostgreSQLをインストールし、データベースユーザーとデータベースを作成してください。
        例:
        ```sql
        CREATE USER serverpod_user WITH PASSWORD 'your_password';
        CREATE DATABASE dart_typing_db WITH OWNER serverpod_user;
        GRANT ALL PRIVILEGES ON DATABASE dart_typing_db TO serverpod_user;
        ```

3.  **Serverpod CLIのインストール:**
    Serverpodのコマンドラインツールをインストールします。
    ```bash
    dart pub global activate serverpod_cli
    ```

4.  **プロジェクトのクローン:**
    このリポジトリをクローンします。
    ```bash
    git clone [あなたのリポジトリURL]
    cd dart-typing # プロジェクトのルートディレクトリに移動
    ```

5.  **Serverpodプロジェクトの初期設定:**
    `config/production.yaml`や`config/development.yaml`などの設定ファイルで、データベース接続情報（ユーザー名、パスワード、データベース名）が正しく設定されていることを確認してください。特にDockerを使用しない場合は重要です。

    例 (`config/development.yaml`):
    ```yaml
    database:
      host: localhost
      port: 5432
      name: dart_typing_db
      user: serverpod_user
      password: your_password
    ```

6.  **データベースマイグレーションの実行:**
    Serverpodのモデル定義に基づいてデータベーススキーマを生成・更新します。
    ```bash
    serverpod generate
    serverpod create-migrations
    serverpod apply-migrations
    ```
    これらのコマンドは、サーバーのルートディレクトリ（`dart-typing`）で実行する必要があります。

7.  **サーバーの実行:**
    Serverpodサーバーを起動します。
    ```bash
    dart bin/main.dart
    ```
    サーバーはデフォルトで8080ポートでリクエストを待ち受けます。

これで、FlutterフロントエンドとServerpodバックエンドが連携して動作する準備が整いました。
