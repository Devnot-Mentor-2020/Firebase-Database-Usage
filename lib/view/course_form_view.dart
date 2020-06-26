import 'package:firebase_realtime_usage/core/models/course.dart';
import 'package:firebase_realtime_usage/core/services/firebase_service.dart';
import 'package:flutter/material.dart';

class CourseFormView extends StatefulWidget {
  final FirebaseService service;
  const CourseFormView(
      {Key key,this.service})
      : super(key: key);
  @override
  _CourseFormViewState createState() => _CourseFormViewState();
}

class _CourseFormViewState extends State<CourseFormView> {
  String _courseName;
  String _letterGrade;
  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return courseForm(context);
  }

  Form courseForm(BuildContext context) {

    return Form(
      key: formKey,
      autovalidate: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          usernameTextField(),
          passwordTextField(),
          _addCourseButton(context),
        ],
      ),
    );
  }

  Padding usernameTextField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Enter Course Name",
          labelText: "Course Name",
          border: OutlineInputBorder(),
        ),
        validator: (value) =>validateCourseName(value),
        onSaved: (input) => _courseName=input,
      ),
    );
  }


  Padding passwordTextField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          hintText: "Enter letter grade",
          labelText: "Grade",
          border: OutlineInputBorder(),
        ),
        validator: (value) =>validateLetterGrade(value),
        onSaved: (input) => _letterGrade=input,
      ),
    );
  }

  InkWell _addCourseButton(BuildContext context) {
    return InkWell(
      onTap: ()=> _saveGivenInformation(context),
      child: Container(
        width: MediaQuery.of(context).size.width*(8/9),
        height: MediaQuery.of(context).size.height*(1/12),
        decoration: BoxDecoration(
          color: Colors.redAccent.shade100,
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(child: Text('Add Course', style: TextStyle(fontSize: 18.0, color: Colors.white),),),
      ),
    );
  }
  void _saveGivenInformation(BuildContext context) async{
    if(formKey.currentState.validate()){
      formKey.currentState.save();
      Course course = Course(name: _courseName,grade: _letterGrade);
      await FirebaseService.prefInstance.putCourse(course);
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("Course Name $_courseName, Letter Grade $_letterGrade is added"),
      ));
    }
  }

  String validateCourseName(String name){
    if(name.length <5){
      return "Course name should be longer";
    }
    else{
      return null;
    }
  }

  String validateLetterGrade(String grade){
    if(grade.length != 2){
      return "Grade must be 2 character";
    }
    else{
      return null;
    }
  }

}
