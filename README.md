# MovieFlix

## Instructions

To use the app, import your own API keys.
To do that, create a file named api_keys.dart in the lib directory and include the following :

1. baseUrl("https&#58;//api.themoviedb.org/3")
2. apiKey
3. readAccessToken

## External Libraries Used

1. [http](https://pub.dev/packages/http)
2. [flutter_easyloading](https://pub.dev/packages/flutter_easyloading)
3. [provider](https://pub.dev/packages/provider)
4. [sqflite](https://pub.dev/packages/sqflite)
5. [path](https://pub.dev/packages/path)

## Architecture Overview

The applicaton follows a modular architecture.

The UI is divided into pages and modular components to ensure maintainability and reusability.

The API calls and logic are separated from UI elements to ensure easy error detection and handling.

Favourites are stored locally using a SQLite database.

Provider is used for state management.

## Improvements To Be Made

1. Add internet connection checker to alert users in case of internet connectivity issues.
2. Add filters in the search page.
3. Add sorting (alphabetic, popularity, recents etc).
