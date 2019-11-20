import 'package:flutter/material.dart';
import 'package:flutter_qc/page/earphone_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  Color _defaultColor = Colors.grey;
  Color _activeColor = Colors.green;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: BoxDecoration(gradient: LinearGradient(
          colors: [
            Color(0xffedeef0),
            Color(0xffe6e7e9),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: _contentItem(_currentIndex),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem('耳机', Icons.group, 0),
          _bottomItem('群组', Icons.group, 1),
          _bottomItem('我的', Icons.person, 2)
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return new BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  }

  _contentItem(int index) {
    List<Widget> contentPages = [
      new EarphonePage(),
      new Container(child: Center(child: Text("1"))),
      new Container(child: Center(child: Text("2"))),
    ];

    return contentPages[index];
  }
}
