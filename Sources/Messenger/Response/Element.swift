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
    /// Element title.
    public private(set) var title: String
    /// Element subtitle.
    public private(set) var subtitle: String
    /// Element item URL.
    public private(set) var itemURL: String
    /// Element image URL.
    public private(set) var imageURL: String
    /// Element Button array.
    public private(set) var buttons: [Button] = []
    
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

// MARK: - Equatable

/// Equatable extension.
extension Element: Equatable {
    /// Equatable function.
    public static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.itemURL == rhs.itemURL && lhs.buttons == rhs.buttons
    }
}
