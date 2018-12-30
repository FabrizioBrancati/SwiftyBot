//
//  Button.swift
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

/// Button helper.
public struct Button: Codable, Equatable {
    /// Button type of Messenger structured message element.
    public enum `Type`: String, Codable, Equatable {
        /// Web URL type.
        case webURL = "web_url"
        /// Postback type.
        case postback = "postback"
    }

    /// Button type.
    public private(set) var type: Type
    /// Button title.
    public private(set) var title: String
    /// Button payload, postback type only.
    public private(set) var payload: String?
    /// Button URL, webURL type only.
    public private(set) var url: String?
    
    /// Creates a Button for Messenger structured message element.
    ///
    /// - Parameters:
    ///   - title: Button type.
    ///   - url: Button URL.
    public init(title: String, url: String) {
        /// Set Button type.
        self.type = .webURL
        /// Set Button title.
        self.title = title
        /// Is a webURL type, so set its url.
        self.url = url
    }
    
    /// Creates a Button for Messenger structured message element.
    ///
    /// - Parameters:
    ///   - title: Button type.
    ///   - payload: Button payload.
    public init(title: String, payload: String) {
        /// Set Button type.
        self.type = .postback
        /// Set Button title.
        self.title = title
        /// Is a postback type, so set its payload.
        self.payload = payload
    }
}
