//
//  MessageResponse.swift
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

/// Message response.
public enum MessageResponse: Codable {
    /// Message response error.
    public enum MessageResponseError: Error {
        /// Missing value error.
        case missingValue
    }
    
    /// Text message.
    case text(String)
    /// Structured message.
    case structured(StructuredMessage)
    
    public init(from decoder: Decoder) throws {
        if let text = try? decoder.singleValueContainer().decode(String.self) {
            self = .text(text)
            return
        }
        
        if let structured = try? decoder.singleValueContainer().decode(StructuredMessage.self) {
            self = .structured(structured)
            return
        }
        
        throw MessageResponseError.missingValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .text(let text):
            try container.encode(text)
        case .structured(let structured):
            try container.encode(structured)
        }
    }
}

// MARK: - Equatable

/// Equatable extension.
extension MessageResponse: Equatable {
    /// Equatable function.
    public static func == (lhs: MessageResponse, rhs: MessageResponse) -> Bool {
        switch (lhs, rhs) {
        case (.text(let lText), .text(let rText)):
            return lText == rText
        case (.structured(let lStructured), .structured(let rStructured)):
            return lStructured == rStructured
        default:
            return false
        }
    }
}
