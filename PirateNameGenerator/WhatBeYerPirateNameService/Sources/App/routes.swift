import Vapor

func routes(_ app: Application) throws {
    let pirateNameGenerator = PirateNameGenerator(pirateDataSource: InMemoryPirateDataSource())
    
    app.get("pirate-name", ":firstName") { req throws -> String in
        let firstName = req.parameters.get("firstName")!
        return try pirateNameGenerator.forFirstName(firstName)
    }
    
    app.get("pirate-name", ":firstName", ":lastName") { req throws -> String in
        let firstName = req.parameters.get("firstName")!
        let lastName = req.parameters.get("lastName")!
        return try pirateNameGenerator.forFullName(firstName: firstName, lastName: lastName)
    }
    
    app.get("**") { req throws -> String in
        throw Abort(.notFound, reason: "Be you lost, matey?")
    }
}
