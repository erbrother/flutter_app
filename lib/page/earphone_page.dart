import 'package:flutter/material.dart';
import 'package:flutter_qc/component/container-background.dart';
import 'package:flutter_qc/page/blueTooth_page.dart';
import 'package:flutter_qc/page/connectWifi_page.dart';
import 'package:flutter_qc/page/course_page.dart';
import 'package:flutter_qc/page/home_page.dart';

enum Options { change, add }

class EarphonePage extends StatefulWidget {
  @override
  _EarphonePageState createState() => _EarphonePageState();
}

class _EarphonePageState extends State<EarphonePage> {
  num earphoneStatus = 0;
  List courseList = new List();

  @override
  void initState() {
    super.initState();
    print("earphone initState");
  }

  @override
  void dispose() {
    super.dispose();
    print("earphone dispose");
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
                decoration: BoxDecoration(color: Colors.white),
                child: new Row(
                  children: <Widget>[
                    _titleItem(
                        "lib/images/class.png",
                        "课程规划",
                        () => Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return new CoursePage();
                            }))),
                    _titleItem(
                        "lib/images/history.png",
                        "学习计划",
                        () => setState(() {
                              earphoneStatus = 1;
                            })),
                    _titleItem(
                        "lib/images/radio.png",
                        "知识电台",
                        () => setState(() {
                              earphoneStatus = 2;
                            })),
                  ],
                )),
            new Divider(height: 1.0, color: Colors.grey.withOpacity(0.7)),
            new Expanded(
                child: new Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: _earphoneItemContent(earphoneStatus)))
          ],
        ));
  }

  Widget earphone(num index) {
    return new Container(
        width: MediaQuery.of(context).size.width,
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10.0),
        height: 210,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/earphone-back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(children: <Widget>[
          _earphoneItem(index),
          new Positioned(
              top: 8.0,
              right: 8.0,
              child: new InkWell(
                onTap: () {
                  print("ADD");
                },
                child: new PopupMenuButton(
                    color: Colors.black.withOpacity(0.7),
                    padding: EdgeInsets.all(0.0),
                    onSelected: (Options result) {
                      print(result);
                    },
                    icon: Icon(Icons.add,
                        size: 38.0, color: Colors.white.withOpacity(0.7)),
                    offset: Offset(0.0, 100.0),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<Options>>[
                          const PopupMenuItem<Options>(
                            value: Options.change,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.headset),
                              ),
                              title: Text("更换设备",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
//                          const PopupMenuItem<Options>(
//                            value: Options.add,
//                            child: ListTile(
//                              dense: true,
//                                contentPadding: EdgeInsets.all(0.0),
//                              leading:
//                                  Icon(Icons.add_a_photo, color: Colors.white),
//                              title: Align(
//                                alignment: Alignment(-2.0, 0),
//                                child: Text("添加设备",
//                                    style: TextStyle(color: Colors.white)),
//                              ),
//                            ),
//                          )
                        ]),
              ))
        ]));
  }

//  耳机状态
  _earphoneItem(num index) {
    switch (index) {
      case 0:
        return Center(
          child: new Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: new Container(
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
          ),
        );
        break;
      default:
        return new Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                if (index != 2) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BlueToothPage()));
                }
              },
              child: new Container(
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
                        image: index == 2
                            ? AssetImage("lib/images/earphone.png")
                            : AssetImage("lib/images/earphone-offline.png"),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: new ContainerBackground(
                              width: 24.0,
                              height: 24.0,
                              background: "lib/images/wifi.png"),
                        ),
                        new Text("离线", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 12.0, right: 6.0),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1.0,
                                  color: Colors.white,
                                  style: BorderStyle.solid)),
                          child: new Center(
                            child: new Text("8G",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10.0)),
                          ),
                        ),
                        new Text("100%", style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  new Container(
                      child: new Row(children: <Widget>[
                    new ContainerBackground(
                      width: 24.0,
                      height: 24.0,
                      background: "lib/images/battery-100.png",
                    ),
                    new Text("11%", style: TextStyle(color: Colors.white))
                  ]))
                ],
              ),
            ),
            new InkWell(
              child: new Text("设备编号：888888888888",
                  style: TextStyle(color: Colors.white)),
            )
          ],
        );
        break;
    }
  }

//  耳机内容列表
  _earphoneItemContent(num index) {
    switch (index) {
      //没有设备
      case 0:
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text("学习任务 2019/11/20")),
            new Divider(height: 1.0, color: Colors.grey.withOpacity(0.7)),
            new Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: courseList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                          child: _courseItem(
                              courseList[index]["imgUrl"],
                              courseList[index]["title"],
                              courseList[index]["desc"]));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        new Divider(
                            height: 1.0, color: Colors.grey.withOpacity(0.7))))
          ],
        );
        break;
      //有设备离线在线
      default:
        return new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  Container(child: new Text("学习任务 2019/11/12")),
                  new Expanded(child: new Container()),
                  Container(child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ConnectWifiPage(bluetoothDevice: null)));
                    },
                    child: Text("查看全部")))
                ],
              ),
            ),
            new Divider(height: 1.0, color: Colors.grey.withOpacity(0.7)),
            new Expanded(
                child: new Container(
                    child: new ListView(children: <Widget>[
              _deviceCourseItem(
                  imgUrl: "https://resource.qctchina.top/course1.png")
            ])))
          ],
        );
        break;
    }
  }

//  没有设备时展示列表项
  _courseItem(String imgUrl, String title, String desc) {
    return new Row(
      children: <Widget>[
        new Container(
            color: Colors.blueGrey,
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: 12.0),
            child: Image.network(imgUrl, fit: BoxFit.cover)),
        new Expanded(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  title,
                  style: TextStyle(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                new Text(
                  desc,
                  style: TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ]),
        )
      ],
    );
  }

//  有设备时展示的列表
  _deviceCourseItem(
      {String imgUrl,
      String clock,
      String title,
      String start,
      String desc,
      num planDay,
      num progress}) {
    return new Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: new Stack(
            children: <Widget>[
              new Container(
                  color: Colors.blueGrey,
                  width: 100,
                  height: 100,
                  child: Image.network(imgUrl, fit: BoxFit.cover)),
              Positioned(
                bottom: 0,
                child: new Container(
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5.0),
                  color: Colors.black.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.access_alarm,
                          size: 12.0, color: Colors.white),
                      new Text("15:35",
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.0)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: new Text(
                  "标题",
                  style: TextStyle(fontSize: 18.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new Text("开始时间：2019.11.14", style: TextStyle(fontSize: 12.0)),
              new Text(
                "描述",
                style: TextStyle(fontSize: 12.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              new Text("计划天数：52",
                  style: TextStyle(fontSize: 12.0, color: Colors.lightBlue))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ContainerBackground(
            width: 45.0,
            height: 45.0,
            background: "lib/images/finish.png",
            child: new Center(
              child: new Text(
                "50%",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        )
      ],
    );
  }

//子标题
  _titleItem(String imgUrl, String title, _tapCallback) {
    return new Expanded(
        child: InkWell(
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
      ),
      onTap: _tapCallback,
    ));
  }
}
