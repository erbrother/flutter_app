import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qc/common/util/http.dart';
import 'package:flutter_qc/component/course-item.dart';
import 'package:flutter_qc/component/search-bar.dart';
import 'package:flutter_qc/model/course.dart';

class CoursePage extends StatefulWidget {
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    super.initState();
    print("Course initState");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffedeef0), Color(0xffe6e7e9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: new Column(children: <Widget>[
          // 搜索栏
          new SearchBar(onTap: () => print("123")),
          // 标题
          Container(
            margin: EdgeInsets.only(bottom: 12.0),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text("全部资源", textAlign: TextAlign.center)),
                new Text("|",
                    style: TextStyle(fontSize: 22.0, color: Colors.grey)),
                new Expanded(
                    child: new Text("词汇", textAlign: TextAlign.center)),
                new Text("|",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                new Expanded(
                    child: new Text("教材", textAlign: TextAlign.center)),
                new Text("|",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                new Expanded(
                    child: new Text("英语", textAlign: TextAlign.center)),
                new Text("|",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey)),
                new Expanded(
                    child: new Text("...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24.0, height: 0.5))),
              ],
            ),
          ),
          // 课程列表
          new Expanded(
              child: FutureBuilder(
                  future: _getCourse(),
                  builder: (context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return new Center(child: new Text("暂无内容"));
                      case ConnectionState.waiting:
                        return new Center(child: new Text("正在加载"));
                      default:
                        if (snapshot.hasError)
                          return new Center(child: new Text("暂无内容"));
                        else
                          return _createListView(context, snapshot);
                    }
                  }))
        ]),
      ),
    );
  }

  Future<List<Course>> _getCourse() async {
    List<Course> courseList = List<Course>();
    Response response =
        await dio.get("/wechat/course/list?currentPage=1&pageSize=20");
    print(response);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = response.data;
      if (result["code"] == 0) {
        for (dynamic data in result["info"]["records"]) {
          Course courseData = Course.fromJson(data);
          courseList.add(courseData);
        }
      } else if (result["code"] == 12) {
        print(result["message"]);
      }
    }

    return courseList;
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Course> courseList = snapshot.data;
    return ListView.builder(
      itemCount: courseList.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Course courseItemData = courseList[index];

        return new CourseItem(
            title: courseItemData.courseName,
            imgUrl: courseItemData.imageUrl,
            time: courseItemData.createTime,
            courseCount: courseItemData.courseCount,
            desc: courseItemData.courseDescription,
            onTap: () {
              print(courseItemData.courseId);
            });
      },
    );
  }
}
