# Flutter-web-application

Dart と Flutter で web application を構築してみる

## プロジェクト概要

このプロジェクトは、Dart と Flutter を使用して Web アプリケーションを構築するためのものです。フロントエンドには Flutter、バックエンドには Serverpod を使用します。プロジェクトは、開発環境と本番環境の両方で動作するように設計されています。

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
  - Redis（推奨：セッション管理やキャッシュ用途で利用。導入方法は backend/README.md 参照）

- **開発ツール:**
  - Docker（PostgreSQL/Redis のコンテナ起動用、任意）

## セットアップ手順

1. **フロントエンドのセットアップ:**
   - `frontend/SETUP.md` を参照して、Flutter プロジェクトのセットアップを行ってください。

2. **バックエンドのセットアップ:**
   - `backend/SETUP.md` を参照して、Serverpod バックエンドのセットアップを行ってください。

## バージョン情報

| ツール/ライブラリ   | バージョン例 |
| ------------------- | ------------ |
| Flutter             | 3.22.0       |
| Dart                | 3.4.0        |
| Serverpod           | 1.2.5        |
| PostgreSQL          | 15.x         |
| Redis               | 7.x          |
| tailwindcss-flutter | 0.7.0        |

> ※ご利用の環境や要件に合わせてバージョンを調整してください。