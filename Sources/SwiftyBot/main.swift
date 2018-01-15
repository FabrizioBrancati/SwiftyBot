//
//  main.swift
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

/// Import Vapor & BFKit frameworks.
import Vapor
import HTTP
import BFKit

// MARK: - Errors

/// Bot errors enum.
enum BotError: Swift.Error {
    /// Missing Telegram or Messenger secret key in Config/secrets/app.json.
    case missingAppSecrets
    /// Missing URL in Messenger structured message button.
    case missingURL
    /// Missing payload in Messenger structured message button.
    case missingPayload
}

// MARK: - Configuration

/// Create the Droplet.
let droplet: Droplet = try Droplet()

/// Read Telegram & Messenger secrets key from Config/secrets/app.json.
let telegramSecret = droplet.config["app", "telegram", "secret"]?.string ?? ""
let messengerSecret = droplet.config["app", "messenger", "secret"]?.string ?? ""
let messengerToken = droplet.config["app", "messenger", "token"]?.string ?? ""

guard telegramSecret != "" || (messengerSecret != "" && messengerToken != "") else {
    /// Show errors in console.
    droplet.console.error("Missing secret or token keys!")
    droplet.console.error("Add almost one in Config/secrets/app.json")

    /// Throw missing secret key error.
    throw BotError.missingAppSecrets
}

// MARK: - Helpers

/// Detector String extension.
extension String {
    /// Detect if the message has greetings.
    ///
    /// - Returns: Returns true if the message has greetings, otherwise false.
    func hasGreetings() -> Bool {
        let message = self.lowercased()
        if message.contains("hi") ||
           message.contains("hello") ||
           message.contains("hey") ||
           message.contains("hei") ||
           message.contains("ciao") {
            return true
        }
        return false
    }
}

// MARK: - Telegram bot

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
    let userFirstName: String = request.data["message", "from", "first_name"]?.string ?? ""

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
    return try JSON(node: [
            "method": "sendMessage",
            "chat_id": chatID,
            "text": response
        ]
    )
}

// MARK: - Messenger bot

/// Struct to help with Messenger messages.
struct Messenger {
    /// Creates a standard Messenger message.
    ///
    /// - Parameter message: Message text to be sent.
    /// - Returns: Returns the created Node ready to be sent.
    static func message(_ message: String) -> Node {
        /// Create the Node.
        return [
            "text": message.makeNode(in: nil)
        ]
    }

    /// Creates a structured Messenger message.
    ///
    /// - Parameter elements: Elements of the structured message.
    /// - Returns: Returns the representable Node.
    /// - Throws: Throws NodeError errors.
    static func structuredMessage(elements: [Element]) throws -> Node {
        /// Create the Node.
        return try ["attachment":
            ["type": "template",
             "payload":
                ["template_type": "generic",
                 "elements": elements.makeNode(in: nil)
                ]
            ]
        ]
    }

    /// Messenger structured message element.
    struct Element: NodeRepresentable {
        /// Element title.
        var title: String
        /// Element subtitle.
        var subtitle: String
        /// Element item URL.
        var itemURL: String
        /// Element image URL.
        var imageURL: String
        /// Element Button array.
        var buttons: [Button]

        /// Element conforms to NodeRepresentable, turn the convertible into a node.
        ///
        /// - Parameter context: Context beyond Node.
        /// - Returns: Returns the Element Node representation.
        /// - Throws: Throws NodeError errors.
        public func makeNode(in context: Context?) throws -> Node {
            /// Create the Node.
            return try Node(node: [
                "title": title.makeNode(in: nil),
                "subtitle": subtitle.makeNode(in: nil),
                "item_url": itemURL.makeNode(in: nil),
                "image_url": imageURL.makeNode(in: nil),
                "buttons": buttons.makeNode(in: nil)
                ]
            )
        }

        /// Button of Messenger structured message element.
        struct Button: NodeRepresentable {
            /// Button type of Messenger structured message element.
            ///
            /// - webURL: Web URL type.
            /// - postback: Postback type.
            enum `Type`: String {
                case webURL = "web_url"
                case postback = "postback"
            }

            /// Set all its property to get only.
            /// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html#//apple_ref/doc/uid/TP40014097-CH41-ID18
            /// Button type.
            private(set) var type: Type
            /// Button title.
            private(set) var title: String
            /// Button payload, postback type only.
            private(set) var payload: String?
            /// Button URL, webURL type only.
            private(set) var url: String?

