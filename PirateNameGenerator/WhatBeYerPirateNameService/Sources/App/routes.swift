import Vapor
import Redis

func routes(_ app: Application) throws {
    let pirateNameGenerator = PirateNameGenerator(pirateDataSource: InMemoryPirateDataSource())
    
    app.get("pirate-name", ":firstName") { req -> String in
        let firstName = req.parameters.get("firstName")!
        return pirateNameGenerator.forFirstName(firstName)
    }
    
    app.get("pirate-name", ":firstName", ":lastName") { req -> String in
        let firstName = req.parameters.get("firstName")!
        let lastName = req.parameters.get("lastName")!
        return pirateNameGenerator.forFullName(firstName: firstName, lastName: lastName)
    }
    
    app.get("**") { req in
        return "Be you lost, matey?"
    }
}
