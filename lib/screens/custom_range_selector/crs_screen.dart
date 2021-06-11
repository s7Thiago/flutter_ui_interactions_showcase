import 'package:flutter/material.dart';

import '../../utils/extensions.dart';
import 'widgets/custom_range_selector.dart';
import '../../utils/styles.dart' as styles;

class MyRangeSelector extends StatefulWidget {
  @override
  _MyRangeSelectorState createState() => _MyRangeSelectorState();
}

class _MyRangeSelectorState extends State<MyRangeSelector> {
  String _label = 'Custom Range Selector';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double rsWidth = size.width * .75;
    double rsHeight = size.width * .25;

    double start = .25;
    double end = .75;

    return Container(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20).onFlex(),
              Text(
                'Start: $start',
                style: styles.innerButtonText.copyWith(
                  fontSize: 30,
                ),
              ).onFlex(),
              CustomRangeSelector(
                width: rsWidth,
                height: rsHeight,
                divisions: 10,
                start: start,
                end: end,
                onStartChange: (value) {
                  setState(() {
                    start = value;
                  });
                },
                onEndChange: (value) {
                  setState(() {
                    end = value;
                  });
                },
              ).onFlex(),
              Text(
                'End: $end',
                style: styles.innerButtonText.copyWith(
                  fontSize: 30,
                ),
              ).onFlex(),
              SizedBox(height: 20).onFlex(),
            ],
          ),
        ),
      ).closeable(context: context),
    ).putFloatingHero(
      tag: _label,
      context: context,
      title: _label,
      titleColor: Colors.white,
    );
  }
}
