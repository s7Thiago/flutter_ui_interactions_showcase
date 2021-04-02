import 'package:flutter/material.dart';

import 'widgets/animated_button.dart';

class AdbScreen extends StatelessWidget {
  _space([int qtde = 10]) => List.generate(qtde, (index) => SizedBox());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ..._space(),
            DownloadBtn(Colors.blue[700]!, Colors.blue[800]!),
            DownloadBtn(Colors.yellow[700]!, Colors.yellow[800]!),
            DownloadBtn(Colors.green[700]!, Colors.green[800]!),
            DownloadBtn(Colors.red[700]!, Colors.red[800]!),
            ..._space(),
          ],
        ),
      ),
    );
  }
}
