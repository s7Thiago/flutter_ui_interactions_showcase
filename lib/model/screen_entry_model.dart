import 'package:flutter/material.dart';

class ScreenEntry {
  final String label;
  final String route;
  final Widget target;
  final Function(BuildContext)? launcher;
  final String? urlInspiration;

  ScreenEntry({
    required this.label,
    required this.route,
    required this.target,
    this.launcher,
    this.urlInspiration,
  });
}
