import 'package:flutter/material.dart';

ValueNotifier<MainViews> currentSite =
    ValueNotifier<MainViews>(MainViews.events);

enum MainViews { slask, news, events, explore }

const Color mainDarkBlue = Color.fromARGB(255, 1, 102, 177);
const Color mainGreen = Color.fromARGB(255, 9, 222, 174);
const Color mainGrey = Color.fromARGB(255, 239, 239, 239);
