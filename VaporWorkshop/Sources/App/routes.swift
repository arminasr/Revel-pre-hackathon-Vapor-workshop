import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    //MARK: Simple request examples
        router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        
        return "Hello, \(name)!"
        }
    
    //MARK: CRUD database operations examples
}
