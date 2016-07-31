import Vapor

let workDir: String?
#if Xcode
    let parent = #file.characters.split(separator: "/").map(String.init).dropLast().joined(separator: "/")
    workDir = "/\(parent)/.."
#else
    workDir = nil
#endif

let drop = Droplet(workDir: workDir)

let token = drop.config["app", "token"].string ?? ""

drop.get("/") { request in
    let response = try Response(status: .ok, json: JSON([
        "status": "OK"
    ]))

    return response
}

/**
    Here's an example of using type-safe routing to ensure
    only requests to "posts/<some-integer>" will be handled.

    String is the most general and will match any request
    to "posts/<some-string>". To make your data structure
    work with type-safe routing, make it StringInitializable.

    The User model included in this example is StringInitializable.

drop.get("posts", Int.self) { request, postId in
    return "Requesting post with ID \(postId)"
}
*/

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
