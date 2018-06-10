//
//  CommandTests.swift
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
@testable import Telegram
import XCTest

/// Command Tests.
class CommandTests: XCTestCase {
    func testInitCommand() {
        guard let command = Command("/test test") else {
            XCTFail("Command is nil")
            return
        }
        
        XCTAssertEqual(command.command, "test")
        XCTAssertEqual(command.parameters, "test")
        
        guard let command2 = Command("/test") else {
            XCTFail("Command is nil")
            return
        }
        
        XCTAssertEqual(command2.command, "test")
        XCTAssertEqual(command2.parameters, "")
        
        guard let command3 = Command("/test /test test") else {
            XCTFail("Command is nil")
            return
        }
        
        XCTAssertEqual(command3.command, "test")
        XCTAssertEqual(command3.parameters, "/test test")
    }
    
    func testInitNilCommand() {
        let command = Command("")
        let command2 = Command("test test")
        
        XCTAssertNil(command)
        XCTAssertNil(command2)
    }
}
