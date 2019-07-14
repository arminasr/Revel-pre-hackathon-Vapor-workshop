# Revel-pre-hackathon-Vapor-workshop
This repo contains Swift Vapor preparation guidelines and content for revel hackathon

## Prerequisites
  - [Xcode 9 or later](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
  - Swift 4.1 (We'll use Vapor 3. Vapor 4 is the latest version, it requires Swift 5.1)
  - [Postman](https://www.getpostman.com/downloads/)
  - Docker installed

## Installing Vapor Toolbox
- Vapor toolbox is a tool for creating, building, running Vapor projects.
- Generating Xcode projects
- Deploying projects with Vapor Cloud

### Checking status of prerequisites
```
eval "$(curl -sL check.vapor.sh)"
```
### Installing on macOS
```
brew install vapor/tap/vapor
```

### Installing on Linux
```
eval "$(curl -sL https://apt.vapor.sh)"
```

## Building first app


Create, Build and Start an app
```
vapor new VaporWorkshop
```

```
vapor build
```
```
vapor run
```

The template project is built and running on http://localhost:8080/hello

## Creating XCode project file, implementing custom routes

Stop the currently running app with Control-C

### Generate an XCode project file
```
vapor xcode -y
```

### Simple request examples
```Swift
router.get("hello", String.parameter) { req -> String in
    let name = try req.parameters.next(String.self)
    return "Hello, \(name)!"
}

//Accepting data
router.post(RevelThread.self, at: "thread") { req, data -> String in
    return "Thread with title: \(data.title) posted."
}

//Returning json
router.post(RevelThread.self, at: "thread") { req, data -> RevelThread in
    return data
}
```

## Configuring Database

**Choose from:**
- SQLite
- MySQL
- **PostgreSQL**

### Run the chosen DB in Docker
```
docker run --name postres -e POSTGRES_DB=vapor \-e POSTGRES_USER=vapor -e POSTGRES_PASSWORD=password \-p 5432:5432 -d postgres
```

Check status
```
docker ps
```

### Configure the app
- Package.swift
- ```vapor xcode -y```
- Configure.swift
- RevelThread.swift

### Async requests - Futures and Promises
In Vapor a promise to deliver the result at some point of time is called **Future**.
There are two main functions for dealing with unwrapping the result:

```Swift
flatMap(to:) // use when promise closure returns a Future
```
```Swift
map(to:) // use when promise closure returns a type other than Future
```

### CRUD database operations examples
```Swift
    router.post("api", "threads") { req -> Future<RevelThread> in
        return try req.content.decode(RevelThread.self)
            .flatMap(to: RevelThread.self) { thread in

            return thread.save(on: req)
        }
    }

    // get all threads
    router.get("api", "threads") { req -> Future<[RevelThread]> in
        return RevelThread.query(on: req).all()
    }

    // get single with parameter
    router.get("api", "threads", RevelThread.parameter) { req -> Future<RevelThread> in
        return try req.parameters.next(RevelThread.self)
    }

    // update
    router.put("api", "threads", RevelThread.parameter) { req -> Future<RevelThread> in
        return try flatMap(to: RevelThread.self,
                           req.parameters.next(RevelThread.self),
                           req.content.decode(RevelThread.self)) { acronym, updatedAcronym in
                            acronym.title = updatedAcronym.title
                            return acronym.save(on: req)
        }
    }

    // delete
    router.delete("api", "threads", RevelThread.parameter) { req -> Future<HTTPStatus> in
        return try req.parameters
            .next(RevelThread.self)
            .delete(on: req)
            .transform(to: HTTPStatus.noContent)
    }
```
