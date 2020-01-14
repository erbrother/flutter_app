import 'package:flutter/material.dart';

class ConnectWifiSuccess extends StatefulWidget {
  @override
  _ConnectWifiSuccessState createState() => _ConnectWifiSuccessState();
}

class _ConnectWifiSuccessState extends State<ConnectWifiSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text('123'),
            Text('234')
          ],
        ),
      ),
    );
  }
}