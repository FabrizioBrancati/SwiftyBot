//
//  ElementTests.swift
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
@testable import Messenger
import XCTest

internal class ElementTests: XCTestCase {
    internal func testInitElement() {
        let element = Element(title: "Test", subtitle: "Test Subtitle", itemURL: "Test URL", imageURL: "Test Image URL")
        
        XCTAssertEqual(element.title, "Test")
        XCTAssertEqual(element.subtitle, "Test Subtitle")
        XCTAssertEqual(element.itemURL, "Test URL")
        XCTAssertEqual(element.imageURL, "Test Image URL")
    }
    
    internal func testInitElementWithButtons() {
        let buttons = [
            Button(title: "Test", payload: "Test Payload"),
            Button(title: "Test", url: "Test URL")
        ]
        let element = Element(title: "Test", subtitle: "Test Subtitle", itemURL: "Test URL", imageURL: "Test Image URL", buttons: buttons)
        
        XCTAssertEqual(element.title, "Test")
        XCTAssertEqual(element.subtitle, "Test Subtitle")
        XCTAssertEqual(element.itemURL, "Test URL")
        XCTAssertEqual(element.imageURL, "Test Image URL")
        XCTAssertEqual(element.buttons.count, buttons.count)
        XCTAssertEqual(element.buttons, buttons)
    }
    
    internal func testAddButton() {
        var element = Element(title: "Test", subtitle: "Test Subtitle", itemURL: "Test URL", imageURL: "Test Image URL")
        let payloadButton = Button(title: "Test", payload: "Test Payload")
        let urlButton = Button(title: "Test", url: "Test URL")
        
        element.add(button: payloadButton)
        element.add(button: urlButton)
        
        XCTAssertEqual(element.title, "Test")
        XCTAssertEqual(element.subtitle, "Test Subtitle")
        XCTAssertEqual(element.itemURL, "Test URL")
        XCTAssertEqual(element.imageURL, "Test Image URL")
        XCTAssertTrue(element.buttons.contains(payloadButton))
        XCTAssertTrue(element.buttons.contains(urlButton))
    }
}
