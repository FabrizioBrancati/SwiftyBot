import Vapor

let drop = Droplet()

let secret = drop.config["app", "secret"].string ?? ""

drop.post(secret) { request in
    let chatID = request.data["message", "chat", "id"].int ?? 0
    let message = request.data["message", "text"].string ?? ""
    
    var responseMessage: String = ""
    
    if message.hasPrefix("/") {
        switch message {
        case "/start":
            responseMessage = "Welcome to SwiftyBot"
        }
    }
    
    return try JSON(
        [
            "method": "sendMessage",
            "chat_id": chatID,
            "text": responseMessage
        ]
    )
}

drop.serve()
