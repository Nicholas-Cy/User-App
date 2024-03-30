# carijobs

This project is a part of the carijob app from TENSTAR Team.

This is the user app for the carijob app.

#Java Version (Important to Run this project, higher will have issue to run it)
JDK 17 

#Flutter Version
3.3.0

```bash
fvm use 3.3.0
```

```bash
fvm flutter clean
```

```bash

fvm flutter pub get
```
If anything not working, run the command below

```bash

fvm flutter doctor
```

Check the package name from
`android/app/build.gradle` , line: 71
```yaml
applicationId "com.tenstar.carijobs_dev"
```
use the applicatonId to create google-services file in firebase.

The error message indicates that the `google-services.json` file is missing from your project. This file is required for configuring Firebase services in your Flutter app. Here are the steps to resolve this issue:

Check Firebase Console:
Ensure that you have set up your project on the Firebase Console and have added your Android app to the project. During this process, you should have downloaded the google-services.json file.
[Click the gear icon, the next page scroll down to download google-services.json]

Add `google-services.json` to Your Project:
Place the `google-services.json` file in the `android/app` directory of your Flutter project. If you haven't downloaded this file, go to the Firebase Console, select your project, click on the gear icon (Project settings), and then download the configuration file.

Your project structure should look like this:

```
/your_flutter_project
  /android
    /app
      /src
      /build.gradle
      /google-services.json  <-- Add this file
      /...
```

#set build config entrance file is `main_dev.dart`, 
- add flavor: dev
if not will get gradle unable to build apk
https://stackoverflow.com/questions/59732883/flutter-gradle-build-failed-to-produce-an-apk-file-its-likely-that-this-file

#if got kotlin issue, mostly due to upgraded IDE
go to `android/build.gradle`
https://stackoverflow.com/questions/67448034/module-was-compiled-with-an-incompatible-version-of-kotlin-the-binary-version

if the got the kotlin issues incompatible (binary version) can refer to the highest score answer

Tip for VSCode User:

Install VS Code Extension, Flutter and Dart

If you are using VSCode:-
you can add this line into .vscode/launch.json

```json
        {
            "name": "carijobs flavor dev lib/main_dev.dart",
            "request": "launch",
            "type": "dart",
            "program": "lib/main_dev.dart",
            "args": [
                "--flavor",
                "dev"
            ]
        },
```

For MacOS User

CocoaPods is used to retrieve the iOS and macOS platform side's plugin code that responds to your plugin usage on the Dart side.
To install see https://guides.cocoapods.org/using/getting-started.html#installation for instructions.


Error:-
Android sdkmanager not found. Update to the latest Android SDK and ensure that the cmdline-tools are installed to resolve this.

https://stackoverflow.com/questions/60475481/flutter-doctor-error-android-sdkmanager-tool-not-found-windows