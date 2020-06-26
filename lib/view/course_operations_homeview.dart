import 'package:firebase_realtime_usage/core/models/course.dart';
import 'package:firebase_realtime_usage/core/services/firebase_service.dart';
import 'package:firebase_realtime_usage/view/course_form_view.dart';
import 'package:flutter/material.dart';

class CourseHomePage extends StatefulWidget {
  static int numberOfCourses;
  @override
  _FireHomeViewState createState() => _FireHomeViewState();
}

class _FireHomeViewState extends State<CourseHomePage> {
  Future<List<Course>> _courseList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _courseList = FirebaseService.prefInstance.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButtonRefresh,
      appBar: AppBar(title: Text("Course App"),),
      body: Column(
        children: <Widget>[
          CourseFormView(),
          Expanded(child: _courseFutureBuilder),
        ],
      )
    );
  }

  Widget get _floatingActionButtonRefresh =>FloatingActionButton.extended(
      icon: Icon(Icons.refresh),
      label: Text("Refresh"),
      backgroundColor: Colors.green,
      onPressed:() => refreshList()
  );

   void refreshList() {
    // reload
    setState(() {
      _courseList = FirebaseService.prefInstance.getCourses();
    });
  }

  Widget get _courseFutureBuilder =>FutureBuilder(
      future:_courseList,
      builder: (context, snapshot){
    //whatever returns from this function, will be avaliable inside snapshot paremeter.
    final List<Course> courseList = snapshot.data;
    CourseHomePage.numberOfCourses =courseList.length;
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        {
          return _waitingState();
        }
      case ConnectionState.done:
        if (snapshot.hasData) {
          //if (snapshot.data == List) {
          return _courseListBuilder(courseList);
          //}
        }
        return Text("Error occured");

      default:
        return _waitingState();
    }
  });

  Center _waitingState() => Center(child: CircularProgressIndicator(),);

  Widget _courseListBuilder(List<Course> list){
    return ListView.builder(itemCount: list.length,
        itemBuilder: (context, index) {
          return _courseCard(list, index);
        });
  }

  Card _courseCard(List<Course> courseList, int index) {
    return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(courseList.elementAt(index).name),
                    subtitle: Text(courseList.elementAt(index).grade),
                  ),
                );
  }
}