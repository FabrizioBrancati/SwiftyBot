//
//  routes.swift
//  SwiftyBot
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 - 2018 Fabrizio Brancati.
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

import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // MARK: - Telegram Bot
    
    /// Setting up the POST request with Telegram secret key.
    /// With a secret path to be sure that nobody else knows that URL.
    /// https://core.telegram.org/bots/api#setwebhook
    //    router.post(telegramSecret, at: "telegram") { request, data in
    //        /// Let's prepare the response message text.
    //        var response: String = ""
    //
    //        /// Chat ID from request JSON.
    //        let chatID: Int = request.data["message", "chat", "id"]?.int ?? 0
    //        /// Message text from request JSON.
    //        let message: String = request.data["message", "text"]?.string ?? ""
    //        /// User first name from request JSON.
    //        let userFirstName: String = request.data["message", "from", "first_name"]?.string ?? ""
    //
    //        /// Check if the message is empty.
    //        if message.isEmpty {
    //            /// Set the response message text.
    //            response = "I'm sorry but your message is empty 😢"
    //            /// The message is not empty.
    //        } else {
    //            /// Check if the message is a Telegram command.
    //            if message.hasPrefix("/") {
    //                /// Check what type of command is.
    //                switch message {
    //                /// Start command "/start".
    //                case "/start":
    //                    /// Set the response message text.
    //                    response = "Welcome to SwiftyBot " + userFirstName + "!\n" +
    //                    "To list all available commands type /help"
    //                /// Help command "/help".
    //                case "/help":
    //                    /// Set the response message text.
    //                    response = "Welcome to SwiftyBot " +
    //                        "an example on how to create a Telegram bot with Swift using Vapor.\n" +
    //                        "https://www.fabriziobrancati.com/SwiftyBot\n\n" +
    //                        "/start - Welcome message\n" +
    //                        "/help - Help message\n" +
    //                    "Any text - Returns the reversed message"
    //                /// Command not valid.
    //                default:
    //                    /// Set the response message text and suggest to type "/help".
    //                    response = "Unrecognized command.\n" +
    //                    "To list all available commands type /help"
    //                }
    //                /// It is not a Telegram command, so create a reversed message text.
    //            } else {
    //                /// Set the response message text.
    //                response = message.reversed(preserveFormat: true)
    //            }
    //        }
    //
    //        /// Create the JSON response.
    //        /// https://core.telegram.org/bots/api#sendmessage
    //        return try JSON(node: [
    //            "method": "sendMessage",
    //            "chat_id": chatID,
    //            "text": response
    //            ]
    //        )
    //    }
}
