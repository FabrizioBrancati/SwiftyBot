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

/// Import Vapor & BFKit frameworks.
import Vapor
import HTTP
import BFKit

/// Bot errors enum.
enum BotError: Swift.Error {
    /// Missing Telegram or Messenger secret key in Config/secrets/app.json.
    case missingSecretKey
}

/// Create the Droplet.
let droplet: Droplet = Droplet()

/// Read Telegram secret key from Config/secrets/app.json.
let telegramSecret = droplet.config["app", "telegram", "secret"]?.string ?? ""
let messengerSecret = droplet.config["app", "messenger", "secret"]?.string ?? ""
let messengerToken = droplet.config["app", "messenger", "token"]?.string ?? ""

guard telegramSecret != "" || (messengerSecret != "" && messengerToken != "") else {
    /// Show errors in console.
    droplet.console.error("Missing secret keys!")
    droplet.console.error("Add almost one in Config/secrets/app.json")

    /// Throw missing secret key error.
    throw BotError.missingSecretKey
}

/// Setting up the POST request with Telegram secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// https://core.telegram.org/bots/api#setwebhook
droplet.post("telegram", telegramSecret) { request in
    /// Let's prepare the response message text.
    var response: String = ""
    
    /// Chat ID from request JSON.
    let chatID: Int = request.data["message", "chat", "id"]?.int ?? 0
    /// Message text from request JSON.
    let message: String = request.data["message", "text"]?.string ?? ""
    /// User first name from request JSON.
    var userFirstName: String = request.data["message", "from", "first_name"]?.string ?? ""
    
    /// Check if the message is empty.
    if message.isEmpty {
        /// Set the response message text.
        response = "I'm sorry but your message is empty 😢"
    /// The message is not empty.
    } else {
        /// Check if the message is a Telegram command.
        if message.hasPrefix("/") {
            /// Check what type of command is.
            switch message {
            /// Start command "/start".
            case "/start":
                /// Set the response message text.
                response = "Welcome to SwiftyBot " + userFirstName + "!\n" +
                           "To list all available commands type /help"
            /// Help command "/help".
            case "/help":
                /// Set the response message text.
                response = "Welcome to SwiftyBot " +
                           "an example on how to create a Telegram bot with Swift using Vapor.\n" +
                           "https://www.fabriziobrancati.com/SwiftyBot\n\n" +
                           "/start - Welcome message\n" +
                           "/help - Help message\n" +
                           "Any text - Returns the reversed message"
            /// Command not valid.
            default:
                /// Set the response message text and suggest to type "/help".
                response = "Unrecognized command.\n" +
                           "To list all available commands type /help"
            }
        /// It is not a Telegram command, so create a reversed message text.
        } else {
            /// Set the response message text.
            response = message.reversed(preserveFormat: true)
        }
    }
    
    /// Create the JSON response.
    /// https://core.telegram.org/bots/api#sendmessage
    return try JSON(node:
        [
            "method": "sendMessage",
            "chat_id": chatID,
            "text": response
        ]
    )
}

/// Setting up the GET request with Messenger secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// This is step 2 of the following guide:
/// https://developers.facebook.com/docs/messenger-platform/guides/quick-start
droplet.get("messenger", messengerSecret, "*") { request in
    guard request.data["hub.mode"]?.string == "subscribe" && request.data["hub.verify_token"]?.string == messengerSecret, let challenge = request.data["hub.challenge"]?.string else {
        throw Abort.custom(status: .badRequest, message: "Missing Messenger verification data.")
    }
    
    return Response(status: .ok, headers: ["Content-Type": "text/plain"], body: challenge)
}

/// Setting up the POST request with Messenger secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// This is step 5 of the following guide:
/// https://developers.facebook.com/docs/messenger-platform/guides/quick-start
droplet.post("messenger", messengerSecret, "*") { request in
    /// Check that the request cames from a "page".
    guard request.json?["object"]?.string == "page" else {
        /// Throw an abort response, with a custom message.
        throw Abort.custom(status: .badRequest, message: "Message not generated by a page.")
    }
    
    /// Let's prepare the response message text.
    var response: String = ""
    /// Entries from request JSON.
    let entries: [Polymorphic] = request.json?["entry"]?.array ?? []
    
    /// Iterate over all entries.
    for entry in entries {
        /// Page ID of the entry.
        let pageID: String = entry.object?["id"]?.string ?? "0"
        /// Messages from entry.
        let messaging: [Polymorphic] = entry.object?["messaging"]?.array ?? []
        
        /// Iterate over all messaging objects.
        for event in messaging {
            /// Message of the event.
            let message: [String: Polymorphic] = event.object?["message"]?.object ?? [:]
            /// Recipient of the event.
            let recipient: [String: Polymorphic] = event.object?["recipient"]?.object ?? [:]
            /// Recipient ID, it is used to make a response to the right chat.
            let recipientID: String = recipient["id"]?.string ?? ""
            /// Text sended to bot.
            let text: String = message["text"]?.string ?? ""
            
            /// Check if the message object is empty.
            if message.isEmpty {
                /// Set the response message text.
                response = "Webhook received unknown event."
            /// Check if the message text is empty
            } else if text.isEmpty {
                /// Set the response message text.
                response = "I'm sorry but your message is empty 😢"
            /// The message object and its text are not empty, so create a reversed message text.
            } else {
                /// Set the response message text.
                response = text.reversed(preserveFormat: true)
                
                /// Creating the response JSON data bytes.
                let responseData = try JSON(node: ["recipient": JSON(node: ["id": recipientID]), "message": JSON(node: ["text": response])]).makeBytes()
                
                /// Calling the Facebook API to send the response.
                let facebookAPICall = try droplet.client.post("https://graph.facebook.com/v2.8/me/messages", headers: ["Content-Type": "application/json"], query: ["access_token": messengerToken], body: Body.data(responseData))
                
                droplet.console.info("Message sent to: \(recipientID), with text: \(response)")
            }
        }
    }
    
    /// Sending an HTTP 200 OK response is required.
    /// https://developers.facebook.com/docs/messenger-platform/webhook-reference#response
    /// The header is added just to mute a Vapor warning.
    return Response(status: .ok, headers: ["Content-Type": "application/json"])
}

/// Run the Droplet.
droplet.run()
