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
import BFKit
import Bot
import Messenger

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
    
    // MARK: - Messenger Bot
    
    /// Setting up the GET request with Messenger secret key.
    /// With a secret path to be sure that nobody else knows that URL.
    router.get("messenger", messengerSecret) { request -> HTTPResponse in
        /// Try decoding the request query as `Activation`.
        let activation = try request.query.decode(Activation.self)
        /// Check for "hub.mode", "hub.verify_token" & "hub.challenge" query parameters.
        guard activation.mode == "subscribe", activation.token == messengerSecret else {
            throw Abort(.badRequest, reason: "Missing Messenger verification data.")
        }
        
        /// Create a response with the challenge query parameter to verify the webhook.
        let body = try HTTPBody(data: JSONEncoder().encode(activation.challenge))
        /// Send a 200 (OK) response.
        return HTTPResponse(status: .ok, headers: ["Content-Type": "text/plain"], body: body)
    }
    
    /// Setting up the POST request with Messenger secret key.
    /// With a secret path to be sure that nobody else knows that URL.
    router.post("messenger", messengerSecret) { request -> HTTPResponse in
        /// Check that the request comes from a "page".
        let pageResponse = try request.query.decode(PageResponse.self)
        guard pageResponse.object == "page" else {
            /// Throw an abort response, with a custom message.
            throw Abort(.badRequest, reason: "Message not generated by a page.")
        }
        
        var response = Messenger.Response(messagingType: .response, message: "Unknown error.")
        
        for entry in pageResponse.entries {
            for event in entry.messages {
                if let postback = event.postback {
                    response.message = postback.payload ?? "No payload provided by developer."
                } else if let message = event.message {
                    if message.text.isEmpty {
                        response.message = "I'm sorry but your message is empty 😢"
                    } else if message.text.hasGreetings() {
                        response.message = "Hi!\nThis is an example on how to create a bot with Swift.\nIf you want to see more try to send me \"buy\", \"sell\" or \"shop\"."
                    } else if message.text.lowercased().contains("sell") || message.text.lowercased().contains("buy") || message.text.lowercased().contains("shop") {
                        var queuer = Element(title: "Queuer", subtitle: "Queuer is a queue manager, built on top of OperationQueue and Dispatch (aka GCD).", itemURL: "https://github.com/FabrizioBrancati/Queuer", imageURL: "https://github.fabriziobrancati.com/queuer/resources/queuer-banner.png")
                        queuer.add(button: Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/Queuer"))
                        queuer.add(button: Button(type: .postback, title: "Call Postback", payload: "Queuer pressed."))
                        
                        var bfkitSwift = Element(title: "BFKit-Swift", subtitle: "BFKit-Swift is a collection of useful classes, structs and extensions to develop Apps faster.", itemURL: "https://github.com/FabrizioBrancati/BFKit-Swift", imageURL: "https://github.fabriziobrancati.com/bfkit/resources/banner-swift-new.png")
                        bfkitSwift.add(button: Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/BFKit-Swift"))
                        bfkitSwift.add(button: Button(type: .postback, title: "Call Postback", payload: "BFKit-Swift pressed."))
                        
                        var bfkit = Element(title: "BFKit-Swift", subtitle: "BFKit is a collection of useful classes and categories to develop Apps faster.", itemURL: "https://github.com/FabrizioBrancati/BFKit", imageURL: "https://github.fabriziobrancati.com/bfkit/resources/banner-objc.png")
                        bfkit.add(button: Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/BFKit"))
                        bfkit.add(button: Button(type: .postback, title: "Call Postback", payload: "BFKit pressed."))
                        
                        var swiftyBot = Element(title: "BFKit-Swift", subtitle: "How to create a Telegram & Messenger bot with Swift using Vapor on Ubuntu / macOS", itemURL: "https://github.com/FabrizioBrancati/BFKit", imageURL: "https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner-new.png")
                        swiftyBot.add(button: Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/SwiftyBot"))
                        swiftyBot.add(button: Button(type: .postback, title: "Call Postback", payload: "SwiftyBot pressed."))
                    } else {
                        response.message = message.text.reversed(preserveFormat: true)
                    }
                } else if event.message == nil {
                    response.message = "Webhook received unknown event."
                }
                
                _ = try request.client().post("https://graph.facebook.com/v3.0/me/messages?access_token=\(messengerToken)", headers: ["Content-Type": "application/json"]) { messageRequest in
                    response.recipient = Recipient(id: event.sender.id)
                    
                    try messageRequest.content.encode(response)
                }
            }
        }
        
        /// Sending an HTTP 200 OK response is required.
        /// https://developers.facebook.com/docs/messenger-platform/webhook-reference#response
        return HTTPResponse(status: .ok, headers: ["Content-Type": "application/json"])
    }
}
