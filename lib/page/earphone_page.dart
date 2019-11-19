import 'package:flutter/material.dart';

class EarphonePage extends StatefulWidget {
  @override
  _EarphonePageState createState() => _EarphonePageState();
}

class _EarphonePageState extends State<EarphonePage> {

  @override
  void initState() {
    super.initState();
    print("earphone initState");
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red
      ),
      child: new Center(
        child: new Text("erphone"),
      ),
    );
  }
}

