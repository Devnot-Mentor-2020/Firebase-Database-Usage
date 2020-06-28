class TextFieldValidator{
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