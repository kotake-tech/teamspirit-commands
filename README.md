# teamspirit-commands

Send Slack `/teamspirit_in` / `/teamspirit_out` command from terminal or Raycast using AppleScript.

## Prerequisites

- macOS
- Slack desktop app installed and started
- TeamSpirit Slack App installed in the Slack workspace

## Usage

### Running from Raycast

1. Clone this repo
   ```sh
   git clone https://github.com/kotake-tech/teamspirit-commands.git
   ```
2. Update the `TEAM_ID` and `CHANNEL_ID` in [`ts.sh`](./ts.sh)
3. Add the cloned repo directry to Raycast script directory
   1. Open Raycast Extension settings
      - Open Raycast launcher and searh for `Extensions`
   2. Press `+` button
   3. Search for `Add Script Directory` and select it
   4. Select the cloned repo directory
4. Reload Raycast script directory
   - Open Raycast launcher and searh for `Reload Script Directories`
5. (Optional) Set aliases, for example
   - `TeanSirit` -> `ts`
   - `TeanSirit in` -> `tsin`
   - `TeanSirit out` -> `tsout`
6. Open Raycast launcher and run the command
   - `TeamSpirit`: Sends `/teamspirit_in` or `/teamspirit_out` according to the commandline argument
   - `TeamSpirit in`: Sends `/teamspirit_in`
   - `TeamSpirit out`: Sends `/teamspirit_out`

### Running from Terminal

1. Clone this repo
   ```sh
   git clone https://github.com/kotake-tech/teamspirit-commands.git
   ```
2. Update the `TEAM_ID` and `CHANNEL_ID` in [`ts.sh`](./ts.sh)
3. Grant permissions
   ```sh
   chmod +x ts*
   ```
4. Run the commands
   - `./ts`: Sends `/teamspirit_in` or `/teamspirit_out` according to the commandline argument
   - `./tsin`: Sends `/teamspirit_in`
   - `./tsout`: Sends `/teamspirit_out`
