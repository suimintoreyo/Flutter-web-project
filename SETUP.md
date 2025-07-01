# Dart-flutter-Serverpod-web-project(構築例 GenBy GPT)

Dart と Flutter で web application を構築してみる

このプロジェクトは、Dart と Flutter を使用して Web アプリケーションを構築するためのものです。フロントエンドには Flutter、バックエンドには Serverpod を使用します。

## 環境構築

### frontend (Flutter)

Flutter プロジェクトのセットアップは以下の手順で行います。

1.  **Flutter SDK のインストール:**

    まだ Flutter SDK をインストールしていない場合は、公式ドキュメントに従ってインストールしてください。
    [Flutter SDK のインストール](https://flutter.dev/docs/get-started/install)

2.  **VS Code のセットアップ:**

    `Flutter`拡張機能と`Dart`拡張機能をインストールしてください。

3.  **プロジェクトのクローン:**

    このリポジトリをクローンします。

    ```bash
    git clone [あなたのリポジトリURL]
    cd dart-typing/dart_typing_flutter # Flutterプロジェクトのディレクトリに移動
    ```

4.  **依存関係の取得:**

    Flutter プロジェクトの依存関係を解決します。

    ```bash
    flutter pub get
    ```

5.  **開発サーバーとの接続設定:**

    Serverpod クライアントは、バックエンドサーバーのアドレスを必要とします。通常、Serverpod プロジェクトを生成すると、`lib/main.dart`のようなファイルにクライアントの初期化コードが含まれています。開発時には、`http://localhost:8080/`（Serverpod のデフォルトポート）を指すように設定されていることを確認してください。

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

6.  **Flutter アプリケーションの実行:**

    Web ブラウザでアプリケーションを実行します。

    ```bash
    flutter run -d web
    ```

    または、お好みのデバイスで実行してください。

### backend (Serverpod)

Serverpod バックエンドのセットアップは以下の手順で行います。

1.  **Dart SDK のインストール:**

    Serverpod は Dart ベースなので、Dart SDK がインストールされていることを確認してください。
    [Dart SDK のインストール](https://dart.dev/get-dart)

2.  **PostgreSQL のインストールと設定:**

    Serverpod はデータベースに PostgreSQL を使用します。PostgreSQL をインストールし、Serverpod が接続できるユーザーとデータベースを設定してください。

    - **pgAdmin の導入（推奨 GUI ツール）:**

      PostgreSQL の管理やデータベース操作には、公式の GUI ツール「pgAdmin」の利用を推奨します。  
      [pgAdmin 公式サイト](https://www.pgadmin.org/download/) からお使いの OS に合わせてダウンロード・インストールしてください。

      **インストール手順例（Windows の場合）:**

      1. 上記リンクからインストーラーをダウンロード
      2. インストーラーを実行し、画面の指示に従ってインストール
      3. インストール後、pgAdmin を起動
      4. 「Add New Server」から、PostgreSQL サーバーの接続情報（ホスト名、ユーザー名、パスワードなど）を入力して接続

      pgAdmin を使うことで、データベースの作成やテーブルの確認、SQL の実行などが GUI で簡単に行えます。

    - **Docker を使用する場合（推奨）:**

      Serverpod のセットアップ時に提供される Docker Compose ファイルを使用すると、PostgreSQL と Redis（オプション）を簡単に起動できます。

      プロジェクトのルートディレクトリで、以下のコマンドを実行して Docker コンテナを起動します。

      ```bash
      docker-compose up -d
      ```

    - **手動でインストールする場合:**

      お使いの OS に合った方法で PostgreSQL をインストールし、データベースユーザーとデータベースを作成してください。
      例:

      ```sql
      CREATE USER serverpod_user WITH PASSWORD 'your_password';
      CREATE DATABASE dart_typing_db WITH OWNER serverpod_user;
      GRANT ALL PRIVILEGES ON DATABASE dart_typing_db TO serverpod_user;
      ```

3.  **Serverpod CLI のインストール:**

    Serverpod のコマンドラインツールをインストールします。

    ```bash
    dart pub global activate serverpod_cli
    ```

4.  **プロジェクトのクローン:**

    このリポジトリをクローンします。

    ```bash
    git clone [あなたのリポジトリURL]
    cd dart-typing # プロジェクトのルートディレクトリに移動
    ```

5.  **Serverpod プロジェクトの初期設定:**

    `config/production.yaml`や`config/development.yaml`などの設定ファイルで、データベース接続情報（ユーザー名、パスワード、データベース名）が正しく設定されていることを確認してください。特に Docker を使用しない場合は重要です。

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

    Serverpod のモデル定義に基づいてデータベーススキーマを生成・更新します。

    ```bash
    serverpod generate
    serverpod create-migrations
    serverpod apply-migrations
    ```

    これらのコマンドは、サーバーのルートディレクトリ（`dart-typing`）で実行する必要があります。

7.  **サーバーの実行:**

    Serverpod サーバーを起動します。

    ```bash
    dart bin/main.dart
    ```

    サーバーはデフォルトで 8080 ポートでリクエストを待ち受けます。

これで、Flutter フロントエンドと Serverpod バックエンドが連携して動作する準備が整いました。
