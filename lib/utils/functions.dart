import 'package:flutter/material.dart';

customLauncher({
  required Widget target,
  required BuildContext context,
  bool opaque = false,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 550),
  Color barrierColor = Colors.black54,
  String? barrierLabel,
  Duration? reverseTransitionDuration,
  RouteSettings? settings,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
      transitionsBuilder,
}) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: opaque,
      fullscreenDialog: fullscreenDialog,
      maintainState: maintainState,
      transitionDuration: transitionDuration,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      reverseTransitionDuration:
          reverseTransitionDuration ?? Duration(milliseconds: 650),
      settings: settings,
      transitionsBuilder: transitionsBuilder ??
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return child;
          },
      pageBuilder: (ctx, _, __) {
        return target;
      }));
}
