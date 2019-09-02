import Vapor
import Leaf
import FluentMySQL

/// Called before your application initializes.
public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services
) throws {

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    let leafProvider = LeafProvider()
    try services.register(leafProvider)
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)

    try services.register(FluentMySQLProvider())  // changed
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "192.168.1.84", //localhost
        port: 3306,
        username: "root",
        password: "",
        database: "vapor",
        transport: MySQLTransportConfig.unverifiedTLS
    )
    services.register(mysqlConfig)
    
//    var databases = DatabasesConfig()
//    let dbConfig = MySQLDatabaseConfig(
//        hostname: "localhost",
//        port: 3306,
//        username: "root",
//        password: "",
//        database: "vapor",
//        transport: MySQLTransportConfig.unverifiedTLS
//    )
//    let database = MySQLDatabase(config: dbConfig)
//    databases.add(database: database, as: .mysql)
//    databases.enableLogging(on: .mysql)
//    services.register(databases)
    
//    var databases = DatabasesConfig()
//    try databases.add(database: SQLiteDatabase(storage: .memory), as: .sqlite)
//    services.register(databases)

    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .mysql)
    services.register(migrations)
}
