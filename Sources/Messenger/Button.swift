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
public struct Button: Codable {
    /// Button type of Messenger structured message element.
    ///
    /// - webURL: Web URL type.
    /// - postback: Postback type.
    public enum `Type`: String, Codable {
        case webURL = "web_url"
        case postback = "postback"
    }

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
    public init(type: Type, title: String, payload: String? = nil, url: String? = nil) {
        /// Set Button type.
        self.type = type
        /// Set Button title.
        self.title = title

        /// Check what Button type is.
        switch type {
        /// Is a webURL type, so set its url.
        case .webURL:
            /// Check if url is nil.
            if let url = url {
                self.url = url
            }
        /// Is a postback type, so set its payload.
        case .postback:
            /// Check if payload is nil.
            if let payload = payload {
                self.payload = payload
            }
        }
    }
}
