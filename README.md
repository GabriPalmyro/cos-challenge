# COS Challenge - Car Search Flutter App

> **Technical Test for Car on Sale MidLevel Flutter Engineer Role**

A Flutter application for searching and managing car information using VIN (Vehicle Identification Number) lookup. I developed this project as a technical assessment to demonstrate my Flutter development skills, showcasing clean architecture, state management, and local caching capabilities.

## 📱 Demo

<img src="example/example.gif" alt="App Demo" width="300">

## 🚗 Features

### Core Functionality

- **VIN Search**: Search for car information using 17-character VIN codes
- **Car Details**: View comprehensive car information including make, model, price, and auction details
- **Similar Cars**: Display similar cars when multiple matches are found
- **Local Caching**: Offline access to previously searched cars using Hive database
- **User Authentication**: Secure login system with email validation
- **Search History**: Access to previously searched vehicles

### Technical Features

- **Clean Architecture**: Domain-driven design with clear separation of concerns
- **State Management**: BLoC pattern for predictable state management
- **Dependency Injection**: Injectable pattern for loose coupling
- **Local Storage**: Hive for efficient local data persistence
- **Input Validation**: VIN format validation and form validation
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Responsive Design**: Adaptive UI for different screen sizes

## 🏗️ Architecture

I implemented this project following **Clean Architecture** principles with the following structure:

```
lib/
├── app/
│   ├── common/           # Shared utilities and services
│   │   ├── auth/         # Authentication logic
│   │   ├── client/       # HTTP client configuration
│   │   ├── local_database/ # Hive database setup
│   │   └── router/       # Navigation routing
│   ├── core/             # Core business logic
│   │   ├── errors/       # Error handling
│   │   ├── extensions/   # Dart extensions
│   │   ├── types/        # Type definitions
│   │   └── validators/   # Input validators
│   ├── design/           # Design system and UI components
│   │   ├── colors/       # Color palette
│   │   ├── components/   # Reusable UI components
│   │   ├── spacing/      # Layout spacing constants
│   │   └── tokens/       # Design tokens
│   └── features/         # Feature modules
│       ├── home/         # Car search feature
│       ├── login/        # Authentication feature
│       └── splash/       # App initialization
```

### Layer Responsibilities

- **Presentation Layer**: UI components, pages, and state management (Cubits)
- **Domain Layer**: Business logic, use cases, and entity definitions
- **Data Layer**: Repositories, data sources, and model implementations

## 🛠️ Tech Stack

### Core Dependencies

- **Flutter SDK**: `3.27.1`
- **Dart**: `3.6.0`

### State Management

- **flutter_bloc**: `^9.1.1` - BLoC pattern implementation
- **bloc**: `^9.0.0` - Core BLoC library
- **equatable**: `^2.0.7` - Value equality

### Dependency Injection

- **get_it**: `^8.0.3` - Service locator
- **injectable**: `^2.5.0` - Code generation for DI

### Local Storage

- **hive_flutter**: `^1.1.0` - Local database
- **hive**: `^2.2.3` - NoSQL database

### Network

- **http**: `^1.4.0` - HTTP client

### Development Dependencies

- **build_runner**: `^2.4.15` - Code generation
- **injectable_generator**: `^2.6.2` - DI code generation
- **hive_generator**: `^2.0.1` - Hive adapters generation

### Testing

- **flutter_test**: SDK - Unit testing framework
- **bloc_test**: `^10.0.0` - BLoC testing utilities
- **mocktail**: `^1.0.4` - Mocking library
- **integration_test**: SDK - Integration testing

## 🚀 Getting Started

### Prerequisites

- Flutter SDK `3.27.1`
- Dart SDK `3.6.0`
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/GabriPalmyro/cos-challenge
   cd cos_challenge
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

### Setup for Development

1. **Configure your IDE**
   - Install Flutter and Dart plugins
   - Configure code formatting and linting

## 📱 Usage

### VIN Search

1. **Login**: Enter your name and email to authenticate
2. **Search**: Enter a 17-character VIN code in the search field
3. **View Results**: See detailed car information or similar cars
4. **History**: Access previously searched cars from the cache

### VIN Format

- Must be exactly 17 characters
- Contains letters and numbers only
- Excludes letters I, O, and Q to avoid confusion
- Example: `1HGBH41JXMN109186`

### Error Handling

The app handles various scenarios:

- **Invalid VIN**: Format validation with user feedback
- **Network Issues**: Graceful degradation with cached results
- **No Results**: Clear messaging when no cars are found
- **Multiple Results**: Modal display for similar cars

## 🧪 Testing

### Running Tests

```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Test specific files
flutter test test/features/home/
```

### Test Structure

- **Unit Tests**: Business logic and use cases
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end user flows
- **BLoC Tests**: State management testing

## 🔧 Configuration

### Environment Setup

The app uses a centralized client configuration in `CosChallenge` class:

```dart
class CosChallenge {
  static const vinLength = 17;
  static const user = 'x-user';
  static final httpClient = http.Client();
}
```

### Local Database

Hive is configured for local storage with type adapters for:

- User information
- Car data caching
- Search history

## 📦 Build and Deployment

### 1. `build-apk.yml` - Simple APK Build

- **Triggers**: Push/PR to main branch, manual dispatch
- **Purpose**: Basic APK build with tests
- **Outputs**: Single release APK

### Android

```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

### iOS

```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release
```

### Web

```bash
flutter build web
```
