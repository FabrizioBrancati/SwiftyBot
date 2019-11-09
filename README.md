<p align="center">
<img src="Resources/Banner.png" alt="SwiftyBot Banner">
</p>

[![Build Status](https://travis-ci.com/FabrizioBrancati/SwiftyBot.svg?branch=master)](https://travis-ci.org/FabrizioBrancati/SwiftyBot)
[![Coverage Status](https://codecov.io/gh/FabrizioBrancati/SwiftyBot/branch/master/graph/badge.svg)](https://codecov.io/gh/FabrizioBrancati/SwiftyBot)
[![Maintainability](https://api.codeclimate.com/v1/badges/4e5f16144afda5c8ae36/maintainability)](https://codeclimate.com/github/FabrizioBrancati/SwiftyBot/maintainability)
[![Codebeat Badge](https://codebeat.co/badges/ff777248-e375-4c6d-8a77-4475c2bc9ae1)](https://codebeat.co/projects/github-com-fabriziobrancati-swiftybot-master)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e71d428e5a9e493d966de02608e6e110)](https://www.codacy.com/manual/FabrizioBrancati/SwiftyBot)
<br>
[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](https://developer.apple.com/swift/)
[![Language](https://img.shields.io/badge/language-Swift%205.1-orange.svg)](https://developer.apple.com/swift/)
[![Platforms](https://img.shields.io/badge/platform-Linux%20/%20macOS-cc9c00.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)

---

<p align="center">
    <a href="#features">Features</a> &bull;
    <a href="#platforms-and-tutorials">Platforms and Tutorials</a> &bull;
    <a href="#language-support">Language Support</a> &bull;
    <a href="#requirements">Requirements</a> &bull;
    <a href="#communication">Communication</a> &bull;
    <a href="#contributing">Contributing</a> &bull;
    <a href="#installing-and-usage">Installing and Usage</a> &bull;
    <a href="#documentation">Documentation</a> &bull;
    <a href="#changelog">Changelog</a> &bull;
    <a href="#demos">Demos</a> &bull;
    <a href="#authors">Authors</a> &bull;
    <a href="#license">License</a>
</p>

---

Features
========

SwiftyBot is an example of how to create a bot with [Swift](https://swift.org/) on top of [Vapor](https://github.com/vapor/vapor).

Here is the list of all the features:
- [x] Telegram bot integration
- [x] Facebook Messenger bot integration
- [x] Google Assistant bot integration
- [x] Well documented (you can find more in [Documentation](https://github.com/FabrizioBrancati/SwiftyBot#documentation) section)
- [x] Well tested (currently 99% of code coverage)
- [x] Clean (every bot platform has its folder with its files and tests)
- [x] Easy to follow (every bot platform comes with a tutorial, more in [Platforms and Tutorials](https://github.com/FabrizioBrancati/SwiftyBot#platforms-and-tutorials) section)
- [x] Multi language support

> There are a lot of bot platforms out there that can be added...

Platforms and Tutorials
=======================

| **Bot Platform**   | **Blog Post Link** |
|--------------------|--------------------|
| Telegram           | _[How to create a Telegram bot with Swift using Vapor on Ubuntu / macOS](https://www.fabriziobrancati.com/SwiftyBot)_ |
| Facebook Messenger | _[How to create a Facebook Messenger bot with Swift](https://www.fabriziobrancati.com/SwiftyBot-2)_ |
| Google Assistant   | _[???](https://www.fabriziobrancati.com/SwiftyBot-3)_ |

Language Support
================

- English (en)

Requirements
============

- Ubuntu 14.04 or later with Swift 5.1 or later / macOS with Xcode 11.2 or later
- Telegram account and a Telegram app for any platform (Telegram bot only)
- Facebook account and a Facebook Messenger app for any platform (Facebook Messenger bot only)
- Google account and a Google Assistant app for any platform (Google Assistant bot only)

Communication
=============

- If you need help, open an issue.
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, see [Contributing](https://github.com/FabrizioBrancati/SwiftyBot#contributing) section.

Contributing
============

See [CONTRIBUTING.md](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/.github/CONTRIBUTING.md) file.

Installing and Usage
====================

## Private Server
1. Install Swift on your computer / server
2. Install [Vapor Toolbox](https://github.com/vapor/toolbox) (Optional)
3. Enable TLS (You can use [Let's Encrypt](https://letsencrypt.org))
4. Use Apache or nginx as reverse proxy
5. Use Supervisor to ensure your bot is always up and running

If you need more help through this steps, you can read [How to create a Facebook Messenger bot with Swift](https://www.fabriziobrancati.com/SwiftyBot-2) blog post, from [Step 1](https://www.fabriziobrancati.com/SwiftyBot-2#step-1) to [Step 4](https://www.fabriziobrancati.com/SwiftyBot-2#step-4).

## Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

1. Click the button above
2. Go to the _Settings_ section of your application
3. Click on the _Reveal Config Vars_ button in _Config Vars_ section
4. Copy all the created secret key set to up the bots, read the next sections for more info

If you need more help through this steps, you can read [???](https://www.fabriziobrancati.com/SwiftyBot-3) blog post.

## Vapor Cloud
1. Create an account on [Vapor Cloud](https://dashboard.vapor.cloud)
2. Create an organization
3. Create a project
4. Create an application
5. Add an hosting service and connect it to your GitHub repository
6. Add at least 1 environment, 2 is better
7. Use the [Vapor Toolbox](https://github.com/vapor/toolbox) to deploy your bot

If you need more help through this steps, you can read [???](https://www.fabriziobrancati.com/SwiftyBot-3) blog post.

## Telegram
1. Set a secret key in `TELEGRAM_SECRET` environment variable
2. Create a Telegram bot with [BotFather](https://telegram.me/botfather)

If you need more help through this steps, you can read [How to create a Telegram bot with Swift using Vapor on Ubuntu / macOS](https://www.fabriziobrancati.com/SwiftyBot) blog post.

## Facebook Messenger
1. Set a secret key in `MESSENGER_SECRET` environment variable
2. Create a Facebook app and Page
3. Get a Page access token and set it in `MESSENGER_TOKEN` environment variable

If you need more help through this steps, you can read [How to create a Facebook Messenger bot with Swift](https://www.fabriziobrancati.com/SwiftyBot-2) blog post.

## Google Assistant
1. Set a secret key in `ASSISTANT_SECRET` environment variable
2. Create an Actions on Google project
3. Setup Actions on Google project on Dialogflow

If you need more help through this steps, you can read [???](https://www.fabriziobrancati.com/SwiftyBot-3) blog post.

Documentation
=============

### Bot
- Every line of every project file is commented.
- If you need Vapor documentation you can find it [here](https://docs.vapor.codes/).

### Platforms
- If you need Telegram bot documentation you can find it [here](https://core.telegram.org/bots/api).
- If you need Facebook Messenger bot documentation you can find it [here](https://developers.facebook.com/docs/messenger-platform).
- If you need Google Assistant bot documentation you can find it [here](https://developers.google.com/actions/extending-the-assistant) and [here](https://dialogflow.com/docs). You can also find some JSON examples [here](https://developers.google.com/actions/conversation-api-playground) and [here](https://github.com/dialogflow/fulfillment-webhook-json).

Changelog
=========

To see what has changed in recent version of SwiftyBot, see the **[CHANGELOG.md](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/CHANGELOG.md)** file.

Demos
=====

### Telegram
You can open Telegram and search for **[SwiftyBot](https://telegram.me/SwiftyBot)** to start talking with him!

### Facebook Messenger
You can open Facebook Messenger and search for **[SwiftyBotMessenger](http://m.me/SwiftyBotMessenger)** to start talking with him!

### Google Assistant
You can open Google Assistant and write **[Talk to SwiftyBot](https://assistant.google.com/services/invoke/uid/000000d447b4593f)** to start talking with him!

Authors
=======

### Bot
**Fabrizio Brancati**

[https://www.fabriziobrancati.com](https://www.fabriziobrancati.com) - [fabrizio.brancati@gmail.com](mailto:fabrizio.brancati@gmail.com)

### Icon
**Roberto Chiaveri**

[http://robertochiaveri.it](http://robertochiaveri.it)

License
=======

SwiftyBot is available under the MIT license. See the **[LICENSE](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)** file for more info.
