import 'package:flutter/material.dart';

// Global ValueNotifier to track the currently selected view in the app.
ValueNotifier<MainViews> currentSite =
    ValueNotifier<MainViews>(MainViews.events);

// Enum to define the possible views in the application.
enum MainViews { slask, news, events, explore }

// Define commonly used colors in the app to maintain consistency across the UI.
const Color mainDarkBlue = Color.fromARGB(255, 1, 102, 177);
const Color mainGreen = Color.fromARGB(255, 9, 222, 174);
const Color mainGrey = Color.fromARGB(255, 239, 239, 239);
