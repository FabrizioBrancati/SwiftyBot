//
//  Payload.swift
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

/// Message Payload.
public struct Payload: Codable {
    /// Google Payload.
    /// More info [here](https://developers.google.com/actions/conversation-api-playground).
    public internal(set) var google: GooglePayload
}

// MARK: - Set Payload Extension

/// Payload extension.
public extension Payload {
    /// Set the payload as a `SimpleResponse`, with a text to speech and a display text.
    ///
    /// - Parameters:
    ///   - textToSpeech: Text to speech.
    ///   - displayText: Display text. Set it only if differ from `textToSpeech`.
    public mutating func set(textToSpeech: String, displayText: String? = nil) {
        /// Check if there are items available.
        guard google.richResponse.items.first != nil else {
            return
        }
        
        /// Set the text to speech.
        google.richResponse.items[0].simpleResponse.textToSpeech = textToSpeech
        
        /// Check if the text to speech differ from display text.
        if textToSpeech != displayText {
            /// Set the display text.
            google.richResponse.items[0].simpleResponse.displayText = displayText
        }
    }
    
    /// Set the payload `SystemIntent`, for different [messages types](https://dialogflow.com/docs/reference/api-v2/rest/Shared.Types/Message).
    ///
    /// - Parameter systemIntent: System Intent.
    public mutating func set(systemIntent: SystemIntent) {
        google.systemIntent = systemIntent
    }
}
