import 'package:sqlit8_12/database_field.dart';

class User {
  int? id;
  String? name;
  int? age;
  User({this.age, this.id, this.name});
  Map<String, dynamic> toJsonData() {
    return {fId: id, fName: name, fAge: age};
  }

  User.fromJsonData(Map<String, dynamic> res)
      : id = res[fId],
        name = res[fName],
        age = res[fAge];
}
