import 'package:flutter/material.dart';

import '../../../utils/styles.dart' as styles;

class DownloadBtn extends StatefulWidget {
  final Color primaryColor;
  final Color darkPrimaryColor;

  DownloadBtn(this.primaryColor, this.darkPrimaryColor);

  @override
  _DownloadBtnState createState() => _DownloadBtnState();
}

class _DownloadBtnState extends State<DownloadBtn>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleAnimationController;
  late AnimationController _fadeAnimationController;

  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // initial states of the widget
  double buttonWidth = 200.0;
  double scale = 1.0;
  double barColorOpacity = .6;
  bool isCompleted = false;
  bool isStarted = false;

  @override
  void initState() {
    super.initState();

    // Controllers
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    // Animations
    _fadeAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(_fadeAnimationController);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(_scaleAnimationController)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            _scaleAnimationController.reverse();
            _fadeAnimationController.forward();
            _animationController.forward();
            break;
          case AnimationStatus.dismissed:
            break;
          default:
        }
      });

    _animation = Tween<double>(
      begin: 0.0,
      end: buttonWidth,
    ).animate(_animationController)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            setState(() {
              isCompleted = true;
              barColorOpacity = .0;
            });
            break;
          default:
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _scaleAnimationController.dispose();
    _fadeAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          AnimatedBuilder(
            animation: _scaleAnimationController,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: InkWell(
                onTap: () {
                  _scaleAnimationController.forward();
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: styles.mainButtonStyle.copyWith(
                    color: widget.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          child: !isCompleted
                              ? Text('download', style: styles.innerButtonText)
                              : Icon(Icons.check, color: Colors.white),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _fadeAnimationController,
                        builder: (context, child) => Container(
                          width: _fadeAnimation.value,
                          height: 50,
                          decoration: styles.innerButtonStyle.copyWith(
                            color: widget.darkPrimaryColor,
                          ),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Positioned(
              left: 0,
              top: 0,
              width: _animation.value,
              height: 50,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: barColorOpacity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
