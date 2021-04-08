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

  putFloatingHero({
    required tag,
    required context,
    title = 'no title',
    Color titleColor = Colors.black87,
  }) {
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
                    color: titleColor,
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
              borderRadius: BorderRadius.circular(15),
              splashColor: Colors.white,
              child: Container(
                width: 25,
                height: 25,
                child: Icon(
                  Icons.close,
                  size: 15,
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
