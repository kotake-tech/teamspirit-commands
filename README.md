# teamspirit-commands

ターミナルまたは Raycast から AppleScript を使って Slack の `/teamspirit_in` / `/teamspirit_out` コマンドを送信します。

## 前提条件

- macOS
- Slack デスクトップアプリがインストール済みかつ起動中であること
- TeamSpirit Slack アプリがワークスペースにインストール済みであること

## 使い方

### Raycast から実行する場合

1. このリポジトリをクローンする
   ```sh
   git clone https://github.com/kotake-tech/teamspirit-commands.git
   ```
2. `.env`を作成して設定値を更新する
   ```sh
   cp .env.example .env
   ```
   - `TEAM_ID`: SlackのワークスペースのID
     - ブラウザ版Slackで開いたときのURL `https://app.slack.com/client/xxxxxxxx[/yyyyyyyy]`の`xxxxxxxx`部分
   - `CHANNEL_ID`: Slackの送信先チャンネルのID
     - Slack画面右上の「︙」をクリック→「チャンネル/アプリの詳細を開く」をクリック→最下部にある「チャンネルID」をコピー
   - `TS_IN_CUTOFF_TIME`: 出勤打刻時に確認ダイアログを出すしきい値（例: `1600`）
   - `TS_OUT_CUTOFF_TIME`: 退勤打刻時に確認ダイアログを出すしきい値（例: `1900`）
3. クローンしたリポジトリのディレクトリを Raycast のスクリプトディレクトリに追加する
   1. Raycast の拡張機能設定を開く
      - Raycast ランチャーを開き、`Extensions` を検索する
   2. `+` ボタンを押す
   3. `Add Script Directory` を検索して選択する
   4. クローンしたリポジトリのディレクトリを選択する
4. Raycast のスクリプトディレクトリをリロードする
   - Raycast ランチャーを開き、`Reload Script Directories` を検索する
5. （任意）エイリアスを設定する（例）
   - `TeamSpirit` → `ts`
   - `TeamSpirit in` → `tsin`
   - `TeamSpirit out` → `tsout`
6. Raycast ランチャーを開いてコマンドを実行する
   - `TeamSpirit`：コマンドライン引数に応じて `/teamspirit_in` または `/teamspirit_out` を送信する
   - `TeamSpirit in`：`/teamspirit_in` を送信する
   - `TeamSpirit out`：`/teamspirit_out` を送信する

### ターミナルから実行する場合

1. このリポジトリをクローンする
   ```sh
   git clone https://github.com/kotake-tech/teamspirit-commands.git
   ```
2. `.env` を作成して設定値を更新する
   ```sh
   cp .env.example .env
   ```
3. 実行権限を付与する
   ```sh
   chmod +x ts*
   ```
4. コマンドを実行する
   - `./ts`：コマンドライン引数に応じて `/teamspirit_in` または `/teamspirit_out` を送信する
   - `./tsin`：`/teamspirit_in` を送信する
   - `./tsout`：`/teamspirit_out` を送信する
