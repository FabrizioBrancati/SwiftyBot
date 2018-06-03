//
//  Routes.swift
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

import BFKit
import Foundation
import Vapor

/// Move this to Response.swift.

/// Registering Facebook Messenger routes.
public func routes(_ router: Router) throws {
    /// Setting up the POST request with Telegram secret key.
    /// With a secret path to be sure that nobody else knows that URL.
    /// https://core.telegram.org/bots/api#setwebhook
    router.post("telegram", telegramSecret) { httpRequest -> HTTPResponse in
        let messageRequest = try httpRequest.content.syncDecode(MessageRequest.self)

        var response = Telegram.Response(method: .sendMessage, chatID: messageRequest.message.chat.id, text: "I'm sorry but your message is empty 😢")

        if !messageRequest.message.text.isEmpty {
            if messageRequest.message.text.hasPrefix("/") {
                if let command = Command(messageRequest.message.text), command.command == "start" {
                    response.text = """
                    Welcome to SwiftyBot \(messageRequest.message.from.firstName)!
                    To list all available commands type /help
                    """
                } else if let command = Command(messageRequest.message.text), command.command == "help" {
                    response.text = """
                    Welcome to SwiftyBot, an example on how to create a Telegram bot with Swift using Vapor.
                    https://www.fabriziobrancati.com/SwiftyBot

                    /start - Welcome message
                    /help - Help message
                    Any text - Returns the reversed message
                    """
                } else {
                    response.text = """
                    Unrecognized command.
                    To list all available commands type /help
                    """
                }
            } else {
                response.text = messageRequest.message.text.reversed(preserveFormat: true)
            }
        }

        /// Create the JSON response.
        /// https://core.telegram.org/bots/api#sendmessage
        var httpResponse = HTTPResponse(status: .ok, headers: ["Content-Type": "application/json"])

        try JSONEncoder().encode(response, to: &httpResponse, on: httpRequest.eventLoop)
        return httpResponse
    }
}
