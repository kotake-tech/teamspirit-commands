#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title TeamSpirit
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "in/out" }

# 引数チェック
if [[ "$1" != "in" && "$1" != "out" ]]; then
    echo "Usage: $0 [in|out]"
    exit 1
fi

# チームID # ブラウザ版Slackで開いたときのURL https://app.slack.com/client/xxxxxxxx[/yyyyyyyy] のxxxxxxxx部分
TEAM_ID="XXXXXXXXXX"

# 送信先チャンネルID # メッセージなどのリンク https://geniee.slack.com/archives/xxxxxxxx[/yyyyyyyy] のxxxxxxxx部分

CHANNEL_ID="XXXXXXXXXX"

# 実行したいコマンド
SLACK_COMMAND="/teamspirit_$1"

# コマンドをコピー
echo -n "$SLACK_COMMAND" | pbcopy

# 指定したチャンネルを前面で開く
open "slack://channel?team=${TEAM_ID}&id=${CHANNEL_ID}&tab=messages"

# Slackが読み込まれるのを少し待つ
sleep 0.5

# コマンドを入力して送信
osascript <<EOT
tell application "System Events"
    keystroke "v" using command down
    delay 0.5
    keystroke return
    delay 0.5
    keystroke return using command down
end tell
EOT
