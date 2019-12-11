import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectWifiPage extends StatefulWidget {
  final BluetoothDevice bluetoothDevice;

  ConnectWifiPage({this.bluetoothDevice});

  @override
  _ConnectWifiPageState createState() => _ConnectWifiPageState();
}

class _ConnectWifiPageState extends State<ConnectWifiPage>
    with SingleTickerProviderStateMixin {
  Animation wifiAnimation;
  AnimationController wifiAnimationController;

  //  初始化页面
  @override
  void initState() {
    super.initState();
    print(widget.bluetoothDevice.name);
    wifiAnimationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    wifiAnimation = new CurvedAnimation(
        parent: wifiAnimationController, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "blue",
      child: Scaffold(
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("2/3 连接智能耳机",
                          style:
                              TextStyle(color: Colors.green, fontSize: 12.0)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "选择需要连接的网络",
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("耳机将会连接到您输入的WIFI",
                          style:
                              TextStyle(color: Colors.black, fontSize: 14.0)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    new Expanded(child: Container()),
                  ],
                ),
              ),
              Positioned(
                top: wifiAnimation.value * 80 - 50,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          wifiAnimationController.animateTo(0);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "请打开WIFI",
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
      ),
    );
  }

//  连接蓝牙设备
  connectDevice(int index, bluetoothDevice, bleSendSequence) async {
    await bluetoothDevice.connect();
    var characteristic;
    var readCharacteristic;

    bleSendSequence = 0;
    List<BluetoothService> services = await bluetoothDevice.discoverServices();

    for (BluetoothService service in services) {
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        print(
            "notify and write: ${c.properties.notify}, ${c.properties.write}");
        if (c.properties.write) {
          characteristic = c;
        }

        if (c.properties.notify) {
          readCharacteristic = c;
        }
      }
    }

    print("isNotifying ${readCharacteristic.isNotifying}");
    if (!readCharacteristic.isNotifying) {
      await readCharacteristic.setNotifyValue(true);
    }

    List<int> resVal = new List();
    readCharacteristic.value.listen((value) {
//      String valStr = utf8.decode(value);
      if (value.length < 4) return;
      print(value);
      if (value[1] == 20) {
        value.sublist(4, value.length).forEach((v) {
          resVal.add(v);
        });
        return;
      }

      if (value[1] == 4) {
        value.sublist(4).forEach((v) {
          resVal.add(v);
        });

        print(utf8.decode(resVal));

        print(utf8.encode("Qc"));

        resVal.clear();
      }
    });
  }

  Future sendCMD(BluetoothCharacteristic characteristic, cmd, subCMD,
      frameControl, payload, bleSendSequence) async {
    var lsb = ((subCMD & 0x3f) << 2) | (cmd & 0x03);
    var u8array = new List<int>();
    u8array.add(lsb);
    u8array.add(frameControl);
    u8array.add(bleSendSequence);
    u8array.add(payload.length);

    for (int i = 0; i < payload.length; i++) {
      u8array.add(payload[i]);
    }

    await characteristic.write(u8array);
  }

  sendName(characteristic, bleSendSequence) async {
    String name = "Qc";

    List<int> nameArr = utf8.encode(name);
    await sendCMD(characteristic, 0x01, 0x02, 0, nameArr, bleSendSequence);
    bleSendSequence++;
//    characteristic.write(value)
  }

  sendPassword(characteristic, bleSendSequence) async {
    String password = "32218180";

    List<int> passwordArr = utf8.encode(password);
    await sendCMD(characteristic, 0x01, 0x03, 0, passwordArr, bleSendSequence);
    bleSendSequence++;
    await sendCMD(characteristic, 0x00, 0x03, 0, '', bleSendSequence);
    bleSendSequence++;
  }

//  检查连接状态
  checkConnect(characteristic, bleSendSequence) {
    sendCMD(characteristic, 0x00, 0x05, 0, '', bleSendSequence);
    bleSendSequence++;
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.black.withOpacity(0.55),
            height: 300,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("列表中没有启辰智能耳机?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("1. 手机离设备近一些",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("2. 请确保您的设备处于开机状态",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("3. 请确保您的手机已经开启蓝牙",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("4. 点击刷 “刷新列表” 按钮可以重新搜索设备",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "5. 只能耳机的蓝牙名称默认为 “启辰智能耳机-001”, 后续可在用户中心进行设备名称修改",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black)),
                          ),
                        ]),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Center(
                        child: Text("我知道了",
                            style:
                                TextStyle(color: Colors.green, fontSize: 16.0)),
                      ),
                    ),
                  )
                ]),
          );
        });
  }
}