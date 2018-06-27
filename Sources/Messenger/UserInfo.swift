//
//  UserInfo.swift
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
import Vapor

/// Messenger User Info response.
public struct UserInfo: Codable, Equatable {
    /// User first name.
    public private(set) var firstName: String
    /// User locale.
    public private(set) var id: String
    
    /// Coding keys, used by Codable protocol.
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
    }
    
    /// Creates a User Info object.
    ///
    /// - Parameters:
    ///   - id: User ID used for the request.
    ///   - httpRequest: Request to be used as client.
    public init?(id: String, on request: Request) {
        /// Requests for user infos.
        let userInfoFuture = try? request.client().get("https://graph.facebook.com/\(messengerAPIVersion)/\(id)?fields=id,first_name&access_token=\(messengerToken)").map(to: UserInfo.self) { response in
            return try response.content.syncDecode(UserInfo.self)
        }
        
        /// Catch the error here to not propagate it.
        do {
            /// Let's wait for the response, since the user first name is part of the bot response.
            guard let userInfo = try userInfoFuture?.wait() else {
                return nil
            }
        
            self = userInfo
        } catch {
            return nil
        }
    }
}
