#if os(Linux)

@testable import BFKitTests
import XCTest

XCTMain([
    testCase(BotTests.allTests),
    testCase(TelegramTests.allTests),
    testCase(MessengerTests.allTests),
    testCase(SwiftyBotTests.allTests)
])

#endif
