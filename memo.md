# DartおよびFlutterによるServerpodバックエンドWebアプリケーションの包括的なディレクトリ構造

---

## はじめに

このレポートでは、**Dartをフルスタックで活用したモダンなWebアプリケーション**に最適なディレクトリ構造を詳細に解説します。

- **フロントエンド**: Flutter（バージョン3.19以降）
- **バックエンド**: Serverpod（バージョン1.2以降）
- **データ永続化**: PostgreSQL（バージョン14以降）
- **キャッシュ/セッション管理**: Redis（バージョン7以降）
- **開発環境**: Visual Studio Code推奨、Docker活用

適切なディレクトリ構造は、保守性・デバッグ・チームコラボレーション・スケーラビリティ向上に極めて重要です。

---

## 全体的なモノレポプロジェクト構造

Serverpodは**モノレポ設計**を採用しています。  
`serverpod create` コマンドで以下の3パッケージが生成されます。

| パッケージ名             | 役割                                                                                   |
|-------------------------|----------------------------------------------------------------------------------------|
| `<project_name>_server` | バックエンドロジック、APIエンドポイント、DBモデル                                      |
| `<project_name>_client` | 自動生成クライアントライブラリ。型安全なAPIを提供（手動編集不可）                      |
| `<project_name>_flutter`| Flutter Webアプリ本体                                                                  |

**その他の主要ファイル・ディレクトリ:**

| ディレクトリ/ファイル      | 説明                                                                                   |
|---------------------------|----------------------------------------------------------------------------------------|
| `.vscode/`                | VS Codeワークスペース設定・拡張機能・デバッグ設定                                      |
| `docker-compose.yaml`      | PostgreSQL・Redis・ServerpodテストサーバーのDocker設定                                 |
| `README.md`               | プロジェクト概要・セットアップ手順                                                     |
| `SETUP.md`                | 依存関係やDockerコマンド等の詳細セットアップ手順                                      |
| `pubspec.yaml`            | 共通依存管理（大規模プロジェクトで検討）                                              |

---

## フロントエンドアプリケーション構造（`<project_name>_flutter`）

### レイヤードアーキテクチャ

- **UI層**: ユーザーインターフェース、View・ViewModel
- **データ層**: Repository・Service・Model
- **ドメイン層（任意）**: UseCase等のビジネスロジック

### ディレクトリ構成

| ディレクトリ/ファイル         | 責務・内容                                               | アーキテクチャ層         |
|------------------------------|----------------------------------------------------------|--------------------------|
| `lib/main.dart`              | エントリーポイント・ルートウィジェット                   | UI層                     |
| `lib/ui/`                    | UI関連コード                                             | UI層（Views）            |
| `lib/ui/pages/`              | 各画面ウィジェット                                       | UI層（Views）            |
| `lib/ui/widgets/`            | 再利用可能な汎用ウィジェット                             | UI層（Views）            |
| `lib/ui/components/`         | 特定機能向け再利用UIコンポーネント                       | UI層（Views）            |
| `lib/view_models/`           | UI状態管理・表示ロジック                                 | UI層（View Models）      |
| `lib/data/`                  | データ取得・永続化・ビジネスロジック                     | データ層                 |
| `lib/data/repositories/`     | データ抽象化・ビジネスロジック                           | データ層（Repositories） |
| `lib/data/services/`         | API/DB操作・Serverpodクライアント利用                    | データ層（Services）     |
| `lib/data/models/`           | UI/ドメイン層向けデータモデル                            | データ層（Models）       |
| `lib/domain/`                | 複雑なビジネスロジック・ユースケース（任意）             | ドメイン層（Use Cases）  |
| `lib/auth/`                  | 認証関連ロジック・UI                                     | UI/データ層              |
| `lib/backend/`               | Serverpodクライアント統合ロジック                        | データ層                 |
| `lib/utils/`                 | 汎用ユーティリティ・定数                                 | 共通ユーティリティ       |
| `lib/generated/`             | Serverpod自動生成クライアントコード（編集不可）           | データ層（生成コード）   |
| `assets/`                    | 静的ファイル（画像・フォント等）                         | -                        |

