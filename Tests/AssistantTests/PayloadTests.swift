//
//  PayloadTests.swift
//  SwiftyBot
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 - 2020 Fabrizio Brancati.
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

@testable import Assistant
import Foundation
import XCTest

internal class PayloadTests: XCTestCase {
    internal func testTextToSpeechNoItems() {
        var payload = Payload(google: GooglePayload(richResponse: RichResponse(items: [])))
        payload.set(textToSpeech: "This is a test")

        XCTAssertNil(payload.google.richResponse.items.first?.simpleResponse.textToSpeech)
        XCTAssertNil(payload.google.richResponse.items.first?.simpleResponse.displayText)
    }

    internal func testTextToSpeech() {
        var payload = Payload(
            google: GooglePayload(
                richResponse: RichResponse(
                    items: [
                        RichResponseItem(
                            simpleResponse: SimpleResponse(
                                textToSpeech: "I'm sorry but there was an error 😢",
                                displayText: "I am sorry but there was an error"
                            )
                        )
                    ]
                )
            )
        )
        payload.set(textToSpeech: "This is a test")

        XCTAssertEqual(payload.google.richResponse.items.first?.simpleResponse.textToSpeech, "This is a test")
        XCTAssertNil(payload.google.richResponse.items.first?.simpleResponse.displayText)
    }

    internal func testTextToSpeechAndDisplayText() {
        var payload = Payload(
            google: GooglePayload(
                richResponse: RichResponse(
                    items: [
                        RichResponseItem(
                            simpleResponse: SimpleResponse(
                                textToSpeech: "I'm sorry but there was an error 😢",
                                displayText: "I am sorry but there was an error"
                            )
                        )
                    ]
                )
            )
        )
        payload.set(textToSpeech: "This is a test", displayText: "This is a test too")

        XCTAssertEqual(payload.google.richResponse.items.first?.simpleResponse.textToSpeech, "This is a test")
        XCTAssertEqual(payload.google.richResponse.items.first?.simpleResponse.displayText, "This is a test too")
    }
}
