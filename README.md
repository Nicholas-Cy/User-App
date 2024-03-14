# carijobs

This project is a part of the carijob app from TENSTAR Team.

This is the user app for the carijob app.

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

Check the package name from
`android/app/build.gradle`
```yaml
applicationId "com.tenstar.carijobs_dev"
```
use the applicatonId to create google-services file in firebase.

The error message indicates that the `google-services.json` file is missing from your project. This file is required for configuring Firebase services in your Flutter app. Here are the steps to resolve this issue:

Check Firebase Console:
Ensure that you have set up your project on the Firebase Console and have added your Android app to the project. During this process, you should have downloaded the google-services.json file.

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
