# FriendsList
# Friends List App

## Overview

The **Friends List App** is a modern iOS application designed with clean, maintainable code practices. It leverages key programming principles and architectural patterns to ensure flexibility, testability, and performance. 

## Key Features

- **MVVM Architecture**: The app is structured using the Model-View-ViewModel pattern to ensure a clear separation of concerns and enhance testability.
- **OOP (Object-Oriented Programming)**: The app design is rooted in OOP principles, focusing on encapsulation, inheritance, and polymorphism.
- **SOLID Principles**: The project adheres to SOLID principles, promoting scalability, maintainability, and reduced code dependencies.
- **POP (Protocol-Oriented Programming)**: Protocols are heavily used for abstraction and ensuring flexible, reusable components across the app.
- **Unit Testing**: Thorough unit tests are implemented for critical components, ensuring reliability and minimizing bugs in the production environment.
- **Generic Network Manager**: A generic and reusable network layer is implemented to handle API requests and responses efficiently.
- **Realm for Cache**: The app uses Realm to cache data locally, providing offline functionality and quicker data access.
- **Closures**: Utilizes closures for callbacks in asynchronous operations, such as network requests and data fetching.
- **Enums**: Enums are used to define clear, type-safe options for various states and actions across the app.
- **Extensions**: Extensions are employed to add functionality to existing classes, structs, and other types without modifying their original implementations.

## Technologies Used

- **Swift**: The primary programming language used in the development.
- **Realm**: Used for local database storage and caching mechanisms.
- **XCTest**: Unit testing framework integrated into the app to ensure code quality.

## Design and Architecture

### MVVM (Model-View-ViewModel)
The app follows the MVVM design pattern, where:
- **Model**: Represents the data layer (both API and Realm data sources).
- **View**: Displays data to the user and forwards user inputs to the ViewModel.
- **ViewModel**: Handles business logic, transforming data from the model and preparing it for the view.

### Protocol-Oriented Programming (POP)
Protocols are used extensively to decouple the business logic from specific implementations. Key components like the `RandomUserManager` and `RealmManager` are built as protocols to allow mockable and interchangeable implementations, facilitating easy unit testing.

### SOLID Principles
The app adheres to SOLID principles:
- **S**: Single Responsibility - Each class and component has one well-defined responsibility.
- **O**: Open/Closed - The code is open for extension but closed for modification through the use of protocols and extensions.
- **L**: Liskov Substitution - Subclasses or implementations can replace their parent classes without affecting the functionality.
- **I**: Interface Segregation - Classes implement only the protocols they need, avoiding large, monolithic interfaces.
- **D**: Dependency Inversion - High-level modules depend on abstractions rather than concrete implementations.

### Generic Network Manager
The network manager is generic and handles various API calls in a reusable and efficient way. It abstracts the networking logic, allowing data fetching and error handling to be easily managed across different endpoints.

## Caching with Realm

The app uses **Realm** to cache API data locally. This improves performance by avoiding unnecessary network calls and provides offline capabilities. The Realm cache is updated whenever new data is fetched from the API, ensuring data consistency.

## Unit Testing

