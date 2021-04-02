import 'package:flutter/material.dart';

import 'animated_download_button/adb_screen.dart';
import '../core/routes.dart';
import '../model/screen_entry_model.dart';

final _pages = <ScreenEntry>{
  ScreenEntry(
    label: 'animated download button',
    route: AppRoutes.adb,
    target: AdbScreen(),
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
  _getPage(int index) => _pages.elementAt(index);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.pushNamed(context, _getPage(index).route);
          },
          title: Text('${_getPage(index).label}'),
        );
      },
    );
  }
}
