
import Vapor

let drop = Droplet()

let secret = drop.config["app", "secret"].string ?? ""

drop.post(secret) { request in
    let chatID = request.data["message", "chat", "id"].int ?? 0
    let message = request.data["message", "text"].string ?? ""
    
    var response: String = ""
    
    if message.hasPrefix("/") {
        switch message {
        case "/start":
            response = "Welcome to SwiftyBot!\n" +
                       "To list all available commands type /help"
        case "/help":
            response = "Welcome to SwiftyBot, an example on how create a Telegram Bot in Swift with Vapor.\n" +
                       "https://www.fabriziobrancati.com/blog\n\n" +
                       "/start - Welcome message\n" +
                       "/help - Help message\n" +
                       "Any text - Reversed"
        default:
            response = "Unrecognized command.\n" + 
                       "To list all available commands type /help"
        }
    } else {
        response = String(message.characters.reversed())
    }
    
    return try JSON(
        [
            "method": "sendMessage",
            "chat_id": chatID,
            "text": response
        ]
    )
}

drop.serve()
