# <img src="https://github.com/user-attachments/assets/efc2952a-bb49-47fa-94e9-593c8a6526f0" alt="logo" width="70" align="center"> BrewMobil
  This project is a Flutter application following the Clean Architecture design pattern and MVVM (Model-View-ViewModel), inspired by the Flutter Advanced Course - Clean Architecture With MVVM by Mina Farid on Udemy.

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Architecture](#architecture)
4. [Technologies and Packages](#technologies-and-packages)
5. [Screenshots](#screenshots)
6. [Credits](#credits)

## Overview
  This app demonstrates the Clean Architecture design pattern in Flutter, with the separation of concerns between different layers: Data, Domain, and Presentation. It provides a scalable, testable, and maintainable code structure.

## Features
- State Management using Stream Controller and RX Dart
- Full MVVM Pattern:
- ViewModel Inputs and Outputs
- Base ViewModel and Base UseCase
- Multiple UI States managed via State Renderer (Full screen and popup states)
- Localization with support for English and Persian (RTL - LTR)
- Remote Data Source with API integration
- Local Data Source for caching
- Dependency Injection and Repository pattern implementation
- Mock APIs for testing
- Responsive UI with SVG and JSON Animations

## Architecture
  The project follows Clean Architecture with clear separations between:

- Presentation Layer: UI components (Splash, Onboarding, Login, etc.), state rendering, and localization.
- Domain Layer: Business logic with UseCases, Repository interfaces, and models.
- Data Layer: API calls, caching, and data transformation (using mappers and the toDomain concept).
### Layer Breakdown:
1. Data Layer:
- API Client with interceptor and JSON serialization.
- Caching with a local data source.
- Mappers to convert API responses to domain models.

2. Domain Layer:
- UseCases to handle business logic.
- Either concept for handling success (Right) and failure (Left) cases.

3. Presentation Layer:
- State Management with RX Dart and Stream Builder.
- State Renderer to handle loading, success, and error states.

## Technologies and Packages
- Flutter and Dart
- RX Dart for state management.
- Retrofit for HTTP requests.
- Lottie for JSON animations.
- GetIt for dependency injection.
- 18 Flutter packages in total (JSON, SVG, animations, etc.)

## Screenshots
<img src="https://github.com/user-attachments/assets/7a8b6953-be9a-4cac-80e7-a7ba50dd1034" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/32416526-1193-4381-a6fe-ebaea96b5ea6" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/3fcbfc17-90bf-48b9-9e6e-a863e5b6a8dd" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/383f5582-ffd8-4709-a7bf-afd13ef9a72a" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/eaec762d-26dd-4a20-8732-60233be7b1e4" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/37a7bb46-6378-4bdd-a643-8aaa4c975796" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/6176d565-5bb6-4a24-8ec2-246ffd30d3bb" alt="Home" width="200">
<img src="https://github.com/user-attachments/assets/2bca7f5f-d018-4638-95d7-08d0e9e2d842" alt="Home" width="200">

## Credits
  This project was created following the [Flutter Advanced Course - Clean Architecture With MVVM by Mina Farid on Udemy](https://www.udemy.com/course/flutter-advanced-course-clean-architecture-with-mvvm/?couponCode=LETSLEARNNOWPP).
