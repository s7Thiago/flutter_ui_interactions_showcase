import 'package:flutter/material.dart';

class ScreenEntry {
  final String label;
  final String route;
  final Widget target;

  ScreenEntry({
    required this.label,
    required this.route,
    required this.target,
  });
}
