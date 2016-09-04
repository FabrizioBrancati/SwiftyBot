//
//  main.swift
//  SwiftyBot
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

/// Import Vapor.
import Vapor

/// Create the Droplet.
let drop = Droplet()

/// Read the secret key from Config/secrets/app.json.
let secret = drop.config["app", "secret"].string ?? ""

/// Setting up the POST request with the secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// https://core.telegram.org/bots/api#setwebhook
drop.post(secret) { request in
    /// The chat ID from the request JSON.
    let chatID = request.data["message", "chat", "id"].int ?? 0
    /// The message text from the request JSON.
    let message = request.data["message", "text"].string ?? ""

    /// Let's prepare the response message text.
    var response: String = ""

    /// Check if the message is not empty
    if !message.characters.isEmpty {
        /// Check if the message is a Telegram command.
        if message.hasPrefix("/") {
            /// Check what type of command is.
            switch message {
            /// Start command "/start".
            case "/start":
                /// Set the response message text.
                response = "Welcome to SwiftyBot!\n" +
                           "To list all available commands type /help"
            /// Help command "/help".
            case "/help":
                /// Set the response message text.
                response = "Welcome to SwiftyBot " +
                           "an example on how create a Telegram Bot with Swift using Vapor.\n" +
                           "https://www.fabriziobrancati.com/blog\n\n" +
                           "/start - Welcome message\n" +
                           "/help - Help message\n" +
                           "Any text - Returns the reversed message"
            /// Command not valid.
            default:
                /// Set the response message text and suggest to type "/help".
                response = "Unrecognized command.\n" +
                           "To list all available commands type /help"
            }
        /// It isn't a Telegram command, so creates a reversed message text.
        } else {
            /// Set the response message text.
            response = message.reversed(preserveFormat: true)
        }
    /// The message is empty
    } else {
        /// Set the response message text.
        response = "How did you get here? 😨"
    }

    /// Create the JSON response.
    /// https://core.telegram.org/bots/api#sendmessage
    return try JSON(
        [
            "method": "sendMessage",
            "chat_id": chatID,
            "text": response
        ]
    )
}

/// Serve the Droplet.
drop.serve()
