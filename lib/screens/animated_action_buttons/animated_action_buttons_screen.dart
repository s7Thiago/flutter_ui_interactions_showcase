import 'package:flutter/material.dart';

import '../../utils/extensions.dart';
import 'widgets/pay_button.dart';

class AnimatedActionButtonsScreen extends StatelessWidget {
  String _label = 'Animated action buttons';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PayButton(
                onTap: () {},
              ).onFlex(),
            ],
          ),
        ),
      ).closeable(context: context),
    ).putFloatingHero(
      tag: _label,
      context: context,
      title: _label,
      margin: const EdgeInsets.only(
        top: 20,
        bottom: 100,
        left: 20,
        right: 20,
      ),
    );
  }
}
