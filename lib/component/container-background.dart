import 'package:flutter/material.dart';
/*
 * 带有背景图片的组件
 * Example:
 *  new ContainerBackground(
 *    width: 10.0,
 *    height: 10.0,
 *    background: "imgUrl",
 *    child: new Text("示例")
 * )
 *
*/
class ContainerBackground extends StatelessWidget {
  final double width;
  final double height;
  final String background;
  final Widget child;
  final bool networkImage;

  ContainerBackground({this.width, this.height, this.background,this.networkImage = false, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
          color: background == null ? Colors.grey : null,
          image: background == null ? null : DecorationImage(
              image: networkImage ? NetworkImage(background) : AssetImage(background),
              fit: BoxFit.fitHeight)
          ),
      child: child,
    );
  }
}
