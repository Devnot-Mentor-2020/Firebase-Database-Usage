import 'package:firebase_realtime_usage/core/models/course.dart';
import 'package:firebase_realtime_usage/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
class CourseHomePage extends StatefulWidget {
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<CourseHomePage> {
  FirebaseService service;

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(future:service.getCourses(),builder: (context, snapshot){//whatever returns from this function, will be avaliable inside snapshot paremeter.
        final List<Course> courseList = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return Center(child: CircularProgressIndicator(),);
            }
          case ConnectionState.done:
              if (snapshot.hasData) {
              //if (snapshot.data == List) {
                return ListView.builder(itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(courseList.elementAt(index).name),
                      subtitle: Text(courseList.elementAt(index).grade),
                    ),
                  );
                });
              //}
            }
            return Text("Error occured");

          default:
            return Center(child: CircularProgressIndicator(),);
        }
      }),
    );
  }
}