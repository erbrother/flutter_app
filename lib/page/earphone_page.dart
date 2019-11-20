import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EarphonePage extends StatefulWidget {
  @override
  _EarphonePageState createState() => _EarphonePageState();
}

class _EarphonePageState extends State<EarphonePage> {

  @override
  void initState() {
    super.initState();
    _statusBar();
    print("earphone initState");
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(
        colors: [
          Color(0xffedeef0),
          Color(0xffe6e7e9),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: new Column(
        children: <Widget>[
          earphone(),
//          title(),
//          content()
        ],
      )
    );
  }

  Widget earphone() {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: 210,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/earphone-back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(),
    );
  }
  _statusBar() {
    //黑色沉浸式状态栏，基于SystemUiOverlayStyle.dark修改了statusBarColor
    SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );

    SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
  }
}

