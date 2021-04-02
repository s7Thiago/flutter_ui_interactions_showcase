import 'package:flutter/material.dart';

extension PowerExtensions on Widget {
  putElevatedHero({required tag}) {
    return Hero(
      tag: tag,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(3),
        child: this,
      ),
    );
  }

  putFloatingHero({required tag, required context, title = 'no title'}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 120.0),
      child: Hero(
        tag: tag,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(3),
          child: Stack(
            children: [
              this,
              Positioned(
                top: 10,
                left: 20,
                child: Text(
                  title,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onFlex({flex = 1}) => Flexible(flex: flex, child: this);

  closeable({required BuildContext context}) {
    Future.delayed(Duration(milliseconds: 800));
    return Stack(
      children: [
        this,
        Positioned(
          right: 10,
          top: 10,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.close,
                  size: 10,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
