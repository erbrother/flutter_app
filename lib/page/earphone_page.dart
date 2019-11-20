import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EarphonePage extends StatefulWidget {
  @override
  _EarphonePageState createState() => _EarphonePageState();
}

class _EarphonePageState extends State<EarphonePage> {
  final earphoneStatus = 0;

  @override
  void initState() {
    super.initState();

    print("earphone initState");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffedeef0),
                Color(0xffe6e7e9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: new Column(
          children: <Widget>[
            earphone(earphoneStatus),
            new Container(
                padding: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                        style: BorderStyle.solid
                    ))
                ),
                child: new Row(
                  children: <Widget>[
                    _titleItem("lib/images/class.png", "课程规划"),
                    _titleItem("lib/images/history.png", "学习计划"),
                    _titleItem("lib/images/radio.png", "知识电台"),
                  ],
                )),
            new Expanded(child: new Container(color: Colors.white))
          ],
        ));
  }

  Widget earphone(num index) {
    return new Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.only(top: MediaQuery
          .of(context)
          .padding
          .top + 10.0),
      height: 210,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/earphone-back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: _earphoneItem(index),
    );
  }

//  耳机状态
  _earphoneItem(num index) {
    switch (index) {
      case 0:
        return new Column(
          children: <Widget>[
            new Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/earphone-back2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: new Center(
                child: new Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/images/scan-gray.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: new Text("请连接设备",
                  style: TextStyle(color: Colors.white, fontSize: 14.0)),
            ),
            new Text(
              "一键式听力学习",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        );
        break;
      case 1:
        print("1");
        break;
      case 2:
        print("2");
        break;
    }
  }

//子标题
  _titleItem(String imgUrl, String title) {
    return new Expanded(
        child: new Column(
          children: <Widget>[
            new Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imgUrl), fit: BoxFit.cover)),
            ),
            new Text(title)
          ],
        ));
  }
}
