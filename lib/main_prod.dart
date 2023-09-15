import 'package:flutter/material.dart';

import 'config_flavor.dart';
import 'maincommon.dart';

void main() {
  // Inject our own configurations
  // School One

  maincommon(
    FlavorConfig()
      ..appTitle = "Main Prod"
      ..apiEndpoint = {
        Endpoints.items: "flutterjunction.api.dev/items",
        Endpoints.details: "flutterjunction.api.dev/item"
      }
      ..imageLocation = "assets/images/one.png"
      ..theme = ThemeData.light().copyWith(
        primaryColor:const Color(0xFF123456),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
          backgroundColor:const Color(0xFF654321),
        ),
      ),
  );
}