# Electricity Tracker - 家庭用電気使用量・CO2排出量管理アプリ

家庭の電気使用量を記録し、CO2排出量を自動計算・可視化するWebアプリケーションです。
地域課題の実践として、環境意識の向上と電気使用量の削減を目的としています。

## 📋 目次

- [主な機能](#主な機能)
- [技術スタック](#技術スタック)
- [環境構築（初心者向け）](#環境構築初心者向け)
- [使い方](#使い方)
- [開発ワークフロー](#開発ワークフロー)
- [デプロイ](#デプロイ)
- [トラブルシューティング](#トラブルシューティング)

## 主な機能

### 📊 月別電気使用量の記録・管理
- 年月ごとの電気使用量（kWh）を登録
- データの追加・削除機能

### 🌍 CO2排出量の自動計算
- 電気使用量から自動的にCO2排出量を計算
- 日本の平均的な排出係数（0.45 kg-CO2/kWh）を使用

### 📈 データの可視化
- Chart.jsによる棒グラフ（電気使用量）と折れ線グラフ（CO2排出量）
- レスポンシブ対応で、スマートフォンでも見やすい表示
- 1月〜12月まで全ての月を表示

### 💡 節電の豆知識
- 電気使用量削減のためのヒントを表示

## 技術スタック

### バックエンド
- **Ruby** 3.4.6
- **Ruby on Rails** 8.0.3
- **ストレージ**: メモリ内配列（MVP用、データベース不要）

### フロントエンド
- **Hotwire** (Turbo + Stimulus)
- **Chart.js** - グラフ描画
- **Tailwind CSS** - スタイリング

### インフラ
- **開発環境**: ローカル（macOS/Linux）
- **ステージング**: Render（無料プラン）
- **本番環境**: AWS（予定）

### CI/CD
- **GitHub Actions**
  - RuboCop（コードスタイルチェック）
  - Brakeman（セキュリティスキャン）

## 環境構築（初心者向け）

### 前提条件

以下のソフトウェアがインストールされている必要があります：

1. **Ruby 3.4.6**
   ```bash
   # バージョン確認
   ruby -v
   # 出力例: ruby 3.4.6 (2025-09-16 revision ...)
   ```

2. **Bundler**（Rubyのパッケージマネージャー）
   ```bash
   # インストール
   gem install bundler

   # バージョン確認
   bundler -v
   ```

3. **Git**
   ```bash
   # バージョン確認
   git --version
   ```

### ステップ1: リポジトリをクローン

```bash
# GitHubからコードをダウンロード
git clone https://github.com/tokumori24/solve_local_issue.git

# プロジェクトディレクトリに移動
cd electricity-tracker
```

**補足**: `git clone` はリモートリポジトリからローカルにコードをコピーするコマンドです。

### ステップ2: 依存関係をインストール

```bash
# Gemfile に記載されているライブラリをインストール
bundle install
```

**補足**: `Gemfile` はRubyのライブラリ（gem）の依存関係を記述したファイルです。
`bundle install` でこれらのライブラリが一括インストールされます。

### ステップ3: 開発サーバーを起動

```bash
# Railsサーバーを起動
bin/rails server

# または短縮形
bin/rails s
```

**出力例**:
```
=> Booting Puma
=> Rails 8.0.3 application starting in development
=> Run `bin/rails server --help` for more startup options
* Listening on http://127.0.0.1:3000
```

### ステップ4: ブラウザでアクセス

ブラウザを開いて以下のURLにアクセス：
```
http://localhost:3000
```

**補足**: `localhost:3000` は自分のPCで動いているサーバーにアクセスするためのアドレスです。

### サーバーの停止方法

ターミナルで `Ctrl + C` を押すとサーバーが停止します。

## 使い方

### 電気使用量を追加する

1. ダッシュボードの「月別電気使用量」セクションのフォームに入力：
   - **年**: 例）2025
   - **月**: ドロップダウンから選択（1月〜12月）
   - **電気使用量 (kWh)**: 例）250.5

2. **「追加」** ボタンをクリック

3. 自動的に以下が更新されます：
   - テーブルに新しい行が追加
   - グラフに反映
   - CO2排出量が自動計算

### データを削除する

- テーブルの各行にある **「削除」** ボタンをクリック
- 確認ダイアログが表示されるので、「OK」を選択

### グラフを確認する

- **電気使用量グラフ**: 月別の使用量を棒グラフで表示
- **CO2排出量グラフ**: 月別の排出量を折れ線グラフで表示
- データがない月は「0」として表示されます

## 開発ワークフロー

### Git ブランチ戦略

このプロジェクトでは、以下のブランチ戦略を採用しています：

#### ブランチの種類

- **`main`**: 本番環境用の安定版コード
- **`add/機能名`**: 新しい機能を追加する場合
- **`modify/機能名`**: 既存機能を変更する場合
- **`fix/バグ名`**: バグを修正する場合
- **`docs/ドキュメント名`**: ドキュメントを更新する場合

#### ブランチ名の例

```bash
add/user-authentication     # ユーザー認証機能を追加
modify/chart-colors         # グラフの色を変更
fix/calculation-error       # CO2計算のバグ修正
docs/update-readme          # READMEの更新
```

### 開発の流れ（ステップ・バイ・ステップ）

#### 1. mainブランチを最新にする

```bash
# mainブランチに切り替え
git checkout main

# リモートから最新の変更を取得
git pull origin main
```

**補足**: 他の開発者の変更を取り込むため、作業前に必ずpullします。

#### 2. 新しいブランチを作成

```bash
# 新機能を追加する場合の例
git checkout -b add/new-feature-name
```

**補足**: `-b` オプションで新しいブランチを作成し、同時にそのブランチに切り替わります。

#### 3. コードを変更する

好きなエディタでコードを編集します。

#### 4. ローカルで動作確認

```bash
# 開発サーバーを起動
bin/rails server

# ブラウザで http://localhost:3000 にアクセスして動作確認
```

**重要**: 必ずローカルで正常に動作することを確認してください！

#### 5. コードスタイルをチェック

```bash
# RuboCopでコードスタイルをチェック
bundle exec rubocop

# 自動修正可能な問題を修正
bundle exec rubocop -A

# セキュリティチェック
bundle exec brakeman
```

**補足**:
- RuboCopはRubyのコードスタイルをチェックするツール
- Brakemanはセキュリティ上の問題を検出するツール
- CI/CDで自動実行されるため、事前にローカルで確認しておくとスムーズです

#### 6. 変更をコミット

```bash
# 変更されたファイルを確認
git status

# すべての変更をステージング
git add .

# コミット（変更内容を記録）
git commit -m "Add: 新機能の説明"
```

**コミットメッセージの例**:
```bash
git commit -m "Add: ユーザー認証機能を追加"
git commit -m "Modify: グラフの色を青系に変更"
git commit -m "Fix: CO2計算の小数点エラーを修正"
git commit -m "Docs: READMEに開発手順を追記"
```

#### 7. GitHubにプッシュ

```bash
# リモートリポジトリにプッシュ
git push origin add/new-feature-name
```

**補足**: `-u` オプションをつけると、次回から `git push` だけでプッシュできます。
```bash
git push -u origin add/new-feature-name
```

#### 8. CI/CDが通ることを確認

1. GitHubのリポジトリページを開く
2. **「Actions」** タブをクリック
3. 最新のワークフローが **緑色のチェックマーク✓** になることを確認

**エラーが出た場合**:
- ワークフローをクリックして詳細を確認
- RuboCopエラー: `bundle exec rubocop -A` で自動修正
- その他のエラー: ログを確認して修正

#### 9. プルリクエスト（PR）を作成

1. GitHubのリポジトリページで **「Pull requests」** タブを開く
2. **「New pull request」** ボタンをクリック
3. base: `main` ← compare: `add/new-feature-name` を選択
4. タイトルと説明を記入
5. **「Create pull request」** をクリック

#### 10. レビューとマージ

- レビューを受ける（チーム開発の場合）
- 問題なければ **「Merge pull request」** をクリック
- ブランチは削除してOK（**「Delete branch」** ボタン）

### よく使うGitコマンド一覧

```bash
# 現在のブランチと変更状況を確認
git status

# ブランチ一覧を表示
git branch

# ブランチを切り替え
git checkout ブランチ名

# 新しいブランチを作成して切り替え
git checkout -b 新しいブランチ名

# 変更をステージング
git add .                  # すべての変更
git add ファイル名          # 特定のファイルのみ

# コミット
git commit -m "メッセージ"

# プッシュ
git push origin ブランチ名

# プル（最新の変更を取得）
git pull origin main

# リモートの状態を確認
git remote -v

# コミット履歴を表示
git log
git log --oneline         # 1行で表示
```

## デプロイ

### 現在の環境: Render（ステージング）

現在はRenderの無料プランでデプロイしています。

#### 自動デプロイ

`main` ブランチにマージされると、Renderが自動的にデプロイを開始します。

#### デプロイ状況の確認

1. https://dashboard.render.com にログイン
2. 「electricity-tracker」サービスを選択
3. **「Logs」** タブでビルドログを確認
4. **「Events」** タブでデプロイ履歴を確認

#### 環境変数

Renderの「Environment」セクションで設定が必要：

```
RAILS_ENV=production
RAILS_MASTER_KEY=（config/master.keyの内容）
```

### 将来の環境: AWS（本番予定）

本番環境はAWSを想定しています。

#### 想定構成

- **EC2**: Railsアプリケーションサーバー
- **RDS**: PostgreSQLデータベース
- **S3**: 静的ファイルの配信
- **CloudFront**: CDN
- **Route 53**: DNS管理
- **ALB**: ロードバランサー

#### データベース移行

本番環境ではPostgreSQLを使用する予定です。現在のメモリストレージからの移行が必要になります。

```ruby
# Gemfile に追加予定
gem 'pg' # PostgreSQL adapter
```

## トラブルシューティング

### サーバーが起動しない

**エラー**: `A server is already running`

```bash
# 原因: 前回のサーバーが正常に終了していない

# 解決方法: PIDファイルを削除
rm tmp/pids/server.pid

# サーバーを再起動
bin/rails server
```

### RuboCopエラーが発生する

```bash
# エラーを確認
bundle exec rubocop

# 自動修正を試す
bundle exec rubocop -A

# 特定のファイルのみチェック
bundle exec rubocop app/models/electricity_usage.rb
```

### Gitでコンフリクトが発生した

```bash
# 1. mainブランチの最新を取得
git checkout main
git pull origin main

# 2. 作業ブランチに戻る
git checkout your-branch-name

# 3. mainの変更をマージ
git merge main

# 4. コンフリクトを手動で解決
# （エディタでコンフリクト箇所を編集）

# 5. 解決後、コミット
git add .
git commit -m "Resolve merge conflict"
```

### ブラウザで変更が反映されない

```bash
# 原因: ブラウザのキャッシュ

# 解決方法1: スーパーリロード
# - Mac: Cmd + Shift + R
# - Windows: Ctrl + Shift + R

# 解決方法2: サーバーを再起動
# Ctrl + C でサーバーを停止
bin/rails server
```

### Bundler関連のエラー

```bash
# Gemfile.lockを削除して再インストール
rm Gemfile.lock
bundle install
```

## プロジェクト構造

```
electricity-tracker/
├── app/
│   ├── assets/           # CSS、画像などの静的ファイル
│   ├── controllers/      # コントローラ（リクエスト処理）
│   │   ├── dashboard_controller.rb
│   │   └── electricity_usages_controller.rb
│   ├── models/           # モデル（データ処理）
│   │   └── electricity_usage.rb
│   ├── views/            # ビュー（HTML表示）
│   │   ├── dashboard/
│   │   ├── layouts/
│   │   └── electricity_usages/
│   └── javascript/       # JavaScriptコード
├── config/               # 設定ファイル
│   ├── routes.rb         # ルーティング定義
│   ├── database.yml      # データベース設定
│   └── environments/     # 環境別設定
├── db/                   # データベース関連
│   └── migrate/          # マイグレーションファイル
├── bin/                  # 実行スクリプト
├── Dockerfile            # Docker設定
├── render.yaml           # Render設定
├── Gemfile               # Ruby依存関係
└── README.md             # このファイル
```

## 参考リンク

### Rails学習リソース

- [Railsガイド（日本語）](https://railsguides.jp/)
- [Ruby on Rails Tutorial](https://railstutorial.jp/)
- [Progate - Ruby on Rails](https://prog-8.com/languages/rails5)

### Git学習リソース

- [サル先生のGit入門](https://backlog.com/ja/git-tutorial/)
- [Learn Git Branching](https://learngitbranching.js.org/?locale=ja)

### その他

- [Chart.js 公式ドキュメント](https://www.chartjs.org/docs/latest/)
- [Tailwind CSS ドキュメント](https://tailwindcss.com/docs)

## ライセンス

MIT License

## 作成者・貢献

Created with Claude Code

プルリクエストを歓迎します！質問や提案がある場合は、GitHubのIssuesで気軽に相談してください。

---

**注意事項**:
- このアプリケーションはMVP（最小実行可能製品）です
- データはメモリに保存されており、サーバー再起動でリセットされます
- 本番環境への移行時はデータベース（PostgreSQL）への対応が必要です
