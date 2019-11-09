//
//  AssistantRoutesTests.swift
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

@testable import Assistant
import Foundation
import Vapor
import XCTest

/// Assistant Routes Tests.
internal class AssistantRoutesTests: XCTestCase {
    internal var bot: Application! // swiftlint:disable:this implicitly_unwrapped_optional
    
    override internal func setUp() {
        super.setUp()
        
        do {
            bot = try Application.testable()
        } catch {}
    }
    
    internal func testRoutePostWithMissingIntent() throws {
        let request = Request(responseID: "abc123", session: "123abc", queryResult: QueryResult(queryText: "This is a test", languageCode: .english, intent: Intent(displayName: "Nothing")))
        let response = try bot.getResponse(to: "assistant/\(assistantSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: request, decodeTo: Response.self)

        XCTAssertTrue(response.payload.google.expectUserResponse)
        XCTAssertEqual(response.payload.google.richResponse.items.first?.simpleResponse.textToSpeech, "I'm sorry but there was an error 😢")
        XCTAssertEqual(response.payload.google.richResponse.items.first?.simpleResponse.displayText, "I am sorry but there was an error")
        XCTAssertNil(response.payload.google.systemIntent)
    }
    
    internal func testRoutePostWithHelpIntent() throws {
        let request = Request(responseID: "abc123", session: "123abc", queryResult: QueryResult(queryText: "This is a test", languageCode: .english, intent: Intent(displayName: "Help Intent")))
        let response = try bot.getResponse(to: "assistant/\(assistantSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: request, decodeTo: Response.self)

        XCTAssertTrue(response.payload.google.expectUserResponse)
        XCTAssertEqual(
            response.payload.google.richResponse.items.first?.simpleResponse.textToSpeech,
            """
            Welcome to SwiftyBot, an example on how to create a Google Assistant bot with Swift using Vapor.

            Say hi to get a welcome message
            Ask for help or ask for the bot purpose to get a help message
            Ask to buy something to get a carousel message
            Any other sentence will get a fallback message
            """
        )
        XCTAssertEqual(
            response.payload.google.richResponse.items.first?.simpleResponse.displayText,
            """
            Welcome to SwiftyBot, an example on how to create a Google Assistant bot with Swift using Vapor.
            https://www.fabriziobrancati.com/SwiftyBot-3
            
            Say hi - Welcome message
            Ask for help / Ask for the bot purpose - Help message
            Ask to buy something - Carousel message
            Any other sentence - Fallback message
            """
        )
        XCTAssertNil(response.payload.google.systemIntent)
    }
    
    internal func testRoutePostWithCarouselIntent() throws {
        let request = Request(responseID: "abc123", session: "123abc", queryResult: QueryResult(queryText: "This is a test", languageCode: .english, intent: Intent(displayName: "Carousel Intent")))
        let response = try bot.getResponse(to: "assistant/\(assistantSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: request, decodeTo: Response.self)

        XCTAssertTrue(response.payload.google.expectUserResponse)
        XCTAssertEqual(response.payload.google.richResponse.items.first?.simpleResponse.textToSpeech, "You can not display carousel items on this device, sorry")
        XCTAssertEqual(response.payload.google.richResponse.items.first?.simpleResponse.displayText, "You can't display carousel items on this device, sorry 😞")
        XCTAssertEqual(response.payload.google.systemIntent?.intent, .option)
        XCTAssertEqual(response.payload.google.systemIntent?.data.type, .option)
        XCTAssertEqual(response.payload.google.systemIntent?.data.carousel.items.first, CarouselItem.queuer)
    }
}
