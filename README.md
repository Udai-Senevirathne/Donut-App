# 🍩 Donut App

A modern Flutter application featuring Firebase authentication and a beautiful donut-themed UI. This app demonstrates clean architecture patterns using BLoC state management and provides a seamless user experience for donut enthusiasts.

## ✨ Features

- 🔐 **Firebase Authentication**
  - User registration and login
  - Password reset functionality
  - Secure logout
  - Real-time authentication state management

- 🎨 **Beautiful UI/UX**
  - Modern Material Design 3
  - Donut-themed visual elements
  - Responsive layouts for all screen sizes
  - Smooth animations and transitions

- 🏗️ **Clean Architecture**
  - BLoC pattern for state management
  - Repository pattern for data handling
  - Separation of concerns
  - Testable code structure

- 📱 **Cross-Platform Support**
  - Android
  - iOS
  - Web
  - Windows
  - macOS
  - Linux

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

### Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication with Email/Password provider
3. Download configuration files:
   - `google-services.json` for Android → place in `android/app/`
   - `GoogleService-Info.plist` for iOS → place in `ios/Runner/`

> **Note:** These configuration files are not included in the repository for security reasons.

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Udai-Senevirathne/Donut-App.git
   cd Donut-App/donut_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add Firebase configuration files** (see Firebase Setup section above)

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

*Coming soon 

## 🏗️ Architecture

This app follows clean architecture principles:

```
lib/
├── bloc/                 # Business Logic Components
│   ├── auth_bloc.dart   # Authentication state management
│   ├── auth_repository.dart # Authentication data layer
│   └── home_bloc.dart   # Home screen state management
├── screens/             # UI Screens
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── home_screen.dart
├── widgets/             # Reusable UI Components
│   └── password_reset_dialog.dart
└── main.dart           # App entry point
```

## 🔧 Dependencies

### Core Dependencies
- `flutter_bloc: ^8.1.6` - State management
- `equatable: ^2.0.7` - Value equality
- `firebase_core: ^3.14.0` - Firebase core functionality
- `firebase_auth: ^5.6.0` - Firebase authentication

### Dev Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Linting rules

## 🎯 Available Scripts

```bash
# Run the app in debug mode
flutter run

# Run the app in release mode
flutter run --release

# Run tests
flutter test

# Build APK for Android
flutter build apk

# Build app bundle for Android
flutter build appbundle

# Build for iOS
flutter build ios

# Build for web
flutter build web

# Analyze code
flutter analyze

# Format code
dart format .
```

## 🔐 Security Features

- Firebase configuration files are excluded from version control
- Secure authentication flow
- Password reset functionality
- Input validation and sanitization
- Error handling for authentication failures

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Udai Senevirathne**
- GitHub: [@Udai-Senevirathne](https://github.com/Udai-Senevirathne)

---

<div align="center">
  <p>Made with ❤️ and Flutter</p>
  <p>🍩 Enjoy your donuts! 🍩</p>
</div>
