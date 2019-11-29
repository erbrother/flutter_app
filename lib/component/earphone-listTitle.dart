import 'package:flutter/material.dart';

class EarphoneListTitle extends StatelessWidget {
  EarphoneListTitle({
    this.icon,
    this.title
  });

  final Widget icon;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          icon,
          title
        ],
      ),
    );
  }
}


