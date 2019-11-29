import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_qc/page/tab_navigator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _userAgreement = false; //  用户协议

  TextEditingController _controller = new TextEditingController(); //文本控制器
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
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
                  margin: EdgeInsets.only(top: 25.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _textItem("温馨提示"),
                      _textItem("尊敬的用户您好，感谢您采购了启辰智能耳机，为了给您优质的内容服务，需要您激活耳机。"),
                      _textItem("请找到耳机，查看耳机上方的条形码进行耳机激活"),
                      new InkWell(
                        onTap: () => changeUserAgreement(),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              width: 20.0,
                              height: 20.0,
                              margin: EdgeInsets.only(right: 10.0),
                              color: Colors.white,
                              child: _userAgreement
                                  ? new Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 20.0,
                                    )
                                  : new Container(),
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
                                      EdgeInsets.symmetric(horizontal: 30.0),
                                  height: 36.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  child: new TextField(
                                    controller: _controller,
                                    decoration: new InputDecoration(
                                        hintText: "输入设备ID登录",
                                        contentPadding:
                                            EdgeInsets.only(top: 5.0),
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
                      onTap: () => connectDevice(),
                      child: new Container(
                        margin: EdgeInsets.only(bottom: 15.0),
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
                    new InkWell(
                      onTap: () => noDevice(context),
                      child: new Text(
                        "没有设备",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _textItem(str) {
    return new Container(
        margin: EdgeInsets.only(bottom: 12.0),
        child: new Text("$str", style: TextStyle(color: Colors.white)));
  }

  void changeUserAgreement() {
    setState(() {
      _userAgreement = !_userAgreement;
    });
  }

  //连接设备
  void connectDevice() {
    print("连接设备：${_controller.text}");
    print("用户协议：${_userAgreement}");
  }

  void noDevice(context) {
    Navigator.of(context).pop();
  }
}
