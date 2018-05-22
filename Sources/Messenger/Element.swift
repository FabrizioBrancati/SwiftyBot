//
//  Element.swift
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

/// Messenger element helper.
public struct Element: Codable {
    // Element title.
    private(set) public var title: String
    /// Element subtitle.
    private(set) public var subtitle: String
    /// Element item URL.
    private(set) public var itemURL: String
    /// Element image URL.
    private(set) public var imageURL: String
    /// Element Button array.
    private(set) public var buttons: [Button] = []
    
    /// Initialize an Element.
    ///
    /// - Parameters:
    ///   - title: Element title
    ///   - subtitle: Element subtitle.
    ///   - itemURL: Element item URL.
    ///   - imageURL: Element image URL.
    ///   - buttons: Element button.
    public init(title: String, subtitle: String, itemURL: String, imageURL: String, buttons: [Button] = []) {
        self.title = title
        self.subtitle = subtitle
        self.itemURL = itemURL
        self.imageURL = imageURL
        self.buttons = buttons
    }
    
    /// Adds a button to the Element.
    ///
    /// - Parameter button: Button to be added.
    public mutating func add(button: Button) {
        buttons.append(button)
    }
}
