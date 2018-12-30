//
//  SenderAction.swift
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

import Foundation
import Vapor

/// Messenger sender actions.
public struct SenderAction: Content {
    /// Payload template.
    public enum Action: String, Codable {
        /// Mark seen action.
        case markSeen = "mark_seen"
        /// Typing on action.
        case typingOn = "typing_on"
    }
    
    /// Recipient.
    public private(set) var recipient: Recipient
    /// Sender action.
    public private(set) var action: Action
    
    /// Coding keys, used by Codable protocol.
    private enum CodingKeys: String, CodingKey {
        case recipient
        case action = "sender_action"
    }
    
    /// Creates and sends a sender action.
    ///
    /// - Parameters:
    ///   - id: User ID used for the request.
    ///   - action: Sender action to be sent.
    ///   - request: Request to be used as client.
    public init(id: String, action: Action, on request: Request) {
        /// Set the sender action properties.
        recipient = Recipient(id: id)
        self.action = action
        
        /// Requests to set sender action.
        _ = try? request.client().post("https://graph.facebook.com/\(messengerAPIVersion)/messages?access_token=\(messengerToken)") { messageRequest in
            try messageRequest.content.encode(self)
        }
    }
}
