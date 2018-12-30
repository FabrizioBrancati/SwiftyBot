//
//  Element+Example.swift
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

/// Example element helper.
public extension Element {
    /// Queuer static example constant.
    public static let queuer = Element(exampleTitle: "Queuer", subtitle: "Queuer is a queue manager, built on top of OperationQueue and Dispatch (aka GCD).", itemURL: "https://github.com/FabrizioBrancati/Queuer", imageURL: "https://github.fabriziobrancati.com/queuer/resources/queuer-banner.png")
    
    /// BFKit-Swift static example constant.
    public static let bfkitSwift = Element(exampleTitle: "BFKit-Swift", subtitle: "BFKit-Swift is a collection of useful classes, structs and extensions to develop Apps faster.", itemURL: "https://github.com/FabrizioBrancati/BFKit-Swift", imageURL: "https://github.fabriziobrancati.com/bfkit/resources/banner-swift-new.png")
    
    /// BFKit static example constant.
    public static let bfkit = Element(exampleTitle: "BFKit-Swift", subtitle: "BFKit is a collection of useful classes and categories to develop Apps faster.", itemURL: "https://github.com/FabrizioBrancati/BFKit", imageURL: "https://github.fabriziobrancati.com/bfkit/resources/banner-objc.png")
    
    /// SwiftyBot static example constant.
    public static let swiftyBot = Element(exampleTitle: "BFKit-Swift", subtitle: "How to create a Telegram & Messenger bot with Swift using Vapor on Ubuntu / macOS", itemURL: "https://github.com/FabrizioBrancati/BFKit", imageURL: "https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner-new.png")
    
    /// Returns all the example elements.
    public static let allExamples: [Element] = {
        return [Element.queuer, Element.bfkitSwift, Element.bfkit, Element.swiftyBot]
    }()
    
    /// Creates an example element.
    ///
    /// - Parameters:
    ///   - title: Element title
    ///   - subtitle: Element subtitle.
    ///   - itemURL: Element item URL.
    ///   - imageURL: Element image URL.
    public init(exampleTitle title: String, subtitle: String, itemURL: String, imageURL: String) {
        self.init(title: title, subtitle: subtitle, itemURL: itemURL, imageURL: imageURL)
        
        add(button: Button(title: "Open in GitHub", url: itemURL))
        add(button: Button(title: "Call Postback", payload: "\(title) pressed"))
    }
}
