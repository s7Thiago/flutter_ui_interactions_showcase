import 'package:flutter/material.dart';

import 'animated_download_button/adb_screen.dart';
import '../core/routes.dart';
import '../model/screen_entry_model.dart';
import '../utils/extensions.dart';
import '../utils/functions.dart' as functions;

final _pages = <ScreenEntry>{
  ScreenEntry(
    label: 'Animated Download Button',
    route: AppRoutes.adb,
    target: AdbScreen(),
    launcher: (context) {
      functions.customLauncher(target: AdbScreen(), context: context);
    },
  ),
};

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeList(),
    );
  }
}

class HomeList extends StatelessWidget {
  ScreenEntry _getPage(int index) => _pages.elementAt(index);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            if (_getPage(index).launcher == null) {
              Navigator.pushNamed(context, _getPage(index).route);
              return;
            } else {
              _getPage(index).launcher!(context);
            }
          },
          title: Text('${_getPage(index).label}'),
        ).putElevatedHero(tag: 'adb');
      },
    );
  }
}
