import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/backimg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.all(15.0),
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _textItem("温馨提示"),
                      _textItem("尊敬的用户您好，感谢您采购了启辰智能耳机，为了给您优质的内容服务，需要您激活耳机。"),
                      _textItem("请找到耳机，查看耳机上方的条形码进行耳机激活"),
                      new InkWell(
                        onTap: () => print("click"),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              width: 20.0,
                              height: 20.0,
                              margin: EdgeInsets.only(right: 10.0),
                              color: Colors.white,
                              child: new Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 20.0,
                              ),
                            ),
                            _textItem("请仔细阅读此信息"),
                            new InkWell(
                              onTap: () => print("inner click"),
                              child: new Text(
                                "《用户协议》",
                                style: TextStyle(color: Colors.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  height: 36.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  child: new TextField(
                                    controller: _controller,
                                    decoration: new InputDecoration(
                                        hintText: "输入设备ID登录",
                                        contentPadding:
                                            EdgeInsets.only(top: 6.0),
                                        border: InputBorder.none),
                                  )),
                            ),
                            new Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              child: new Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 50.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Expanded(
                  child: new Container(),
                ),
                new Column(
                  children: <Widget>[
                    new InkWell(
                      hoverColor: Colors.green,
                      focusColor: Colors.red,
                      onTap: () => print("ok"),
                      child: new Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 12.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xfffffb67), Color(0xfffeab4b)]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: new Text("连接设备"),
                      ),
                    ),
                    new RaisedButton(
                      onPressed: () => print('rasie button'),
                      child: new Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 12.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xfffffb67), Color(0xfffeab4b)]),
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        child: new Text("连接设备"),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

Widget _textItem(str) {
  return new Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: new Text("$str", style: TextStyle(color: Colors.white)));
  ;
}
