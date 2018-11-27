//
//  ProfileTests.swift
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
import Vapor
import XCTest

internal class ProfileTests: XCTestCase {
    internal func testInit() {
        let getStarted = GetStarted(payload: GetStarted.defaultPayload)
        let greeting = Greeting(greeting: [
            LocalizedGreeting(locale: .default, text: "Hi \(LocalizedGreeting.Template.firstName.rawValue)! SwiftyBot is an example of how to create a Messenger bot with Swift. See its code at https://github.com/FabrizioBrancati/SwiftyBot"),
            LocalizedGreeting(locale: .italian, text: "Ciao \(LocalizedGreeting.Template.firstName.rawValue)! SwiftyBot è un esempio di come creare un bot Messenger con Swift. Guarda il codice https://github.com/FabrizioBrancati/SwiftyBot")
        ])
        let profile = try? Profile(getStarted: getStarted, greeting: greeting, on: Application())
        
        XCTAssertNotNil(profile?.getStarted)
        XCTAssertNotNil(profile?.greeting)
    }
}
