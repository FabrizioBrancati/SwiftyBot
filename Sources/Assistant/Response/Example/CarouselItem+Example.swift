//
//  CarouselItem+Example.swift
//  SwiftyBot
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 - 2019 Fabrizio Brancati.
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

/// CarouselItem element helper.
public extension CarouselItem {
    /// Queuer static example constant.
    static let queuer = CarouselItem(
        title: "Queuer",
        description: "Queuer is a queue manager, built on top of OperationQueue and Dispatch (aka GCD).",
        optionInfo: OptionInfo(key: OptionInfoKey.queuer.rawValue, synonyms: ["Queuer", "OperationQueue", "Dispatch", "GCD"]),
        image: Image(url: "https://github.fabriziobrancati.com/queuer/resources/queuer-banner.png", accessibilityText: "Queuer Banner Image")
    )
    
    /// BFKit-Swift static example constant.
    static let bfkitSwift = CarouselItem(
        title: "BFKit-Swift",
        description: "BFKit-Swift is a collection of useful classes, structs and extensions to develop Apps faster.",
        optionInfo: OptionInfo(key: OptionInfoKey.bfkitSwift.rawValue, synonyms: ["Collection of structs", "Collection of extensions"]),
        image: Image(url: "https://github.fabriziobrancati.com/bfkit/resources/banner-swift-new.png", accessibilityText: "BFKit-Swift Banner Image")
    )
    
    /// BFKit static example constant.
    static let bfkit = CarouselItem(
        title: "BFKit",
        description: "BFKit is a collection of useful classes and categories to develop Apps faster.",
        optionInfo: OptionInfo(key: OptionInfoKey.bfkit.rawValue, synonyms: ["Collection of classes", "Collection of categories"]),
        image: Image(url: "https://github.fabriziobrancati.com/bfkit/resources/banner-objc.png", accessibilityText: "BFKit Banner Image")
    )
    
    /// SwiftyBot static example constant.
    static let swiftyBot = CarouselItem(
        title: "SwiftyBot",
        description: "How to create a Telegram, Facebook Messenger, and Google Assistant bot with Swift using Vapor on Ubuntu or macOS",
        optionInfo: OptionInfo(key: OptionInfoKey.swiftybot.rawValue, synonyms: ["Telegram bot", "Facebook Messenger bot", "Google Assistant bot"]),
        image: Image(url: "https://github.fabriziobrancati.com/swiftybot/resources/swiftybot-banner-new.png", accessibilityText: "SwiftyBot Banner Image")
    )
    
    /// Returns all the example elements.
    static let allExamples: [CarouselItem] = {
        return [CarouselItem.queuer, CarouselItem.bfkitSwift, CarouselItem.bfkit, CarouselItem.swiftyBot]
    }()
}
