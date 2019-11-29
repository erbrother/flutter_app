import 'package:flutter/material.dart';

import 'image-bottom-title.dart';

class CourseItem extends StatelessWidget {
  final num courseId;
  final String imgUrl;
  final num courseCount;
  final String title;
  final String time;
  final String desc;
  final GestureTapCallback onTap;

  CourseItem({this.courseId, this.imgUrl, this.title, this.time, this.desc, this.onTap, this.courseCount = 0});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6.0, offset: Offset(6.0, 6.0))]
        ),
        child: new Row(children: <Widget>[
          new ImageBottomTitle(
              width: 100.0,
              height: 100.0,
              imgUrl: imgUrl,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.headset, size: 16.0, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: new Text("$courseCount节课",
                          style:
                          TextStyle(color: Colors.white, fontSize: 12.0)),
                    ),
                  ])),
          new Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        new Text("开课时间: $time"),
                        new Text(
                          "$desc",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ])))
        ]),
      ),
    );
  }
}
