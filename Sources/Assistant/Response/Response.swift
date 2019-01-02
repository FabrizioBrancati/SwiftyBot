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

/// Google Assistant response
public struct Response: Codable {
    /// The text to be shown on the screen.
    public private(set) var fulfillmentText: String
    /// The collection of rich messages to present to the user.
    public private(set) var fulfillmentMessages: [FullfillmentMessage]
    /// Host source.
    public private(set) var source: String
    /// Response payload.
    public private(set) var payload: Payload
}


// MARK: - Response Extension

/// Response extension.
public extension Response {
    /// Empty init method.
    /// Declared in an extension to not override default `init` function.
    public init(for request: Vapor.Request) throws {
        /// Decode the request.
        let messageRequest = try request.content.syncDecode(Request.self)
        
        /// Creates the initial response, with a default message for empty user's message.
        fulfillmentText = "This is a test"
        fulfillmentMessages = [.text(MessageText(text: ["This is a test 2"]))]
        source = "fabriziobrancati.com"
        payload = Payload(
            google: GooglePayload(
                expectUserResponse: true, richResponse: RichResponse(
                    items: [
                        RichResponseItem(
                            simpleResponse: SimpleResponse(
                                textToSpeech: "This is a test 3")
                        )
                    ]
                )
            )
        )
    }
}

// MARK: - Response Handling

/// Response extension.
public extension Response {
    /// Create a response for a request.
    ///
    /// - Parameter request: Message request.
    /// - Returns: Returns the message `HTTPResponse`.
    /// - Throws: Decoding errors.
    public func create(on request: Vapor.Request) throws -> HTTPResponse {
        /// Create the JSON response.
        /// https://dialogflow.com/docs/fulfillment/how-it-works#response_format
        var httpResponse = HTTPResponse(status: .ok, headers: ["Content-Type": "application/json"])
        /// Encode the response.
        try JSONEncoder().encode(self, to: &httpResponse, on: request.eventLoop)
        return httpResponse
    }
}
