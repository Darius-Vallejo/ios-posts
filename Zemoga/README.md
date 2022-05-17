
# Zemoga

A Swift iOS app showcasing my basic software skills building an iOS product. 




## Features

- Data models decoded by Codable
- URL Sesssions with Combine for REST API
- Using Viper as Architecture pattern
- Protocol-Oriented Programming for handling different type of sections and different models
- Generic implementations for Services
- Services as a Singleton

### VIPER

The architecture of a software system is the shape given it by those who build it. The purpose of that shape is to facilitate development, 
deployment, operation and maintenance.
VIPER offers an alternative to the common belief that all of the app logic should go into the View and can be used in conjunction with UIKit and Combine
to help build apps with a clean architecture that effectively separates the different responsibilities required, such as the user interface, business logic,
data storage and networking. These are then easier to test, maintain and expand.
![VIPER](https://koenig-media.raywenderlich.com/uploads/2020/02/viper.png)
Many implementations of VIPER has multiple references bettween layers but it is posible to avoid this kinda smell code by using reactive Features
when interactor exposes a publisher. 
![Custom Viper](https://miro.medium.com/max/1400/1*teuZSPaiqDrm63HBEReX3g.png)

You can see DetailInteractor and PostsInteractor in order to know more about the way to report changes to presenter via CurrentValueSubject.
## Getting Started

You can get started with Run project immediately on the xcode. This project doesn't need external dependencies or a package installation.
URLSession has good convergence with Combine and there was no complex calls for accessing content via HTTP so that's the reason for handling REST API with URLSession instead of Alamofire.

## Tests

Tests are the best way to avoid issues after any update for the bisness logic. This project has only two interactors so 
I focused my UnitTesting on PostsInteractor as unit of work for posts. 

I implemented the bests practices for the nomenclature of every unit of work presented, and all the tests were implemented as 
state-based with stubs. 

This is a brief summary of nomenclature structure: UnitOfWorkName_ScenarioUnderTest_ExpectedBehavior
Additionally, it is worth it to explain that state-based testing is about checking noticiable behavior changes in the system under test 
after changing its state. 

These practices are explained in [Art of unit testing by Osherove](https://www.artofunittesting.com/)

## Pending TODOs

- Use core data
- Use Repository Pattern through interactor
- Unit tests for the DetailInteractor's business logic

