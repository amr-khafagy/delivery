# Delivery Driver App

A Flutter delivery-companion application for managing the driver workflow: authentication, order queues, order details, completion, and live location tracking.

## Features

- Sign up, sign in, account verification, and password-reset flows.
- Localized app setup with language selection.
- Pending and accepted order queues.
- Order details, delivery status updates, and order completion.
- Google Maps-based delivery tracking with destination markers and route polylines.
- Driver location updates using device geolocation and Cloud Firestore.
- Push-notification and local-notification integration.
- Responsive layout support and local preferences for app state.

## Tech Stack

- **Framework:** Flutter
- **State Management & Navigation:** GetX
- **Backend:** REST APIs and Cloud Firestore
- **Maps & Location:** Google Maps Flutter, Geolocator, Geocoding, and Polyline Points
- **Notifications:** Firebase Cloud Messaging and Flutter Local Notifications
- **Local Storage:** Shared Preferences and SQLite
- **Networking:** HTTP

## Project Structure

```text
lib/
├── bindings/       # Dependency bindings
├── controller/     # Authentication, orders, home, and tracking controllers
├── core/           # Networking, localization, services, utilities, and shared UI
├── data/           # API data sources and models
└── view/           # Screens and reusable widgets
```

## Setup

This repository contains a portfolio implementation. To run it with your own environment, configure:

1. A Firebase project for Cloud Firestore and Firebase Cloud Messaging. Place your own `google-services.json` in `android/app/` and, when building for iOS, `GoogleService-Info.plist` in `ios/Runner/`. These files are intentionally ignored by Git.
2. A Google Maps API key with Maps SDK and Directions API enabled. Add it locally to `android/local.properties` as `google.maps.apiKey=YOUR_KEY`, and supply the same key to Flutter with `--dart-define=GOOGLE_MAPS_API_KEY=YOUR_KEY`.
3. A compatible REST backend, then replace the base URL in `lib/data/static/applink.dart`.

Then run:

```bash
flutter pub get
flutter run --dart-define=GOOGLE_MAPS_API_KEY=YOUR_KEY
```

## Key Learning Areas

- Organizing a multi-screen Flutter application with GetX.
- Integrating maps, routes, and device location into a delivery workflow.
- Combining REST APIs with Firebase for operational updates and live tracking.
- Building authentication and order-management flows for a role-based mobile app.

## Author

Built by [Amr Khafagy](https://github.com/amr-khafagy), Flutter Developer and Mobile Application Engineer.