            /// Creates a Button for Messenger structured message element.
            ///
            /// - Parameters:
            ///   - type: Button type.
            ///   - title: Button title.
            ///   - payload: Button payload.
            ///   - url: Button URL.
            /// - Throws: Throws NodeError errors.
            init(type: Type, title: String, payload: String? = nil, url: String? = nil) throws {
                /// Set Button type.
                self.type = type
                /// Set Button title.
                self.title = title

                /// Check what Button type is.
                switch type {
                /// Is a webURL type, so se its url.
                case .webURL:
                    /// Check if url is nil.
                    guard let url = url else {
                        throw BotError.missingURL
                    }
                    self.url = url
                /// Is a postback type, so se its payload.
                case .postback:
                    /// Check if payload is nil.
                    guard let payload = payload else {
                        throw BotError.missingPayload
                    }
                    self.payload = payload
                }
            }

            /// Button conforms to NodeRepresentable, turn the convertible into a node.
            ///
            /// - Parameter context: Context beyond Node.
            /// - Returns: Returns the Button Node representation.
            /// - Throws: Throws NodeError errors.
            public func makeNode(in context: Context?) throws -> Node {
                /// Create the Node with type and title.
                var node: Node = [
                    "type": type.rawValue.makeNode(in: nil),
                    "title": title.makeNode(in: nil)
                ]

                /// Extends the Node with url or payload, depends on Button type.
                switch type {
                /// Extends with url property.
                case .webURL:
                    node["url"] = url?.makeNode(in: nil) ?? ""
                /// Extends with payload property.
                case .postback:
                    node["payload"] = payload?.makeNode(in: nil) ?? ""
                }

                /// Create the Node.
                return Node(node: node)
            }
        }
    }
}

/// Setting up the GET request with Messenger secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// This is the Step 2 of Facebook Messenger Quick Start guide:
/// https://developers.facebook.com/docs/messenger-platform/guides/quick-start#setup_webhook
droplet.get("messenger", messengerSecret) { request in
    /// Check for "hub.mode", "hub.verify_token" & "hub.challenge" query parameters.
    guard request.data["hub.mode"]?.string == "subscribe" && request.data["hub.verify_token"]?.string == messengerSecret, let challenge = request.data["hub.challenge"]?.string else {
        throw Abort(.badRequest, reason: "Missing Messenger verification data.")
    }

    /// Create a response with the challenge query parameter to verify the webhook.
    return Response(status: .ok, headers: ["Content-Type": "text/plain"], body: challenge)
}

