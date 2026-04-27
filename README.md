# teamspirit-commands

ターミナルまたは Raycast から AppleScript を使って Slack の `/teamspirit_in` / `/teamspirit_out` コマンドを送信します。

## 前提条件

- macOS
- Slack デスクトップアプリがインストール済みかつ起動中であること
- TeamSpirit Slack アプリがワークスペースにインストール済みであること

## セットアップ

1. このリポジトリをクローンする
   ```sh
   git clone https://github.com/kotake-tech/teamspirit-commands.git
   cd teamspirit-commands
   ```
2. `.env` を作成して設定値を更新する
   ```sh
   cp .env.example .env
   ```
   - `TEAM_ID`: Slack のワークスペースの ID
     - ブラウザで https://geniee.slack.com/ を開いてログインしたときの `https://app.slack.com/client/xxxxxxxx[/yyyyyyyy]` の `xxxxxxxx` 部分
   - `CHANNEL_ID`: Slack の送信先チャンネルの ID
     - Slack 画面右上の「︙」をクリック → 「チャンネル/アプリの詳細を開く」をクリック → 最下部にある「チャンネルID」をコピー
   - `TS_IN_CUTOFF_TIME`: 遅すぎる出勤打刻時に確認ダイアログを出す時間のしきい値（例: `1600`）
   - `TS_OUT_CUTOFF_TIME`: 早すぎる退勤打刻時に確認ダイアログを出す時間のしきい値（例: `1900`）

## 使い方

### Raycast から実行する場合

1. クローンしたリポジトリのディレクトリを Raycast のスクリプトディレクトリに追加する
   1. Raycast の拡張機能設定を開く
      - Raycast ランチャーを開き、`Extensions` を検索する
   2. `+` ボタンを押す
   3. `Add Script Directory` を検索して選択する
   4. クローンしたリポジトリのディレクトリを選択する
2. Raycast のスクリプトディレクトリをリロードする
   - Raycast ランチャーを開き、`Reload Script Directories` を検索する
3. （任意）エイリアスを設定する（例）
   - `TeamSpirit` → `ts`
   - `TeamSpirit in` → `tsin`
   - `TeamSpirit out` → `tsout`
4. Raycast ランチャーを開いてコマンドを実行する
   - `TeamSpirit`：コマンドライン引数に応じて `/teamspirit_in` または `/teamspirit_out` を送信する
   - `TeamSpirit in`：`/teamspirit_in` を送信する
   - `TeamSpirit out`：`/teamspirit_out` を送信する

### ターミナルから実行する場合

1. 実行権限を付与する
   ```sh
   chmod +x ts*
   ```
2. コマンドを実行する
   - `./ts`：コマンドライン引数に応じて `/teamspirit_in` または `/teamspirit_out` を送信する
   - `./tsin`：`/teamspirit_in` を送信する
   - `./tsout`：`/teamspirit_out` を送信する
