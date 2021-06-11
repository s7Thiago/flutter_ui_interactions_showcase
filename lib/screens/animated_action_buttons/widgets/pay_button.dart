import 'package:flutter/material.dart';

class PayButton extends StatefulWidget {
  final double width;
  final double height;
  final String? label;
  final String? processingLabel;
  final String? completedLabel;
  final String? completedWarningLabel;
  final Function()? onTap;

  const PayButton(
      {this.width = 250,
      this.height = 45,
      this.onTap,
      this.label = 'Pay',
      this.processingLabel = 'Processing',
      this.completedLabel = 'Success!',
      this.completedWarningLabel = 'Proceed'});

  @override
  _PayButtonState createState() => _PayButtonState();
}

class _PayButtonState extends State<PayButton> with TickerProviderStateMixin {
  late PageController _pageController;
  late PageController _finalPageController;

  // Animation
  late AnimationController _btnStateAnimationController;
  late AnimationController _btnFinalStateAnimationController;
  late AnimationController _btnFinalOpacityStateAnimationController;
  late Animation<int> _stepAnimation;
  late Animation<double> _opacity;
  Curve defaultCurve = Curves.bounceOut;

  // current view position on button
  int currentState = 2;
  bool animating = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: currentState);
    _finalPageController = PageController(initialPage: 0);

    _btnStateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 850),
    );

    _btnFinalStateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 850),
    );

    _btnFinalOpacityStateAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    // Setting up animation
    _stepAnimation =
        Tween<int>(begin: currentState - 1, end: currentState).animate(
      CurvedAnimation(
        parent: _btnStateAnimationController,
        curve: defaultCurve,
      ),
    );

    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _btnFinalOpacityStateAnimationController,
        curve: Curves.easeInQuad,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _btnStateAnimationController.dispose();
    _btnFinalOpacityStateAnimationController.dispose();
    _btnFinalStateAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonStates = [
      InnerContainer(
        child: Text(
          widget.completedLabel!,
          style: AabStyles.buttonText.copyWith(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      InnerContainer(
        child: Text(
          widget.processingLabel!,
          style: AabStyles.buttonText.copyWith(color: Colors.black),
        ),
        decoration: BoxDecoration(color: Colors.white),
      ),
      InnerContainer(
        child: Text(
          widget.label!,
          style: AabStyles.buttonText,
        ),
        decoration: BoxDecoration(color: Colors.blue),
        onTap: () async {
          // Make the final animation pageView be visible
          setState(() {
            animating = true;
          });
          await Future.delayed(_btnStateAnimationController.duration!)
              .then((value) {
            _pageController.animateToPage(
              _stepAnimation.value,
              duration: _btnStateAnimationController.duration!,
              curve: defaultCurve,
            );
          }).then((value) async {
            await Future.delayed(Duration(milliseconds: 2500)).then((value) {
              _pageController.animateToPage(
                0,
                duration: _btnStateAnimationController.duration!,
                curve: defaultCurve,
              );
            });
          }).then((value) async {
            await Future.delayed(Duration(milliseconds: 3000)).then((value) {
              if (_finalPageController.hasClients)
                _finalPageController.animateToPage(
                  1,
                  duration: _btnFinalStateAnimationController.duration!,
                  curve: defaultCurve,
                );
            }).then((value) async {
              await Future.delayed(Duration(milliseconds: 1000))
                  .then((value) async {
                _pageController.animateToPage(
                  2,
                  duration: _btnStateAnimationController.duration!,
                  curve: defaultCurve,
                );
              });
            });
          }).then((value) async {
            await Future.delayed(Duration(milliseconds: 500)).then((value) {
              _btnFinalOpacityStateAnimationController.forward();
            });
          }).whenComplete(() {
            Future.delayed(Duration(milliseconds: 1650))
                .then((value) => setState(() {
                      animating = false;
                    }));
          }).then((value) {
            Future.delayed(Duration(
                    milliseconds:
                        3500)) /* .then(
              (value) => Navigator.pop(context),
            ) */
                ;
          });

          widget.onTap!();
        },
      ),
    ];

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height * .5),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height * .5),
        child: AnimatedBuilder(
          animation: _btnStateAnimationController,
          builder: (context, child) {
            return Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: buttonStates,
                ),
                if (animating)
                  AnimatedBuilder(
                      animation: _btnFinalOpacityStateAnimationController,
                      builder: (context, _) {
                        return AnimatedOpacity(
                          duration: _btnFinalStateAnimationController.duration!,
                          opacity: _opacity.value,
                          child: PageView(
                            controller: _finalPageController,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              InnerContainer(
                                child: Text(
                                  widget.completedWarningLabel!,
                                  style: AabStyles.buttonText,
                                ),
                                decoration: BoxDecoration(color: Colors.blue),
                              ),
                            ],
                          ),
                        );
                      }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class InnerContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  const InnerContainer({
    Key? key,
    this.decoration = const BoxDecoration(
      color: Colors.blue,
    ),
    this.onTap,
    required this.child,
    this.width = 250.0,
    this.height = 45.0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: decoration!.color,
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          alignment: Alignment.center,
          child: child,
          decoration: decoration!.copyWith(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class AabStyles {
  static final buttonText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
