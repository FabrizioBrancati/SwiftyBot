//
//  MessageResponseTests.swift
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

internal class MessageResponseTests: XCTestCase {
    internal func testDecodeAsTextMessage() throws {
        let json = """
        {"text": "Test"}
        """.data(using: .utf8) ?? Data()
        
        let decoded = try? JSONDecoder().decode(MessageResponse.self, from: json)
        
        XCTAssertEqual(decoded, .text("Test"))
    }
    
    internal func testDecodeAsStructuredMessage() throws {
        let json = """
        {"attachment":{"type":"template","payload":{"template_type":"generic","elements":[]}}}
        """.data(using: .utf8) ?? Data()
        
        let decoded = try? JSONDecoder().decode(MessageResponse.self, from: json)
        
        XCTAssertEqual(decoded, .structured(StructuredMessage(attachment: Attachment(type: .template, payload: Payload(templateType: .generic, elements: [])))))
    }
    
    internal func testEncodeAsTextMessage() throws {
        let messageResponse = MessageResponse.text("Test")
        
        let encoded = try? JSONEncoder().encode(messageResponse)
        
        XCTAssertEqual(encoded, "{\"text\":\"Test\"}".data(using: .utf8))
    }
    
    internal func testEncodeAsStructuredMessage() throws {
        let messageResponse = MessageResponse.structured(StructuredMessage(attachment: Attachment(type: .template, payload: Payload(templateType: .generic, elements: []))))
        
        let encoded = try? JSONEncoder().encode(messageResponse)
        
        XCTAssertNotNil(encoded)
    }
}
