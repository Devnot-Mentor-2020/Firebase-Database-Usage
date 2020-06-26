import 'dart:convert';
import 'dart:io';
import 'package:firebase_realtime_usage/core/models/course.dart';
import 'package:firebase_realtime_usage/view/course_operations_homeview.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static FirebaseService  firebaseInstance = FirebaseService._init();
  static const String FIREBASE_URL = "https://fir-uusage.firebaseio.com/";

  static FirebaseService get prefInstance => firebaseInstance;

  FirebaseService._init();


  Future<List<Course>> getCourses() async {
    final response = await http.get("$FIREBASE_URL/courses.json");

    switch (response.statusCode) {
      case HttpStatus.ok:
        final decodedJson = json.decode(response.body) as List;
        List<Course> courseList =decodedJson.map((jsonMap) => Course.fromJson(jsonMap)).toList();
        //takes all elements in decodedjson one by one creates an course objectand hold them as list
        return courseList;
      default:
        return Future.error(response.statusCode);
    }
  }
  
  Future<bool> putCourse(Course course) async {
    int indexToPut = CourseHomePage.numberOfCourses;
    Map<String, String> headers = {"Content-type": "application/json"};
    var msg = json.encode(course.toJson());
    final response = await http.put("$FIREBASE_URL/courses/$indexToPut.json",headers: headers,body: msg);
    print(response.statusCode);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }
}