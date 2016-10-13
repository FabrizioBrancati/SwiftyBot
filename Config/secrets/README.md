<p align="center"><img src="https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner.png" alt="SwiftyBot Banner"></p>

[![Build Status](https://travis-ci.org/FabrizioBrancati/SwiftyBot.svg?branch=master)](https://travis-ci.org/FabrizioBrancati/SwiftyBot)
[![Codebeat Badge](https://codebeat.co/badges/)](https://codebeat.co/projects/github-com-fabriziobrancati-swiftybot)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://developer.apple.com/swift/)
[![Language](https://img.shields.io/badge/language-Swift%203.0-orange.svg)](https://developer.apple.com/swift/)
[![Platform](https://img.shields.io/badge/platform-Linux%20/%20macOS-ffc713.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/FabrizioBrancati/SwiftyBot/blob/master/LICENSE)

---

<p align="center">
    <a href="#what-is-that-folder">What is that folder?</a> &bull;
    <a href="#why-it-is-empty">Why it is empty?</a>
</p>

---

What is that folder?
===================
Inside this folder you need to create an *app.json* file.<br>
In this JSON file you have to write your secret key to be set in the Telegram Webhook URL.<br>
This is the file format:

```json
{
    "secret": "XXXXXXXXXXXXXX"
}
```

Why it is empty?
================
For security reason I can't commit my *app.json* file.<br>
So for now you have to create it by your self.<br>

P.S.: If you want you can use an environment variable and use it with something like `$SECRET`. I prefer to use a JSON file instead.
