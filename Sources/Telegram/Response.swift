//
//  Response.swift
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

/// Telegram response
public struct Response: Codable {
    /// Response method.
    public enum Method: String, Codable {
        /// Send message method.
        case sendMessage
    }
    
    /// Response method.
    public private(set) var method: Method
    /// Response chat ID.
    public private(set) var chatID: Int
    /// Response text.
    public var text: String
    
    /// Coding keys, used by Codable protocol.
    private enum CodingKeys: String, CodingKey {
        case method
        case chatID = "chat_id"
        case text
    }
    
    /// Create a response for a request.
    ///
    /// - Parameter request: Message request.
    /// - Returns: Returns the message `HTTPResponse`.
    /// - Throws: Decoding errors.
    public func response(_ request: Request) throws -> HTTPResponse {
        /// Decode the request.
        let messageRequest = try request.content.syncDecode(MessageRequest.self)
        
        /// Creates the initial response, with a default message for empty user's message.
        var response = Telegram.Response(method: .sendMessage, chatID: messageRequest.message.chat.id, text: "I'm sorry but your message is empty 😢")
        
        /// Check if the message is not empty
        if !messageRequest.message.text.isEmpty {
            /// Check if it's a command.
            if messageRequest.message.text.hasPrefix("/") {
                /// Check if it's a `start` command.
                if let command = Command(messageRequest.message.text), command.command == "start" {
                    response.text = """
                    Welcome to SwiftyBot \(messageRequest.message.from.firstName)!
                    To list all available commands type /help
                    """
                /// Check if it's a `help` command.
                } else if let command = Command(messageRequest.message.text), command.command == "help" {
                    response.text = """
                    Welcome to SwiftyBot, an example on how to create a Telegram bot with Swift using Vapor.
                    https://www.fabriziobrancati.com/SwiftyBot
                    
                    /start - Welcome message
                    /help - Help message
                    Any text - Returns the reversed message
                    """
                /// It's not a valid command.
                } else {
                    response.text = """
                    Unrecognized command.
                    To list all available commands type /help
                    """
                }
            /// It's a normal message, so reverse it.
            } else {
                response.text = messageRequest.message.text.reversed(preserveFormat: true)
            }
        }
        
        /// Create the JSON response.
        /// https://core.telegram.org/bots/api#sendmessage
        var httpResponse = HTTPResponse(status: .ok, headers: ["Content-Type": "application/json"])
        /// Encode the response.
        try JSONEncoder().encode(response, to: &httpResponse, on: request.eventLoop)
        return httpResponse
    }
}

// MARK: - Response Extension

/// Response extension.
public extension Response {
    /// Empty init method.
    /// Declared in an extension to not override default `init` function.
    public init() {
        method = .sendMessage
        chatID = 0
        text = ""
    }
}
