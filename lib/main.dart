import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'screens/home_screen.dart';
import 'screens/animated_download_button/adb_screen.dart';
import 'screens/custom_range_selector/crs_screen.dart';
import 'screens/animated_action_buttons/animated_action_buttons_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
        routes: {
          AppRoutes.home: (_) => HomeScreen(),
          AppRoutes.animatedDownloadButton: (_) => AdbScreen(),
          AppRoutes.customRangeSelector: (_) => MyRangeSelector(),
          AppRoutes.animatedActionButton: (_) => AnimatedActionButtonsScreen(),
        },
      ),
    );
