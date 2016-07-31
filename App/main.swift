import Vapor

let drop = Droplet()

let secret = drop.config["app", "secret"].string ?? ""

drop.get("/") { request in
    let response = try Response(status: .ok, json: JSON([
        "status": "OK"
    ]))

    return response
}

drop.get(secret) { request in
    let response = try Response(status: .ok, json: JSON([
        "status": "OK",
        "token": "OK"
    ]))

    return response
}

drop.get(secret, String.self) { request, method in
    let response = try Response(status: .ok, json: JSON([
        "status": "OK",
        "token": "OK",
        "method": method
    ]))

    return response
}

drop.post(secret) { request in
    let chatID = request.data["message", "chat", "id"].int ?? 0
    let text = request.data["message", "text"].string ?? ""

    let response = try Response(status: .ok, json: JSON([
        "chat_id": chatID,
        "text": text,
        "method": "sendMessage"
    ]))

    return response
}

drop.serve()
