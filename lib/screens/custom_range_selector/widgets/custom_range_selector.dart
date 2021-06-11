import 'package:flutter/material.dart';

class CustomRangeSelector extends StatefulWidget {
  final double start;
  final double end;
  final int divisions;
  final Function(double start) onStartChange;
  final Function(double end) onEndChange;
  final double width;
  final double height;

  const CustomRangeSelector({
    required this.start,
    required this.end,
    required this.divisions,
    required this.width,
    required this.height,
    required this.onStartChange,
    required this.onEndChange,
  });

  @override
  _CustomRangeSelectorState createState() => _CustomRangeSelectorState();
}

class _CustomRangeSelectorState extends State<CustomRangeSelector> {
  double barHeight = 0.0;

  List<Widget> topDividers = [];
  List<Widget> bottomDividers = [];

  double startPosition = 0;
  double endPosition = 0;

  @override
  void initState() {
    super.initState();

    startPosition = widget.start * widget.width;
    endPosition = widget.end * widget.width;

    barHeight = widget.height * .75;
    double markersDistance = widget.width / widget.divisions;

    // Generating the markers distances for markers
    List markers = List.generate(
        widget.divisions - 1, (index) => (markersDistance) * (index + 1));

// Fill the topDividers list with positioned containers
    topDividers = markers
        .map(
          (mp) => Positioned(
            top: 0,
            left: mp - 1,
            child: Container(
              color: Colors.black,
              width: 2,
              height: 10,
            ),
          ),
        )
        .toList();

// Fill the bottomDividers list with positioned containers
    bottomDividers = markers
        .map(
          (mp) => Positioned(
            bottom: 0,
            left: mp - 1,
            child: Container(
              color: Colors.black,
              width: 2,
              height: 10,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Container(
            height: barHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Stack(
              children: [
                ...topDividers,
                ...bottomDividers,
              ],
            ),
          ),

          // * Start bar
          Positioned(
            top: 0,
            left: startPosition,
            child: Container(
              width: 2,
              height: barHeight,
              color: Colors.red,
            ),
          ),
          // * End bar
          Positioned(
            top: 0,
            left: endPosition - 1,
            child: Container(
              width: 2,
              height: barHeight,
              color: Colors.red,
            ),
          ),

          // * Start position drag button
          Positioned(
            bottom: 0,
            left: startPosition - 10,
            child: GestureDetector(
              onPanUpdate: (panUpdate) {
                double newPosition = (startPosition + panUpdate.delta.dx)
                    .clamp(0.0, widget.width);

                if (newPosition <= endPosition - 10) {
                  widget.onStartChange(newPosition / widget.width);
                  setState(() {
                    startPosition = newPosition;
                  });
                }
              },
              child: Container(
                width: 20,
                height: widget.height - barHeight,
                color: Colors.red,
              ),
            ),
          ),

          // * End position drag button
          Positioned(
            bottom: 0,
            left: endPosition - 10,
            child: GestureDetector(
              onPanUpdate: (panUpdate) {
                double newPosition =
                    (endPosition + panUpdate.delta.dx).clamp(0.0, widget.width);

                if (newPosition >= startPosition + 10)
                  setState(() {
                    endPosition = newPosition;
                    widget.onEndChange(newPosition);
                  });
              },
              child: Container(
                width: 20,
                height: widget.height - barHeight,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
