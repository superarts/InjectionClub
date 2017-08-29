Title: Introducing Dependency Injection
Audience Level: Intermediate
Style: Core Concept
Prerequisites: Interface-based Programming, SOLID Principles
Most important concepts: Dependency Inversion Principle, Dependency Injection
Sample app name: Swine Reader
Sample app description: An app with no UI shows how to design data model interfaces, and using DI with mock classes to tests

  * Introduction
  * Let's quickly review the Dependency Inversion Princinple [Theory]
    * What is Dependency Inversion and Inversion of Control
    * Dependency Injection is an important implementation
  * Basic example of DI [Instruction]
    * Oh no! Another project without design and backend ready
    * System design: Avatar and User as its author
    * Creating Protocols as interfaces
    * Writing tests
    * Creating mock classes & test
  * Adding Swinject as our DI framework [Theory & Instruction]
    * Why we need a DI framework [Theory]
    * Introducing DI framework Swinject
    * DI Container
    * Adding Swinject to our project
    * Rewriting and adding more tests
    * Implementing mockup UI
  * Circular Dependencies [Theory & Instruction]
    * Constructor injection and setter injection [Theory]
    * Example: User with avatar and Avatar with author
    * Interface, tests, and mock implementation
  * Where To Go From Here?
    * Other features of Swinject
    * Other DI frameworks for iOS