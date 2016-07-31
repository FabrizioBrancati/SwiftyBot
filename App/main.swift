import Vapor

let workDir: String?
#if Xcode
    let parent = #file.characters.split(separator: "/").map(String.init).dropLast().joined(separator: "/")
    workDir = "/\(parent)/.."
#else
    workDir = nil
#endif

let drop = Droplet(workDir: workDir)

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
    let chatID = request.data["message", "chat", "id"].int
    let text = request.data["message", "text"].string

    let response = try Response(status: .ok, json: JSON([
        "chat_id": chatID,
        "text": text!,
        "method": "sendMessage"
    ]))

    return response
}

/**
    Add Localization to your app by creating
    a `Localization` folder in the root of your
    project.

    /Localization
       |- en.json
       |- es.json
       |_ default.json

    The first parameter to `app.localization` is
    the language code.

drop.get("localization", String.self) { request, lang in
    return JSON([
        "title": drop.localization[lang, "welcome", "title"],
        "body": drop.localization[lang, "welcome", "body"]
    ])
}
*/

let port = drop.config["app", "port"].int ?? 80

drop.serve()
