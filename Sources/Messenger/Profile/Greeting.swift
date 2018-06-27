//
//  Greeting.swift
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

/// Greeting helper.
public struct Greeting: Codable, Equatable {
    /// Array of Localized Greetings.
    public private(set) var greeting: [LocalizedGreeting]
    
    /// Creates a Greeting.
    ///
    /// - Parameter greeting: Greeting text shown before the chat starts.
    public init(greeting: [LocalizedGreeting]) {
        self.greeting = greeting
    }
    
    /// This initializer throws an error if reading from the decoder fails,
    /// or if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: Throws decoding errors.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        greeting = try container.decode([LocalizedGreeting].self)
    }
    
    /// If the value fails to encode anything, encoder will encode an empty keyed container in its place.
    /// This function throws an error if any values are invalid for the given encoder’s format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: Throws encoding errors.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(greeting)
    }
}
