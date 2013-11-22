# Phoenix Cmd: A DeftJS Example Application using Sencha Cmd (4.0.1.45)

## Introduction

This example application is virtually identical to the [Phoenix Example App](https://github.com/deftjs/Examples/tree/master/phoenix-example-app), except that it is built using Sencha Cmd. It's a simple version of a disaster recovery planning tool.

For a full description of using Deft JS with Sencha Cmd, please refer to the wiki page [Adding Deft JS to Your Application](https://github.com/deftjs/DeftJS/wiki/Adding-Deft-JS-to-Your-Application).

## Application Highlights

The application demonstrates a wide range of Deft JS features, including:

* Building a Deft JS application using Sencha Cmd
* An architecture which uses models, views, ViewControllers, services, and stores
* Application configuration class (AppConfig)
* Application initialization and data loading at startup
* Injector and dependency provider setup
* Dependency injection (with inherited injections)
* Use of ViewControllers to handle view events and encapsulate UI-related logic
* Use of the Observe feature within ViewControllers
* Creation of multiple instances of the same views, each with their own ViewController and state
* Use of Promises
* Use of sequential and parallel Promise chains
* Use of Contexts to facilitate communication between ViewControllers


## Running the App

Drop the application into a local web server and load up the index.html page in a current browser that supports client storage. You can add new scenarios, add affected items to scenarios, and edit or delete affected items and scenarios. Multiple scenarios can be opened and edited at the same time.