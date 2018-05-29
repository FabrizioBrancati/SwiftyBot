#if os(Linux)

import XCTest
@testable import BFKitTests

XCTMain([
    testCase(BotTests.allTests),
    testCase(TelegramTests.allTests),
    testCase(MessengerTests.allTests),
    testCase(SwiftyBotTests.allTests)
])

#endif
