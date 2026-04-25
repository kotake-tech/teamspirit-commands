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

if [[ "$1" == "out" ]]; then
    current_time=$(date +%H%M)
    cutoff_time=1900

    if (( current_time < cutoff_time )); then
        confirmation_message="まだ19:00になっていません。本当に退勤打刻しますか？"
        selected_button=$(osascript <<EOT
try
    button returned of (display dialog "$confirmation_message" with title "TeamSpirit" buttons {"Cancel", "OK"} default button "Cancel")
on error number -128
    return "Cancel"
end try
EOT
)
        if [[ "$selected_button" != "OK" ]]; then
            echo "Canceled: ts out was not sent."
            exit 0
        fi
    fi
elif [[ "$1" == "in" ]]; then
    current_time=$(date +%H%M)
    cutoff_time=1600

    if (( current_time >= cutoff_time )); then
        confirmation_message="16:00を過ぎています。本当に出勤打刻しますか？"
        selected_button=$(osascript <<EOT
try
    button returned of (display dialog "$confirmation_message" with title "TeamSpirit" buttons {"Cancel", "OK"} default button "Cancel")
on error number -128
    return "Cancel"
end try
EOT
)
        if [[ "$selected_button" != "OK" ]]; then
            echo "Canceled: ts in was not sent."
            exit 0
        fi
    fi
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
