## Wordle Clone API

The API uses 5-letter words from the `words.json` file and randomly selects any word as the **Word Of The Day (WOTD)**, and updates Firebase Database with the following data :

1. Word of The Day
2. Characters in the WOTD
3. Random 30 words including the WOTD as the `words-list` for the game

## Steps to perform before running the code

You need to create a `configurations.dart` file which will contain the Firebase-Credentials required for creating a Firebase Instance in the application.

create the `configurations.dart` inside the `bin` folder with the following template :


```dart
class Config {
  static const firebaseConfig = {
    'apiKey': '<API-KEY>',
    'authDomain': '<Domain>',
    'projectId': '<Project-ID>',
    'appId': '<App-ID>'
  };

  static const databaseUrl = '<RealtimeDB-URL>';
}
```

If you would like to know how to access these credentials or are curious about Firebase Integration for Dart Application, do read my article on ThePracticalDev : https://dev.to/infiniteoverflow/firebase-for-your-dart-web-api-43mb
