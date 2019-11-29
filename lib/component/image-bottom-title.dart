import 'package:flutter/material.dart';
import 'package:flutter_qc/component/container-background.dart';

//背景图 + 底部标题栏

class ImageBottomTitle extends StatelessWidget {
  final double width;
  final double height;
  final String imgUrl;
  final Widget child;

  ImageBottomTitle(
      {this.width = 100.0, this.height = 100.0, this.imgUrl, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: new Stack(
        children: <Widget>[
          FadeInImage.assetNetwork(
              placeholder: 'lib/images/addearphone.png',
              image: imgUrl,
              width: width,
              height: height,
              fit: BoxFit.fill,
          ),
          new Positioned(bottom: 0, child: new Container(
            width: 100.0,
            padding: EdgeInsets.all(5.0),
            color: Color.fromRGBO(0, 0, 0, .7),
            child: child,
          ))
        ],
      ),
    );
  }
}
