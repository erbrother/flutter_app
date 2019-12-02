import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BlueToothPage extends StatefulWidget {
  @override
  _BlueToothPageState createState() => _BlueToothPageState();
}

class _BlueToothPageState extends State<BlueToothPage>
    with TickerProviderStateMixin {
//  蓝牙提示动画
  Animation<double> _bluetoothAnimation;
  AnimationController _bluetoothAnimationController;

//  刷新动画
  Animation<double> _bluetoothRefreshAnimation;
  AnimationController _bluetoothRefreshAnimationController;

  bool refresh = false;

//  key
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> _bluetoothListKey = GlobalKey();

//  蓝牙相关api
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription  _subscription;

//  蓝牙设备列表
  List<ScanResult> bluetoothList = new List();

  //  初始化页面
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bluetoothAnimationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
    _bluetoothAnimation = new CurvedAnimation(
        parent: _bluetoothAnimationController, curve: Curves.elasticOut);

    _bluetoothRefreshAnimationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
    _bluetoothRefreshAnimation = new CurvedAnimation(
        parent: _bluetoothRefreshAnimationController, curve: Curves.linear);

    _bluetoothAnimation.addListener(() => this.setState(() {}));
    _bluetoothRefreshAnimation.addListener(() => this.setState(() {}));

//    _initBluetooth();
    _initFlutterBluetooth();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bluetoothAnimationController?.dispose();
    _bluetoothRefreshAnimationController?.dispose();
    flutterBlue.stopScan();
    _subscription.cancel();
    super.dispose();
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
                          child: Transform.rotate(
                            angle: _bluetoothRefreshAnimation.value * 2 * pi -
                                pi / 2,
                            child: refresh
                                ? Icon(Icons.refresh, color: Colors.grey)
                                : Container(),
                          ),
                        ),
                        Expanded(
                            child: refresh
                                ? Text("正在搜索设备中...",
                                    style: TextStyle(color: Colors.grey))
                                : Text("已发现的智能设备",
                                    style: TextStyle(color: Colors.grey))),
                        Ink(
                          child: InkWell(
                            onTap: _refreshBluetooth,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14.0))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 5.0),
                              child: Text("刷新列表",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  new Expanded(
                      child: bluetoothList.length == 0 && refresh == false
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

  Widget noContent() {
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

  Widget bluetoothListView() {
    return AnimatedList(
        key: _bluetoothListKey,
        padding: const EdgeInsets.all(8),
        initialItemCount: bluetoothList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index, animation) {
          return FadeTransition(
            opacity: animation,
            child: InkWell(
              onTap: () => connectDevice(index),
              child: Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(6.0))),
                  height: 50,
                  child: Center(
                      child: bluetoothList[index].device.name ==  null || bluetoothList[index].device.name == ""
                          ? Text("未知设备")
                          : Text('${bluetoothList[index].device.name}'))),
            ),
          );
        });
  }

  _initFlutterBluetooth() async {
    flutterBlue.state.listen((BluetoothState state) {
      if (state == BluetoothState.off) {
        _bluetoothAnimationController.animateTo(1);
      }

      if (state == BluetoothState.on) {
        _bluetoothAnimationController.animateTo(0);
      }
    });
    _getBluetoothList();
  }

  _getBluetoothList() async{
    if (!await flutterBlue.isOn)
      return _bluetoothAnimationController.animateTo(1);

    // Listen to scan results
    setState(() {
      refresh = true;
    });
    _bluetoothRefreshAnimationController.repeat();
    _subscription = flutterBlue.scan(timeout: Duration(seconds: 4)).listen((scanResult) {
      // do something with scan result
      num index = bluetoothList.indexOf(scanResult);
      if(index == -1) addBluetoothListItem(scanResult);
    });
    _subscription.onDone(handleDone);
  }
//  刷新蓝牙按钮
  Future _refreshBluetooth() async {
    if(refresh == true) return;
    if (!await flutterBlue.isOn){
      _bluetoothAnimationController.animateTo(1);
      return;
    }
    _clearAllItems();
    _getBluetoothList();
  }

  handleDone() {
    _bluetoothRefreshAnimationController.stop();
    setState(() {
      refresh = false;
    });
  }

//    连接蓝牙设备
  connectDevice(int index) async{
    print(bluetoothList[index].device.name);
    await bluetoothList[index].device.connect();
    List<BluetoothService> services = await bluetoothList[index].device.discoverServices();
    services.forEach((service) {
      // do something with service
      print(service);
    });
  }

  void addBluetoothListItem(ScanResult r) {
    int index = bluetoothList.length;

    bluetoothList.add(r);
    _bluetoothListKey.currentState
        .insertItem(index, duration: Duration(milliseconds: 500));
  }

  void _clearAllItems() {
    for (var i = 0; i <= bluetoothList.length - 1; i++) {
      _bluetoothListKey.currentState.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }
    bluetoothList.clear();
  }
}
