import Vapor
import Messenger

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register routes to the router.
    let router = EngineRouter.default()
    try Messenger.routes(router)
    services.register(router, as: Router.self)

    /// Register middleware.
    /// Create _empty_ middleware config.
    var middlewares = MiddlewareConfig()
    /// Catches errors and converts to HTTP response.
    middlewares.use(ErrorMiddleware.self)
    /// Register middlewares to services.
    services.register(middlewares)
}
