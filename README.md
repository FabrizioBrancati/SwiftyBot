<p align="center"><img src="https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner-new.png" alt="SwiftyBot Banner"></p>

[![Build Status](https://travis-ci.org/FabrizioBrancati/SwiftyBot.svg?branch=master)](https://travis-ci.org/FabrizioBrancati/SwiftyBot)
[![codecov](https://codecov.io/gh/FabrizioBrancati/SwiftyBot/branch/master/graph/badge.svg)](https://codecov.io/gh/FabrizioBrancati/SwiftyBot)
[![codebeat badge](https://codebeat.co/badges/ff777248-e375-4c6d-8a77-4475c2bc9ae1)](https://codebeat.co/projects/github-com-fabriziobrancati-swiftybot-master)
[![Version](https://img.shields.io/badge/version-3.0.0-blue.svg)](https://developer.apple.com/swift/)
[![Language](https://img.shields.io/badge/language-Swift%204.1-orange.svg)](https://developer.apple.com/swift/)
[![Platform](https://img.shields.io/badge/platform-Linux%20/%20macOS-ffc713.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)

---

<p align="center">
    <a href="#what-does-it-do">What does it do</a> &bull;
    <a href="#compatibility">Compatibility</a> &bull;
    <a href="#language-support">Language support</a> &bull;
    <a href="#requirements">Requirements</a> &bull;
    <a href="#communication">Communication</a> &bull;
    <a href="#contributing">Contributing</a> &bull;
    <a href="#installing-and-usage">Installing and Usage</a> &bull;
    <a href="#documentation">Documentation</a> &bull;
    <a href="#changelog">Changelog</a> &bull;
    <a href="#demo">Demo</a> &bull;
    <a href="#todo">Todo</a> &bull;
    <a href="#author">Author</a> &bull;
    <a href="#license">License</a>
</p>

---

What does it do
===============

SwiftyBot is an example of how to create a Telegram & Facebook Messenger bot with Swift using Vapor.<br>
See [Compatibility](https://github.com/FabrizioBrancati/SwiftyBot#compatibility) section to check service and version it supports, you can also see its blog post with the link in that table.

Compatibility
=============

| **Bot Type** | **Version** | **Blog Post Link** |
|--------------|-------------|--------------------|
| Telegram | 1.0...1.2   | _[How to create a Telegram bot with Swift using Vapor on Ubuntu / macOS](https://www.fabriziobrancati.com/SwiftyBot)_ |
| Facebook Messenger | 2.0...2.3 | _[How to create a Facebook Messenger bot with Swift](https://www.fabriziobrancati.com/SwiftyBot-2)_ |
| ??? | 3.0 | _[???](https://www.fabriziobrancati.com/SwiftyBot-3)_ |

Language support
================

- English (en)

Requirements
============

- Ubuntu 14.04 or later with Swift 4.1 or later / macOS with Xcode 9.3 or later
- Telegram account and a Telegram App for any platform (Telegram bot only)
- Facebook account and a Facebook Messenger App for any platform (Facebook Messenger bot only)

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

### Telegram
- Install Swift on your computer / server
- Install [Vapor Toolbox](https://github.com/vapor/toolbox) (Optional)
- Set a secret key in `TELEGRAM_SECRET` environment variable
- Enable TLS (You can use [Let's Encrypt](https://letsencrypt.org))
- Use Apache or nginx as reverse proxy
- Create a Telegram bot with [BotFather](https://telegram.me/botfather)
- Use Supervisor to ensure your bot is always up and running

If you need more help through this steps, you can read _[How to create a Telegram bot with Swift using Vapor on Ubuntu / macOS](https://www.fabriziobrancati.com/SwiftyBot)_ blog post.

### Facebook Messenger
- Install Swift on your computer / server
- Install [Vapor Toolbox](https://github.com/vapor/toolbox) (Optional)
- Set a secret key in `MESSENGER_SECRET` environment variable
- Enable TLS (You can use [Let's Encrypt](https://letsencrypt.org))
- Use Apache or nginx as reverse proxy
- Create a Facebook App and Page
- Get a Page access token and set it in `MESSENGER_TOKEN` environment variable
- Use Supervisor to ensure your bot is always up and running

If you need more help through this steps, you can read _[How to create a Facebook Messenger bot with Swift](https://www.fabriziobrancati.com/SwiftyBot-2)_ blog post.

Documentation
=============

Every line of the project file are commented.<br>
If you need Vapor documentation you can find it [here](https://docs.vapor.codes/).<br>
If you need Telegram bot documentation you can find it [here](https://core.telegram.org/bots/api).<br>
If you need Facebook Messenger bot documentation you can find it [here](https://developers.facebook.com/docs/messenger-platform).

Changelog
=========

To see what has changed in recent version of SwiftyBot, see the **[CHANGELOG.md](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/CHANGELOG.md)** file.

Demo
====

### Telegram
You can open Telegram and search for **[SwiftyBot](https://telegram.me/SwiftyBot)** and start talking with him!

### Facebook Messenger
You can open Facebook and search for **[SwiftyBotMessenger](http://m.me/SwiftyBotMessenger)** and start talking with him!

Todo
====

- [x] Add Telegram support
- [x] Add Facebook Messenger support
- [ ] Add tests
- [ ] Add code coverage reports

Author
======

**Fabrizio Brancati**

[Website: https://www.fabriziobrancati.com](https://www.fabriziobrancati.com)
<br>
[Email: fabrizio.brancati@gmail.com](mailto:fabrizio.brancati@gmail.com)

Icon
====
**Roberto Chiaveri**

[Website: http://robertochiaveri.it](http://robertochiaveri.it)

License
=======

SwiftyBot is available under the MIT license. See the **[LICENSE](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)** file for more info.
