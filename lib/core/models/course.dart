class Course {
  String _grade;
  String _name;

  Course({String grade, String name}) {
    this._grade = grade;
    this._name = name;
  }

  String get grade => _grade;
  set grade(String grade) => _grade = grade;
  String get name => _name;
  set name(String name) => _name = name;

  Course.fromJson(Map<String, dynamic> json) {
    _grade = json['grade'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grade'] = this._grade;
    data['name'] = this._name;
    return data;
  }
}