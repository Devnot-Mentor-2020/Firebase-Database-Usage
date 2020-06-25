import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_realtime_usage/core/models/course.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_URL = "https://fir-uusage.firebaseio.com/";

  //BaseService _baseService = BaseService.instance;

  /*Future postUser(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(FIREBASE_AUTH_URL, body: jsonModel);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        var errorJson = json.decode(response.body);
        var error = FirebaseAuthError.fromJson(errorJson);
        return error;
    }
  }*/

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
}