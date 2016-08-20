import Vapor

/// Create the Droplet.
let drop = Droplet()

/// Read the secret key from Config/secrets/app.json.
let secret = drop.config["app", "secret"].string ?? ""

/// Setting up the POST request with the secret key.
/// With a secret path to be sure that nobody else knows that URL.
/// https://core.telegram.org/bots/api#setwebhook
drop.post(secret) { request in
    /// The chat ID from the request JSON.
    let chatID = request.data["message", "chat", "id"].int ?? 0
    /// The message text from the request JSON.
    let message = request.data["message", "text"].string ?? ""

    /// Let's prepare the response message text.
    var response: String = ""

    /// Check if the message is a Telegram command.
    if message.hasPrefix("/") {
        /// Check what type of command is.
        switch message {
        /// Start command "/start".
        case "/start":
            /// Set the response message text.
            response = "Welcome to SwiftyBot!\n" +
                       "To list all available commands type /help"
        /// Help command "/help".
        case "/help":
            /// Set the response message text.
            response = "Welcome to SwiftyBot" +
                       "an example on how create a Telegram Bot in Swift with Vapor.\n" +
                       "https://www.fabriziobrancati.com/blog\n\n" +
                       "/start - Welcome message\n" +
                       "/help - Help message\n" +
                       "Any text - Reversed"
        /// Command not valid.
        default:
            /// Set the response message text and suggest to type "/help".
            response = "Unrecognized command.\n" +
                       "To list all available commands type /help"
        }
    /// It isn't a Telegram command, so creates a reversed message text.
    } else {
        /// Set the response message text.
        response = message.reversed(preserveFormat: true)
    }

    /// Create the JSON response.
    /// https://core.telegram.org/bots/api#sendmessage
    return try JSON(
        [
            "method": "sendMessage",
            "chat_id": chatID,
            "text": response
        ]
    )
}

/// Serve the Droplet.
drop.serve()
