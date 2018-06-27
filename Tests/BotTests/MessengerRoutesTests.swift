//
//  MessengerRoutesTests.swift
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

/// Messenger Routes Tests.
internal class MessengerRoutesTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    internal var bot: Application!
    // swiftlint:enable implicitly_unwrapped_optional
    
    override internal func setUp() {
        super.setUp()
        
        do {
            bot = try Application.testable()
        } catch {}
    }
    
    internal func testRouteInGetWithActivation() throws {
        let activation = Activation(mode: "subscribe", verifyToken: messengerSecret, challenge: "Test Challenge")
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .GET, headers: ["Content-Type": "application/json"], data: activation, decodeTo: String.self)

        XCTAssertEqual(response, "Test Challenge")
    }
    
    internal func testRouteInGetWithWrongActivation() throws {
        let activation = Activation(mode: "Test", verifyToken: messengerToken, challenge: "Test Challenge")
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .GET, headers: ["Content-Type": "application/json"], data: activation, decodeTo: ErrorResponse.self)
        
        XCTAssertTrue(response.error)
        XCTAssertEqual(response.reason, "Missing Messenger verification data.")
    }
    
    internal func testRouteInPostWithSimpleText() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Test"), postback: nil, sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "10")
        XCTAssertEqual(response.message, .text("Tset"))
    }
    
    internal func testRouteInPostWithTextWithEmoji() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "😁👍"), postback: nil, sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "10")
        XCTAssertEqual(response.message, .text("👍😁"))
    }
    
    internal func testRouteInPostWithGreetings() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Hi!"), postback: nil, sender: Sender(id: "1366898573"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "1366898573")
        XCTAssertEqual(response.message, .text("""
        Hi Fabrizio!
        This is an example on how to create a bot with Swift.
        If you want to see more try to send me "buy", "sell" or "shop".
        """))
    }
    
    internal func testRouteInPostWithEmptyText() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: ""), postback: nil, sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "10")
        XCTAssertEqual(response.message, .text("I'm sorry but your message is empty 😢"))
    }
    
    internal func testRouteInPostWithStructuredResponse() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Sell"), postback: nil, sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "10")
        XCTAssertEqual(response.message, .structured(StructuredMessage(attachment: Attachment(type: .template, payload: Payload(templateType: .generic, elements: [
            Element.queuer,
            Element.bfkitSwift,
            Element.bfkit,
            Element.swiftyBot
        ])))))
    }
    
    internal func testRouteInPostWithWrongObject() throws {
        let pageRequest = PageRequest(object: "Test", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Test"), postback: nil, sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: ErrorResponse.self)
        
        XCTAssertTrue(response.error)
        XCTAssertEqual(response.reason, "Message not generated by a page.")
    }
    
    internal func testRouteInPostWithGetStartedPayload() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Test"), postback: Postback(payload: GetStarted.defaultPayload), sender: Sender(id: "1366898573"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "1366898573")
        XCTAssertEqual(response.message, .text("""
        Hi Fabrizio!
        This is an example on how to create a bot with Swift.
        If you want to see more try to send me "buy", "sell" or "shop".
        """))
    }
    
    internal func testRouteInPostWithSwiftyBotPayload() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Test"), postback: Postback(payload: "SwiftyBot pressed"), sender: Sender(id: "1366898573"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "1366898573")
        XCTAssertEqual(response.message, .text("SwiftyBot pressed"))
    }
    
    internal func testRouteInPostWithEmptyPayload() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: Message(text: "Test"), postback: Postback(payload: nil), sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "10")
        XCTAssertEqual(response.message, .text("No payload provided by developer."))
    }
    
    internal func testRouteInPostWithEmptyMessage() throws {
        let pageRequest = PageRequest(object: "page", entries: [PageEntry(messages: [PageMessage(message: nil, postback: nil, sender: Sender(id: "10"))])])
        let response = try bot.getResponse(to: "messenger/\(messengerSecret)", method: .POST, headers: ["Content-Type": "application/json"], data: pageRequest, decodeTo: Response.self)
        
        XCTAssertEqual(response.messagingType, .response)
        XCTAssertEqual(response.recipient?.id, "10")
        XCTAssertEqual(response.message, .text("Webhook received unknown event."))
    }
}
