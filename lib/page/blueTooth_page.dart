import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlueToothPage extends StatefulWidget {
  @override
  _BlueToothPageState createState() => _BlueToothPageState();
}

class _BlueToothPageState extends State<BlueToothPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _bluetoothAnimation;
  AnimationController _bluetoothAnimationController;

  bool refresh = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> bluetoothList =
      List<BluetoothDiscoveryResult>();

  //  初始化页面
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bluetoothAnimationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
    _bluetoothAnimation = new CurvedAnimation(
        parent: _bluetoothAnimationController, curve: Curves.elasticOut);

    _bluetoothAnimation.addListener(() => this.setState(() {}));
    _initBluetooth();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bluetoothAnimationController.dispose();

    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffedeef0), Color(0xffe6e7e9)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Text("1/3 连接智能耳机",
                        style: TextStyle(color: Colors.green, fontSize: 12.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "连接准备添加的设备",
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text("请打开手机蓝牙",
                        style: TextStyle(color: Colors.black, fontSize: 14.0)),
                  ),
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: refresh
                              ? Icon(Icons.refresh, color: Colors.grey)
                              : Container(),
                        ),
                        Expanded(
                            child: Text("已发现的智能设备",
                                style: TextStyle(color: Colors.grey))),
                        InkWell(
                          onTap: _refreshBluetooth,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0))),
                            child: Text("刷新列表",
                                style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                      child: bluetoothList.length == 0
                          ? noContent()
                          : bluetoothListView())
                ],
              ),
            ),
            Positioned(
              top: _bluetoothAnimation.value * 80 - 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _bluetoothAnimationController.animateTo(0);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "请打开蓝牙",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  noContent() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              image: AssetImage('lib/images/bluetooth.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("没有发现蓝牙设备",
                style: TextStyle(
                    color: Colors.grey, fontSize: 16.0, letterSpacing: 3.0)),
          ),
          Text(
            "请刷新列表",
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.help_outline, color: Colors.grey, size: 14.0),
              Padding(
                padding: EdgeInsets.all(2.0),
              ),
              Text("列表中没有智能蓝牙设备",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0))
            ],
          )
        ],
      ),
    );
  }

  bluetoothListView() {
    return Container();
  }

  Future _initBluetooth() async {
    BluetoothState bluetoothStatus =
        await FlutterBluetoothSerial.instance.state;

//    监听蓝牙状态变化
    FlutterBluetoothSerial.instance.onStateChanged().listen((bluetoothState) {
      String bluetoothStateStr = bluetoothState.toString();
      if (bluetoothStateStr == "BluetoothState.STATE_OFF") {
        _bluetoothAnimationController.animateTo(1);
      } else if (bluetoothStateStr == "BluetoothState.STATE_ON") {
        _bluetoothAnimationController.animateTo(0);
      }
    });


    if (bluetoothStatus.toString() == "BluetoothState.STATE_OFF") {
      _bluetoothAnimationController.animateTo(1);
      return;
    }
    print("OK");

//    获取蓝牙设备信息
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        bluetoothList.add(r);
      });
    });
  }

  Future _refreshBluetooth() async {
    await FlutterBluetoothSerial.instance.cancelDiscovery();

    BluetoothState bluetoothStatus =
        await FlutterBluetoothSerial.instance.state;

    if (bluetoothStatus.toString() == "BluetoothState.STATE_OFF") {
      _bluetoothAnimationController.animateTo(1);
      return;
    }

    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        bluetoothList.add(r);
      });
    });
  }
}
