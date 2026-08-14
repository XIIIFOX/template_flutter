# Verification

## Toolchain

- Flutter: `3.44.7` (pinned in `.flutter-version`)
- Dart: `3.12.x` bundled with Flutter 3.44.7
- Java: 17
- Android Gradle Plugin: 8.11.1
- Gradle: 8.14
- Kotlin: 2.2.20

The repository contains Android, iOS, and Linux runners. No web, macOS, or
Windows runner is present, so those targets are not part of this template's
build matrix.

## Reproducible checks

Run from the repository root with Flutter 3.44.7:

```bash
flutter --version
dart --version
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
flutter build ios --debug --no-codesign
flutter build linux --debug
git diff --exit-code pubspec.lock
```

`flutter pub get` is expected to regenerate `pubspec.lock` after the direct
dependency constraints change. Commit that generated lock file; the final
`git diff` command makes an unrecorded resolver change visible.

## Infrastructure fallbacks

- Android requires Android SDK 36, Java 17, and the SDK/NDK components reported
  by `flutter doctor -v`. In a prepared Linux environment run
  `flutter build apk --debug`.
- iOS can only be compiled on macOS with Xcode and CocoaPods. Firebase also
  requires a project-specific `ios/Runner/GoogleService-Info.plist`. After
  adding it, run `flutter build ios --debug --no-codesign`; a distributable
  archive additionally requires signing credentials.
- Linux requires the system packages reported by `flutter doctor -v` (including
  the GTK development toolchain). In a prepared Linux environment run
  `flutter build linux --debug`.

Missing SDKs, Firebase configuration, CocoaPods/Xcode, or signing credentials
are infrastructure limitations. Dependency-resolution, analyzer, test, or
compiler diagnostics produced after those prerequisites are installed are code
errors and must not be classified as infrastructure failures.
