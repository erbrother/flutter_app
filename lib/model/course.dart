class Course {
  final int courseId;
  final String courseName;
  final String courseDescription;
  final String createTime;
  final int courseFree;
  final int courseCount;
  final String imageUrl;

  Course({this.courseId, this.courseName, this.courseDescription, this.createTime, this.courseFree, this.courseCount, this.imageUrl});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        courseId: json['courseId'],
        courseName: json['courseName'],
        courseDescription: json['courseDescription'],
        createTime: json['createTime'],
        courseFree: json['courseFree'],
        imageUrl: json['imageUrl'],
        courseCount: json['courseCount']);
  }
}