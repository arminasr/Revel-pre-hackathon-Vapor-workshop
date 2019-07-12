# Revel-pre-hackathon-Vapor-workshop
This repo contains Swift Vapor preparation guidelines and content for revel hackathon

## Prerequisites
  - Xcode 9 or later
  - Swift 4.1 (We'll use Vapor 3. Vapor 4 is the latest version, it requires Swift 5.1)

## Installing Vapor Toolbox
- Vapor toolbox is a tool for creating, building, running Vapor projects.
- Generating Xcode projects
- Deploying projects with Vapor Cloud

### Checking status of prerequisites
```
eval "$(curl -sL check.vapor.sh)"
```
### Installing on macOS
We are focusing on development on macOS environment, using XCode. Vapor 3 works on linux as well, installation process is slightly different tho.
```
brew install vapor/tap/vapor
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

The template project is built and running on https://localhost:8080/hello

## Creating XCode project file, implementing custom routes

Stop the currently running app with Control-C

### Generate an XCode project file
```
vapor xcode -y
```
