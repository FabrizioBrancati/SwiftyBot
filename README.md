<p align="center"><img src="https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner.png" alt="SwiftyBot Banner"></p>

[![Build Status](https://travis-ci.org/FabrizioBrancati/SwiftyBot.svg?branch=master)](https://travis-ci.org/FabrizioBrancati/SwiftyBot)
[![Codebeat Badge](https://codebeat.co/badges/5c994b12-c55e-46ec-b870-1c42154289a3)](https://codebeat.co/projects/github-com-fabriziobrancati-swiftybot)
[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://developer.apple.com/swift/)
[![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)](https://developer.apple.com/swift/)
[![Platform](https://img.shields.io/badge/platform-Linux%20/%20macOS-ffc713.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)

---

<p align="center">
    <a href="#what-does-it-do">What does it do</a> &bull;
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
SwiftyBot is an example on how to create a Telegram bot with Swift using Vapor.<br>
Read more about it at _[How to create a Telegram bot with Swift using Vapor on Ubuntu / macOS](https://www.fabriziobrancati.com/SwiftyBot)_.

Language support
================
- English (en)

Requirements
============
- Ubuntu 14.04 or later with Swift 3.0.1 / macOS with Xcode 8.1 or 8.2
- Telegram account and a Telegram App for any platform

Communication
=============
- If you need help, use Stack Overflow.
- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, see [Contributing](https://github.com/FabrizioBrancati/SwiftyBot#contributing) section.

Contributing
============
See [CONTRIBUTING.md](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/.github/CONTRIBUTING.md) file.

Installing and Usage
====================
#### Linux / macOS
- Install Swift on your computer / server
- Install [Vapor Toolbox](https://github.com/vapor/toolbox) (Optional)
- Set a secret key in `secrets/app.json`
- Enable TLS (You can use [Let's Encrypt](https://letsencrypt.org))
- Use Apache or nginx as a reverse proxy
- Create a Telegram bot with [BotFather](https://telegram.me/botfather)
- Use Supervisor to ensure your bot is always running

If you need more help through this steps you can check _[How to create a Telegram bot with Swift using Vapor on Ubuntu / macOS](https://www.fabriziobrancati.com/SwiftyBot)_ blog post.

Documentation
=============
Every line of [main.swift](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/Sources/SwiftyBot/main.swift) file is commented.<br>
If you need Vapor documentation you can find it [here](https://vapor.github.io/documentation/).

Changelog
=========
To see what has changed in recent version of SwiftyBot, see the **[CHANGELOG.md](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/CHANGELOG.md)** file.

Demo
====
You can open Telegram and search for **[SwiftyBot](https://telegram.me/SwiftyBot)** and start talking with him!

Todo
====
- [ ] Add more functions and commands
- [ ] Add support for combined emoji on Linux
- [ ] Add support for edited messages
- [ ] Add support for images
- [ ] Use a database to define a user state (Example: `reverse`, `uppercase`, `lowercase`, etc...)
- [x] Include [BFKit-Swift](https://github.com/FabrizioBrancati/SwiftyBot) dependency instead of a single file like [String+BFKit.swift](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/Sources/SwiftyBot/String%2BBFKit.swift)

Author
======
**Fabrizio Brancati**

[Website: https://www.fabriziobrancati.com](https://www.fabriziobrancati.com)
<br>
[Email: fabrizio.brancati@gmail.com](mailto:fabrizio.brancati@gmail.com)

License
=======
SwiftyBot is available under the MIT license. See the **[LICENSE](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)** file for more info.
