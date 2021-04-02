import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'screens/home_screen.dart';
import 'screens/animated_download_button/adb_screen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
        routes: {
          AppRoutes.home: (_) => HomeScreen(),
          AppRoutes.adb: (_) => AdbScreen(),
        },
      ),
    );
