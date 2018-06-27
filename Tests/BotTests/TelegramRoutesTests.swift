//
//  TelegramRoutesTests.swift
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
import Vapor
import XCTest

/// Telegram Routes Tests.
internal class TelegramRoutesTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    internal var bot: Application!
    // swiftlint:enable implicitly_unwrapped_optional
    
    override internal func setUp() {
        super.setUp()
        
        do {
            bot = try Application.testable()
        } catch {}
    }
    
    internal func testRouteInPostWithStartCommand() throws {
        let message = MessageRequest(message: Message(chat: Chat(id: 10), text: "/start this is a test", from: MessageSender(firstName: "Fabrizio")))
        let response = try bot.getResponse(to: "telegram/\(telegramSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: message, decodeTo: Response.self)
        
        XCTAssertEqual(response.chatID, 10)
        XCTAssertEqual(response.method, .sendMessage)
        XCTAssertEqual(response.text, """
        Welcome to SwiftyBot Fabrizio!
        To list all available commands type /help
        """)
    }
    
    internal func testRouteInPostWithHelpCommand() throws {
        let message = MessageRequest(message: Message(chat: Chat(id: 10), text: "/help this is a test", from: MessageSender(firstName: "Fabrizio")))
        let response = try bot.getResponse(to: "telegram/\(telegramSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: message, decodeTo: Response.self)
        
        XCTAssertEqual(response.chatID, 10)
        XCTAssertEqual(response.method, .sendMessage)
        XCTAssertEqual(response.text, """
        Welcome to SwiftyBot, an example on how to create a Telegram bot with Swift using Vapor.
        https://www.fabriziobrancati.com/SwiftyBot
        
        /start - Welcome message
        /help - Help message
        Any text - Returns the reversed message
        """)
    }
    
    internal func testRouteInPostWithUnknownCommand() throws {
        let message = MessageRequest(message: Message(chat: Chat(id: 10), text: "/test this is a test", from: MessageSender(firstName: "Fabrizio")))
        let response = try bot.getResponse(to: "telegram/\(telegramSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: message, decodeTo: Response.self)
        
        XCTAssertEqual(response.chatID, 10)
        XCTAssertEqual(response.method, .sendMessage)
        XCTAssertEqual(response.text, """
        Unrecognized command.
        To list all available commands type /help
        """)
    }
    
    internal func testRouteInPostWithSimpleText() throws {
        let message = MessageRequest(message: Message(chat: Chat(id: 10), text: "This is a test", from: MessageSender(firstName: "Fabrizio")))
        let response = try bot.getResponse(to: "telegram/\(telegramSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: message, decodeTo: Response.self)
        
        XCTAssertEqual(response.chatID, 10)
        XCTAssertEqual(response.method, .sendMessage)
        XCTAssertEqual(response.text, "tset a si Siht")
    }
    
    internal func testRouteInPostWithTextWithEmoji() throws {
        let message = MessageRequest(message: Message(chat: Chat(id: 10), text: "😁👍", from: MessageSender(firstName: "Fabrizio")))
        let response = try bot.getResponse(to: "telegram/\(telegramSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: message, decodeTo: Response.self)
        
        XCTAssertEqual(response.chatID, 10)
        XCTAssertEqual(response.method, .sendMessage)
        XCTAssertEqual(response.text, "👍😁")
    }
    
    internal func testRouteInPostWithEmptyText() throws {
        let message = MessageRequest(message: Message(chat: Chat(id: 10), text: "", from: MessageSender(firstName: "Fabrizio")))
        let response = try bot.getResponse(to: "telegram/\(telegramSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: message, decodeTo: Response.self)
        
        XCTAssertEqual(response.chatID, 10)
        XCTAssertEqual(response.method, .sendMessage)
        XCTAssertEqual(response.text, "I'm sorry but your message is empty 😢")
    }
}
