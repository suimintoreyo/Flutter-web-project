# dart-typing

Dart と Flutter で web application を構築してみる

## 利用技術

- **フロントエンド:**

  - Flutter (推奨バージョン: 3.19 以降)
  - Dart (推奨バージョン: 3.3 以降)
  - Material Design（Google Design）標準サポート
  - 必要に応じて [tailwindcss-flutter](https://pub.dev/packages/tailwindcss_flutter) パッケージ

- **バックエンド:**

  - Serverpod (推奨バージョン: 1.2 以降)
  - Dart
  - PostgreSQL (推奨バージョン: 14 以降)
  - Redis（推奨：セッション管理やキャッシュ用途で利用。導入方法は SETUP.md 参照）

- **開発ツール:**
  - Visual Studio Code（Flutter/Dart 拡張推奨）
  - Docker（PostgreSQL/Redis のコンテナ起動用、任意）

## バージョン例

| ツール/ライブラリ   | バージョン例 |
| ------------------- | ------------ |
| Flutter             | 3.22.0       |
| Dart                | 3.4.0        |
| Serverpod           | 1.2.5        |
| PostgreSQL          | 15.x         |
| Redis               | 7.x          |
| tailwindcss-flutter | 0.7.0        |

> ※ご利用の環境や要件に合わせてバージョンを調整してください。
