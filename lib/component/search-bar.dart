import 'package:flutter/material.dart';
//左侧带搜索icon的搜索输入框
class SearchBar extends StatelessWidget {

  final Widget child;
  final GestureTapCallback onTap;

  SearchBar({child, onTap}):
      child = (child != null ? child : new Container(child: new Text("请输入搜索内容", style: TextStyle(color: Colors.grey, fontSize: 12.0)))),
      onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: new Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: new Icon(Icons.search, color: Colors.grey, size: 18.0),
              ),
              new Expanded(child: InkWell(child: child, onTap: onTap))
            ],
          ),
        ));
  }
}