---

## バックエンドサーバー構造（`<project_name>_server`）

### 主なディレクトリ

| ディレクトリ/ファイル         | 役割・内容                                                                 | コード生成との関連性         |
|------------------------------|----------------------------------------------------------------------------|-----------------------------|
| `lib/src/endpoints/`         | APIエンドポイント定義                                                      | クライアント自動生成元       |
| `lib/src/protocol/`          | データモデル・DBテーブルYAML定義                                           | サーバー/クライアント生成元  |
| `lib/src/generated/`         | Serverpod自動生成サーバーサイドコード                                      | 生成コード（編集不可）       |
| `config/`                    | サーバー構成ファイル（環境別設定・機密情報等）                              | -                           |
| `bin/`                       | サーバーエントリーポイント（main.dart等）                                  | -                           |
| `pubspec.yaml`               | 依存関係・メタデータ                                                       | -                           |

---

## 共有クライアントパッケージ構造（`<project_name>_client`）

- **目的**: サーバー定義のエンドポイント・データモデルに対応するDartクラス・メソッドを自動生成
- **編集不可**: 変更はサーバー側の`protocol/`や`endpoints/`を修正し、`serverpod generate`で再生成
- **主なディレクトリ**:  
  - `lib/src/generated/`: クライアント用データモデル・API

---

## ルートレベルのファイルとディレクトリ

| ファイル/ディレクトリ         | 役割・内容                                                                 |
|------------------------------|----------------------------------------------------------------------------|
| `docker-compose.yaml`        | PostgreSQL・Redis・ServerpodテストサーバーのDocker設定                      |
| `.vscode/`                   | VS Codeワークスペース設定・拡張機能・デバッグ設定                           |
| `README.md`                  | プロジェクト概要・主要機能・コードベース概要                                |
| `SETUP.md`                   | セットアップ手順・Dockerコマンド等                                          |
| `pubspec.yaml`               | 共通依存管理（任意）                                                        |

---

## 主要なアーキテクチャ上の考慮事項とベストプラクティス

### 責務の分離

- UI層・データ層・ドメイン層の明確な分割
- 各層の独立性により、テスト容易性・保守性向上

### Serverpodのコード生成活用

- `protocol`のYAMLスキーマが**単一の真のソース**
- サーバー・クライアント両方のDartコードを自動生成
- 型安全な通信・ボイラープレート削減

### スケーラビリティとモジュール性

- Serverpodモジュールで機能単位の独立開発が容易
- Flutter側も機能ごとにディレクトリ分割で大規模化に対応

### テスト容易性

- 層ごとの独立テストが可能
- Serverpodもエンドポイント・DB操作のテストフレームワークを提供

---

## 結論

適切に計画されたディレクトリ構造は、**戦略的な資産**です。  
Serverpodのモノレポ枠組みとFlutterのレイヤードアーキテクチャを組み合わせることで、  
- 保守性
- テスト容易性
- スケーラビリティ

を高いレベルで実現できます。  
**Docker**による依存管理・開発環境セットアップも生産性向上に寄与します。  
構造原則の遵守とコードレビューによる一貫性維持が推奨されます。

---

## 参考文献

1. [Installation | Serverpod](https://docs.serverpod.dev/) (2025/07/02アクセス)
2. [Roadmap & contributions - Installation | Serverpod](https://docs.serverpod.dev/2.2.0/contribute) (2025/07/02アクセス)
3. [Get started - Installation | Serverpod](https://docs.serverpod.dev/1.1.1/get-started) (2025/07/02アクセス)
4. [Guide to app architecture - Flutter Documentation](https://docs.flutter.dev/app-architecture/guide) (2025/07/02アクセス)
5. [Layout | Flutter](https://docs.flutter.dev/ui/layout) (2025/07/02アクセス)
6. [Directory Structure | FlutterFlow Documentation](https://docs.flutterflow.io/generated-code/project-structure/) (2025/07/02アクセス)
7. [Build your first app - Installation | Serverpod](https://docs.serverpod.dev/tutorials/first-app) (2025/07/02アクセス)
