# Firebase Authentication Setup Guide

This guide will help you set up Firebase Authentication for your Donut App.

## Prerequisites

1. Flutter SDK installed
2. Android Studio/Xcode for mobile development
3. A Google account for Firebase Console access

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter your project name (e.g., "donut-app")
4. Follow the setup wizard (you can disable Google Analytics if not needed)

## Step 2: Add Firebase to Your Flutter App

### For Android:

1. In the Firebase Console, click "Add app" and select Android
2. Enter your package name: `com.example.donut_app`
3. Download the `google-services.json` file
4. Replace the placeholder `google-services.json` file in `android/app/` with your downloaded file

### For iOS:

1. In the Firebase Console, click "Add app" and select iOS
2. Enter your bundle ID: `com.example.donutApp`
3. Download the `GoogleService-Info.plist` file
4. Replace the placeholder `GoogleService-Info.plist` file in `ios/Runner/` with your downloaded file

## Step 3: Enable Authentication

1. In the Firebase Console, go to "Authentication" → "Sign-in method"
2. Enable "Email/Password" authentication
3. Optionally enable other sign-in methods as needed

## Step 4: Test the App

1. Run `flutter pub get` to ensure all dependencies are installed
2. Run the app with `flutter run`
3. Try creating a new account or logging in

## Features Implemented

- ✅ Email/Password Authentication
- ✅ User Registration
- ✅ User Login
- ✅ User Logout
- ✅ Authentication State Management with BLoC
- ✅ Password Reset (ready to implement)
- ✅ Real-time Auth State Changes

## Password Reset Implementation

The password reset functionality is ready to be implemented. To add a "Forgot Password" button to your login screen, you can dispatch the `PasswordResetRequested` event:

```dart
BlocProvider.of<AuthBloc>(context).add(
  PasswordResetRequested(emailController.text),
);
```

## Security Rules

Make sure to configure your Firebase Security Rules appropriately for your app's needs.

## Troubleshooting

1. **Build errors**: Make sure you have the correct `google-services.json` and `GoogleService-Info.plist` files
2. **Authentication not working**: Check that Email/Password authentication is enabled in Firebase Console
3. **iOS build issues**: Make sure the bundle ID matches exactly in Firebase Console and iOS project

## Next Steps

Consider implementing:
- Email verification
- Phone number authentication
- Social login (Google, Facebook, etc.)
- Password strength requirements
- User profile management
