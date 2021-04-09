# Roku Basics Example Project

This is a Roku project that is used as an example for teaching about Roku Development

The base project was taken from https://github.com/rokucommunity/brighterscript-template, and additional changes were added to exemplify the ways REDspace generally do Roku projects.

## Setup instructions

1. Install npm dependencies (For node-based BSC tools)
   ```bash
   npm install
   ```
2. Install ruby dependencies (for Roku_builder tools)
   ```bash
   bundler
   ```

## Usage

### Running from VSCode

1. Install [BrightScript Language](https://github.com/rokucommunity/vscode-brightscript-language) extension

2. Run `BrightScriptDebug: Launch`

3. Or, create a `.env` file in the format:

```env
ROKU_HOST=<IP Address of Roku>
ROKU_PASSWORD=<Developer password>
```

and run `BrightScriptDebug: Launch From ENV`

## Running from Roku_builder CLI

1. Create the `~/.roku_config.json` file. See: https://github.com/ViacomInc/roku_builder/wiki/Configuration#project-configuration

2. Run

```bash
cd ./src
roku -lc
```

## Debugging

This repository comes pre-configured to work with the [BrightScript Language](https://github.com/rokucommunity/vscode-brightscript-language) extension for Visual Studio Code. So once you have that plugin installed, debugging your project is as simple as clicking the "Start Debugging" button.
