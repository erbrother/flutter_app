import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final double width;
  final double height;
  final String background;
  final Widget child;

  ContainerBackground({this.width, this.height, this.background, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
          image: DecorationImage(
              image: AssetImage(background),
              fit: BoxFit.fitHeight)
          ),
      child: child,
    );
  }
}
