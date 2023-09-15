import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './data/auth.dart';
import './data/blog.dart';
import './data/job.dart';
import './logic/cubit/theme_cubit.dart';
import './ui/authentication/login.dart';
import './ui/homepage/index.dart';
import './ui/onboarding_screen/index.dart';
import 'config_flavor.dart';
import 'firebase_options.dart';


bool? initScreen;
String? fcmToken;


Future<void> maincommon(FlavorConfig config) async {
  // Register google_fonts license (DM Sans)
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/dmsans/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  // Register google_fonts license (Raleway)
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/raleway/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // ignore: await_only_futures
  initScreen = await prefs.getBool("initScreen");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "coda",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  fcmToken = await FirebaseMessaging.instance.getToken();


  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FlavorConfig? flavorConfig; // Add a parameter for FlavorConfig

  const MyApp({super.key, this.flavorConfig}); // Pass FlavorConfig to the constructor

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SwitchCubit()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<JobProvider>(
              create: (context) => JobProvider()),
          ChangeNotifierProvider<BlogProvider>(
              create: (context) => BlogProvider()),
        ],
        child: BlocBuilder<SwitchCubit, SwitchState>(
          builder: (context, state) => MaterialApp(
            title: "Beamcoda Job", // Use app title from FlavorConfig
            theme: state.theme, // Use theme from FlavorConfig or fallback to SwitchState
            home: Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return FutureBuilder(
                  future: auth.checkLogin(context),
                  builder: (context, future) {
                    final isAuth = future.data;
                    switch (isAuth) {
                      case false:
                        return const LoginPage();
                      case null:
                        return const LoginPage();
                      default:
                        return FutureBuilder(
                          future: auth.getUserDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              return (initScreen == false)
                                  ? const HomePage()
                                  : const OnboardingScreen();
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Theme.of(context).backgroundColor,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.teal.shade400,
                                ),
                              ),
                            );
                          },
                        );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
