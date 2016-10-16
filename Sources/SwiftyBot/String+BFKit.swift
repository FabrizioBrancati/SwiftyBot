//
//  String+BFKit.swift
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2016 Fabrizio Brancati. All rights reserved.
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

// All the following code has been extracted from BFKit-Swift.
// https://github.com/FabrizioBrancati/BFKit-Swift
// Check the swift3.0 branch at /Sources/Extensions/Foundation/String+BFKit.swift file.

/// Import Swift Foundation framework.
import Foundation

/// This extesion adds some useful functions to String.
extension String {
    // MARK: - Instance functions -

    /// Returns string with the first character uppercased.
    ///
    /// - returns: Returns string with the first character uppercased.
    public func uppercaseFirst() -> String {
        return String(self.characters.prefix(1)).uppercased() + String(self.characters.dropFirst())
    }

    /// Returns the reversed String.
    ///
    /// - parameter preserveFormat: If set to true preserve the String format.
    ///                             The default value is false.
    ///                             **Example:**
    ///                                 "Let's try this function?" ->
    ///                                 "?noitcnuf siht yrt S'tel"
    ///
    /// - returns: Returns the reversed String.
    public func reversed(preserveFormat: Bool = false) -> String {
        guard !self.characters.isEmpty else {
            return ""
        }

        var reversed = String(self.removeExtraSpaces().characters.reversed())

        if !preserveFormat {
            return reversed
        }

        let words = reversed.components(separatedBy: " ").filter { $0 != "" }

        reversed.removeAll()
        for word in words {
            if word.hasUppercaseCharacter() {
                reversed += word.lowercased().uppercaseFirst() + " "
            } else {
                reversed += word.lowercased() + " "
            }
        }

        return reversed
    }

    /// Returns true if the String has at least one uppercase chatacter, otherwise false.
    ///
    /// - returns: Returns true if the String has at least one uppercase chatacter, otherwise false.
    public func hasUppercaseCharacter() -> Bool {
        if CharacterSet.uppercaseLetters.contains(self.unicodeScalars.last!) {
            return true
        }
        return false
    }

    /// Remove double or more duplicated spaces.
    ///
    /// - returns: Remove double or more duplicated spaces.
    public func removeExtraSpaces() -> String {
        let squashed = self.replacingOccurrences(of: "[ ]*", with: " ")
        return squashed ///.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        /// There is a Linux only bug here.
        /// The bot crashes every time an emoji is sent.
        /// Telegram trims every input, so we can skip trimming.
    }
}
