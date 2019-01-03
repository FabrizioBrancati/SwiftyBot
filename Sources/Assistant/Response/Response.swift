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
    /// Response payload.
    public private(set) var payload: Payload
}


// MARK: - Response Extension

/// Response extension.
public extension Response {
    /// Empty init method.
    /// Declared in an extension to not override default `init` function.
    public init(for request: Vapor.Request) throws {
        payload = Payload(
            google: GooglePayload(
                expectUserResponse: true, richResponse: RichResponse(
                    items: [
                        RichResponseItem(
                            simpleResponse: SimpleResponse(
                                textToSpeech: "I'm sorry but there was an error 😢")
                        )
                    ]
                )
            )
        )
        
        /// Decode the request.
        let messageRequest = try request.content.syncDecode(Request.self)
        
        if messageRequest.queryResult.intent.displayName == Intent.helpIntent {
            payload.google.richResponse.items[0].simpleResponse.textToSpeech = """
            Welcome to SwiftyBot, an example on how to create a Google Assistant bot with Swift using Vapor.

            Say hi to get a Welcome message
            Ask for help or Ask for the bot purpose to get a Help message
            Ask to buy something to get a Carousel message
            Any other sentence will get a Fallback message
            """
            payload.google.richResponse.items[0].simpleResponse.displayText = """
            Welcome to SwiftyBot, an example on how to create a Google Assistant bot with Swift using Vapor.
            https://www.fabriziobrancati.com/SwiftyBot-3
            
            Say hi - Welcome message
            Ask for help / Ask for the bot purpose - Help message
            Ask to buy something - Carousel message
            Any other sentence - Fallback message
            """
        }
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
        /// More info [here](https://dialogflow.com/docs/fulfillment/how-it-works#response_format).
        var httpResponse = HTTPResponse(status: .ok, headers: ["Content-Type": "application/json"])
        /// Encode the response.
        try JSONEncoder().encode(self, to: &httpResponse, on: request.eventLoop)
        return httpResponse
    }
}
