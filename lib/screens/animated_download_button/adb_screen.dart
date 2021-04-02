import 'package:flutter/material.dart';

import 'widgets/animated_button.dart';
import '../../utils/extensions.dart';

class AdbScreen extends StatelessWidget {
  _space([int qtde = 10]) => List.generate(qtde, (index) => SizedBox());
  String _label = 'Animated Download Button';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ..._space(),
              DownloadBtn(Colors.blue[700]!, Colors.blue[800]!).onFlex(),
              DownloadBtn(Colors.yellow[700]!, Colors.yellow[800]!).onFlex(),
              DownloadBtn(Colors.green[700]!, Colors.green[800]!).onFlex(),
              DownloadBtn(Colors.red[700]!, Colors.red[800]!).onFlex(),
              ..._space(),
            ],
          ),
        ),
      ).closeable(context: context),
    ).putFloatingHero(tag: 'adb', context: context, title: _label);
  }
}
