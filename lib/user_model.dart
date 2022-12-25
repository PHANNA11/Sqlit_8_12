import 'package:sqlit8_12/database_field.dart';

class User {
  int? id;
  String? name;
  int? age;
  String? profile;
  User({this.age, this.id, this.name, this.profile});
  Map<String, dynamic> toJsonData() {
    return {fId: id, fName: name, fAge: age, fprofile: profile};
  }

  User.fromJsonData(Map<String, dynamic> res)
      : id = res[fId],
        name = res[fName],
        age = res[fAge],
        profile = res[fprofile];
}
