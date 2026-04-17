# LockTrace
LockTrace is a mobile application designed to help users (me) keep track of real-world actions, such as locking doors or leaving home. The goal is to reduce uncertainty and repetitive checking behaviors by providing a reliable history of user actions.

## Motivation
Many people (also me) experience moments of doubt after performing routine actions (e.g., "Did I lock the door?"). LockTrace provides a simple and structured way to record these actions, allowing users to confidently verify past events instead of relying on memory.

## Features
- Manual logging of actions
- Timestamped records with relative time formatting
- User authentication and data persistence
- Filtering logs by user
- Real-time updates using streams
- Clean and minimal UI focused on usability

## Tech Stack
- **Flutter** for cross-platform mobile development
- **Firebase Authentication** for user management
- **Cloud Firestore** for data storage
- **StreamBuilder** for reactive UI updates

## Getting Started
### Prerequisites
- Flutter SDK installed
- Firebase project configured

### Setup
1. Clone the repository:
```bash
git clone https://github.com/vinisilvag/locktrace.git
cd locktrace
```

2. Install dependencies:
```bash
flutter pub get
```

3. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

4. Configure Firebase using FlutterFire:
```bash
flutterfire configure
```

This command will:
* Link your app to a Firebase project
* Generate the `firebase_options.dart` file
* Automatically configure Android, iOS, and other supported platforms

Firebase services used:
* Firebase Authentication
* Cloud Firestore

5. Run the app:
```bash
flutter run
```

## Known Limitations
* Limited customization of themes and colors
* No offline-first support yet
* Splash screen not fully implemented across platforms

## Roadmap
* Improve theme system and color modularization
* Enhance UI/UX consistency
* Add offline support (local database or caching)
* Expand filtering and search capabilities

## Contributing
Contributions are welcome. Feel free to open issues or submit pull requests for improvements, bug fixes, or new features.

## License
This project is licensed under the [MIT License](LICENSE).