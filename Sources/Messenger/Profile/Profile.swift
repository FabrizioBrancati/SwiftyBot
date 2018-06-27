//
//  Profile.swift
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

/// Messenger Profile helper.
public struct Profile: Content {
    /// Get Started property.
    public private(set) var getStarted: GetStarted
    /// Greeting property.
    public private(set) var greeting: Greeting
    
    /// Coding keys, used by Codable protocol.
    public enum Name: String, CodingKey {
        case getStarted = "get_started"
        case greeting
        case persistentMenu = "persistent_menu"
    }
}

// MARK: - Profile Extension

/// Profile extension.
extension Profile {
    /// Custom init method.
    /// Declared in an extension to not override default `init` function.
    public init(getStarted: GetStarted, greeting: Greeting, on app: Application) {
        self.getStarted = getStarted
        self.greeting = greeting
        
        /// Set all the Messenger Profile properties.
        _ = try? app.client().post("https://graph.facebook.com/\(messengerAPIVersion)/me/messenger_profile?access_token=\(messengerToken)", headers: ["Content-Type": "application/json"]) { profileRequest in
            try profileRequest.content.encode(self)
        }
    }
}
