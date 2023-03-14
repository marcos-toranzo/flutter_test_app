# Flutter Test App

<p align="center">
   <img src="assets/images/app_logo.svg" width="200" />
</p>

### Flutter test app.

Answers to the theoretical test are in the file [`ANSWERS.md`](ANSWERS.md).

## SDK

Flutter: 3.7.7 (stable).

Dart: 2.19.4 (stable).

Developed only for Android and iOS platforms.

## State management

[GetX](https://pub.dev/packages/get): 4.6.5.

Each screen (view) should be a `StatelessWidget` and have a `GetxController` associated that will handle the state. Only simple widgets should be `StatefulWidget`s and not make use of GetX for state. In addition to that some `GetxController`s are used globally so they are placed under [`lib/controllers`](lib/controllers/) directory, such as the [`AuthController`](lib/controllers/auth_controller.dart#L7) for handling current user session. As for this version, GetX Routing should be used in order to dispose the controller correctly when a view pops.

## HTTP Requests

[http](https://pub.dev/packages/http): 0.13.5.

The code that handles the HTTP requests with `http` is in [`lib/services/network_service/http_network_service.dart`](lib/services/network_service/http_network_service.dart).

## Internationalization

- [intl](https://pub.dev/packages/intl): 0.17.0.
- [Flutter Localization](https://pub.dev/packages/flutter_localization).
- The file [`l10n.yaml`](l10n.yaml) contains the configuration. Inside [`lib/l10n`](lib/l10n) folder are the intl files. They are named `app_<languageCode>.arb`. In order to add a new translation the key and its translation should be added to every `.arb` file (they are sorted alphabetically for easy finding). After adding them the command `flutter gen-l10n` should be excecuted in order to generate the translations. The translations are automatically generated when running `flutter run` or `flutter pub get`. Every time the generation runs, it will create a file (ignored by git) called `not_translated.json` inside the [`lib/l10n`](lib/l10n) folder. It contains the keys that did not get translated for some reason. These translations can be accessed through `AppTranslations.of(context).<translationKey>`. See [`lib/utils/localization.dart`](lib/utils/localization.dart) file for more information.

[Documentation](https://docs.flutter.dev/development/accessibility-and-localization/internationalization).

## Storage

- [Shared Preferences](https://pub.dev/packages/shared_preferences): 2.0.6. To store non-sensitive data (e.g. saved language).
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage): 7.0.1. To store sensitive data (e.g. auth tokens).

Inside the file [`lib/utils/storage.dart`](lib/utils/storage.dart) reside functions to handle the common operations with the storage (reading and writing tokens and language). These one should be used instead of using the [`storageService`](lib/app_configuration.dart#L19) directly. Add new functions if needed.

## Environment

[Flutter dotenv](https://pub.dev/packages/flutter_dotenv): 5.0.2.

The root directory should contain 2 `.env` files: one called `.env` containing production variables, and another one called `.env.dev` containing variables used in development and debugging. The file [`lib/app_configuration.dart`](lib/app_configuration.dart) contains the static class [`Environment`](lib/app_configuration.dart#L21). This class decides which `.env` file based on flag `kReleaseMode` (`true` if the app is running in release mode). It has defined the variables that should appear on the respective `.env` file and uses `dotenv` internally to fetch them, returning [`Environment.valueOnNotFoundKey`](lib/app_configuration.dart#L22) when it fails finding the key.

**NOTE**: `Environment.valueOnNotFoundKey` key should not appear on any `.env` file.

## Routing

In order to support future changes on routing management, the [`routingService`](lib/app_configuration.dart#L18) defined in [`lib/app_configuration.dart`](lib/app_configuration.dart) should be used. Every screen should have a `static const String routeName = <unique-route-name>;` defined. For routing arguments, the class [`RouteArguments`](lib/services/routing_service/routing_service.dart#L11) inside [`lib/services/routing_service/routing_service.dart`](lib/services/routing_service/routing_service.dart) should be used. Add any new fields to the class if needed. As for this version of GetX, GetX Routing should be used in order to dispose the controller correctly when a view pops.

## Directories

- **`assets`**: images and fonts for the app.
- **`l10n.yaml`**: internationalization configuration.
- **`flutter_launcher_icons.yaml`**: app icon configuration. See [package](https://pub.dev/packages/flutter_launcher_icons).
- **`flutter_native_splash.yaml`**: splash screen configuration See [package](https://pub.dev/packages/flutter_native_splash).
- **`lib`**: the main source files:
  - **`/api`**: providers for each API resource, containing the different endpoints and utils for handling the resource..
  - **`/controllers`**: global GetX controllers for the app. Controllers that are used by multiple views.
  - **`/l10n`**: translation files.
  - **`/models`**: API models.
  - **`/views`**: each one of the views of the app. Divided in subdirectories for each view, containing the `_screen.dart` file for the UI, `_controller.dart` for the GetX controller and any other specific widgets or utils for the view. If something from an specific views is used on any other place it should be refactored to the `lib/widgets` or `lib/utils` folder.
  - **`/services`**: inside are defined the different services as abstract classes in order to support future changes on the especific way to handle them. For example, inside `lib/services/network_service` should go every network handler (like `http` or `dio`). The file `network_service.dart` defines the base abstract class that every handler should extend from, containing the interface the rest of the app will use to communicate with it, alongside other utils.
  - **`/utils`**: misc functions and methods used across the different views.
  - **`/widgets`**: widgets that are used on multiple views.
  - **`app_configuration.dart`**: this file contains the instances of the different services used by the app (network, storage, oauth, logging), as well as the [`Environment`](lib/app_configuration.dart#L21) class.
  - **`main.dart`**: entry point of the app. Inside the `main()` function the method [`initConfig`](lib/app_configuration.dart#L43) from [`lib/app_configuration.dart`](lib/app_configuration.dart) should be called BEFORE `runApp`.
