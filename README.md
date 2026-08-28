# Picture Pop

Picture Pop is a beginner-friendly Flutter guessing game that shows a familiar picture and asks the player to type its name. Correct answers earn a star and move the player through six simple objects.

## Run on Android

1. Complete the official [Flutter Android setup](https://docs.flutter.dev/platform-integration/android/setup).
2. From this folder, run `flutter create --platforms=android .` once to generate local Android runner files.
3. Start an Android emulator (or connect a USB-debugging-enabled phone).
4. Run `flutter pub get`, then `flutter run`.

## Test

```sh
flutter test
```

## Demo script (12 seconds)

1. Show the apple picture and type `apple`.
2. Tap **Check answer** to show the success message and score.
3. Tap **Next picture** to reveal the car.
