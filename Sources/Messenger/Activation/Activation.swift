//
//  Activation.swift
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

/// Actiovation struct.
public struct Activation: Codable {
    /// Activation mode.
    public private(set) var mode: String?
    /// Activation token.
    public private(set) var verifyToken: String?
    /// Activation challenge.
    public private(set) var challenge: String?

    /// Coding keys, used by Codable protocol.
    private enum CodingKeys: String, CodingKey {
        case mode = "hub.mode"
        case verifyToken = "hub.verify_token"
        case challenge = "hub.challenge"
    }
}

// MARK: - Activation Extension

/// Activation extension.
public extension Activation {
    /// Empty init method.
    /// Declared in an extension to not override default `init` function.
    ///
    /// - Parameter request: Activation request.
    /// - Throws: Decoding errors.
    public init(for request: Request) throws {
        /// Try decoding the request query as `Activation`.
        self = try request.query.decode(Activation.self)
        
        /// Check for "hub.mode", "hub.verify_token" & "hub.challenge" query parameters.
        guard mode == "subscribe", verifyToken == messengerSecret else {
            throw Abort(.badRequest, reason: "Missing Facebook Messenger verification data.")
        }
    }
}

// MARK: - Activation Handling

/// Activation extension.
public extension Activation {
    /// Check if the activation is valid.
    ///
    /// - Returns: Returns the activation `HTTPResponse`.
    /// - Throws: Decoding errors.
    public func check() throws -> HTTPResponse {
        /// Create a response with the challenge query parameter to verify the webhook.
        let body = HTTPBody(data: (self.challenge ?? "").convertToData())
        /// Send a 200 (OK) response.
        return HTTPResponse(status: .ok, headers: ["Content-Type": "text/plain"], body: body)
    }
}
