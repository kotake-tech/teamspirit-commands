#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title TeamSpirit
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "in/out" }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ENV_FILE="${SCRIPT_DIR}/.env"

if [[ ! -f "$ENV_FILE" ]]; then
    echo "Error: ${ENV_FILE} not found. Copy .env.example to .env and update the values."
    exit 1
fi

set -a
source "$ENV_FILE"
set +a

required_vars=("TEAM_ID" "CHANNEL_ID" "TS_IN_CUTOFF_TIME" "TS_OUT_CUTOFF_TIME")
for var_name in "${required_vars[@]}"; do
    if [[ -z "${!var_name}" ]]; then
        echo "Error: ${var_name} is not set in ${ENV_FILE}."
        exit 1
    fi
done

format_time() {
    local raw_time="$1"
    echo "${raw_time:0:2}:${raw_time:2:2}"
}

# 引数チェック
if [[ "$1" != "in" && "$1" != "out" ]]; then
    echo "Usage: $0 [in|out]"
    exit 1
fi

if [[ "$1" == "out" ]]; then
    current_time=$(date +%H%M)
    cutoff_time=$TS_OUT_CUTOFF_TIME

    if (( current_time < cutoff_time )); then
        confirmation_message="まだ$(format_time "$cutoff_time")になっていません。本当に退勤打刻しますか？"
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
    cutoff_time=$TS_IN_CUTOFF_TIME

    if (( current_time >= cutoff_time )); then
        confirmation_message="$(format_time "$cutoff_time")を過ぎています。本当に出勤打刻しますか？"
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