/// Setting up the POST request with Messenger secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// This is the Step 5 of Facebook Messenger Quick Start guide:
/// https://developers.facebook.com/docs/messenger-platform/guides/quick-start#receive_messages
droplet.post("messenger", messengerSecret) { request in
    /// Check that the request comes from a "page".
    guard request.json?["object"]?.string == "page" else {
        /// Throw an abort response, with a custom message.
        throw Abort(.badRequest, reason: "Message not generated by a page.")
    }

    /// Prepare the response message text.
    var response: Node = ["text": "Unknown error."]
    /// Entries from request JSON.
    let entries: [JSON] = request.json?["entry"]?.array ?? []

    /// Iterate over all entries.
    for entry in entries {
        /// Messages from entry.
        let messaging: [JSON] = entry.object?["messaging"]?.array ?? []

        /// Iterate over all messaging objects.
        for event in messaging {
            /// Message of the event.
            let message: [String: JSON] = event.object?["message"]?.object ?? [:]
            /// Postback of the event.
            let postback: [String: JSON] = event.object?["postback"]?.object ?? [:]
            /// Sender of the event.
            let sender: [String: JSON] = event.object?["sender"]?.object ?? [:]
            /// Sender ID, it is used to make a response to the right user.
            let senderID: String = sender["id"]?.string ?? ""
            /// Text sent to bot.
            let text: String = message["text"]?.string ?? ""

            /// Check if is a postback action.
            if !postback.isEmpty {
                /// Get payload from postback.
                let payload: String = postback["payload"]?.string ?? "No payload provided by developer."
                /// Set the response message text.
                response = Messenger.message(payload)
            /// Check if the message object is empty.
            } else if message.isEmpty {
                /// Set the response message text.
                response = Messenger.message("Webhook received unknown event.")
            /// Check if the message text is empty
            } else if text.isEmpty {
                /// Set the response message text.
                response = Messenger.message("I'm sorry but your message is empty 😢")
            /// The user greeted the bot.
            } else if text.hasGreetings() {
                response = Messenger.message("Hi!\nThis is an example on how to create a bot with Swift.\nIf you want to see more try to send me \"buy\", \"sell\" or \"shop\".")
            /// The user wants to buy something.
            } else if text.lowercased().range(of: "sell") || text.lowercased().range(of: "buy") || text.lowercased().range(of: "shop") {
                do {
                    /// Create all the elements in elements object of the Messenger structured message.
                    /// First Element: BFKit-Swift
                    let BFKitSwift = try Messenger.Element(title: "BFKit-Swift", subtitle: "BFKit-Swift is a collection of useful classes, structs and extensions to develop Apps faster.", itemURL: "https://github.com/FabrizioBrancati/BFKit-Swift", imageURL: "https://github.fabriziobrancati.com/bfkit/resources/banner-swift.png", buttons: [
                        Messenger.Element.Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/BFKit-Swift"),
                        Messenger.Element.Button(type: .postback, title: "Call Postback", payload: "BFKit-Swift payload.")])
                    /// Second Element: BFKit
                    let BFKit = try Messenger.Element(title: "BFKit", subtitle: "BFKit is a collection of useful classes and categories to develop Apps faster.", itemURL: "https://github.com/FabrizioBrancati/BFKit", imageURL: "https://github.fabriziobrancati.com/bfkit/resources/banner-objc.png", buttons: [
                        Messenger.Element.Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/BFKit"),
                        Messenger.Element.Button(type: .postback, title: "Call Postback", payload: "BFKit payload.")])
                    /// Third Element: SwiftyBot
                    let SwiftyBot = try Messenger.Element(title: "SwiftyBot", subtitle: "How to create a Telegram & Messenger bot with Swift using Vapor on Ubuntu / macOS", itemURL: "https://github.com/FabrizioBrancati/SwiftyBot", imageURL: "https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner-new.png", buttons: [
                        Messenger.Element.Button(type: .webURL, title: "Open in GitHub", url: "https://github.com/FabrizioBrancati/SwiftyBot"),
                        Messenger.Element.Button(type: .postback, title: "Call Postback", payload: "SwiftyBot payload.")])

                    /// Create the elements array.
                    var elements: [Messenger.Element] = []
                    /// Add BFKit-Swift to elements array.
                    elements.append(BFKitSwift)
                    /// Add BFKit to elements array.
                    elements.append(BFKit)
                    /// Add SwiftyBot to elements array.
                    elements.append(SwiftyBot)

                    /// Create a structured message to sell something to the user.
                    response = try Messenger.structuredMessage(elements: elements)
                } catch {
                    /// Throw an abort response, with a custom message.
                    throw Abort(.badRequest, reason: "Error while creating elements.")
                }
            /// The message object and its text are not empty, and the user does not want to buy anything, so create a reversed message text.
            } else {
                /// Set the response message text.
                response = Messenger.message(text.reversed(preserveFormat: true))
            }

            /// Creating the response JSON data bytes.
            /// At Step 6 of Facebook Messenger Quick Start guide, using Node.js demo, they told you to send back the "recipient.id", but the correct one is "sender.id".
            /// https://developers.facebook.com/docs/messenger-platform/guides/quick-start#send_text_message
            var responseData: JSON = JSON()
            try responseData.set("recipient", ["id": senderID])
            try responseData.set("message", response)

            /// Calling the Facebook API to send the response.
            let _: Response = try droplet.client.post("https://graph.facebook.com/v2.10/me/messages", query: ["access_token": messengerToken], ["Content-Type": "application/json"], Body.data(responseData.makeBytes()))
        }
    }

    /// Sending an HTTP 200 OK response is required.
    /// https://developers.facebook.com/docs/messenger-platform/webhook-reference#response
    /// The header is added just to mute a Vapor warning.
    return Response(status: .ok, headers: ["Content-Type": "application/json"])
}

// MARK: - Droplet run

/// Run the Droplet.
try droplet.run()
