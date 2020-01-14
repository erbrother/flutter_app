import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qc/common/config/config.dart';
import 'package:flutter_qc/page/tab_navigator.dart';
import 'page/home_page.dart';
import './common/util/http.dart';


void main() {
  
  initDio();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QC',
      theme: ThemeData(
          primarySwatch: Colors.blue, splashColor: Colors.transparent, highlightColor: Colors.transparent),
      home: TabNavigator(),
      routes: {
        '/home': (context) => HomePage(),
        '/tabNav': (context) => TabNavigator(),
      },
    );
  }
}

initDio() {
  dio.options.baseUrl = Config.BASE_URL;
  dio.options.connectTimeout = 5000; //5s
  dio.options.receiveTimeout = 3000;
  dio.options.headers["token"] = Config.TOKEN;
}
