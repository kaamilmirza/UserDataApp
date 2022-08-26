import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String name;
  final DateTime dob;
  final String phone;
  final String email;
  final String about;
  final String status;
  final String gender;                                                                                                                                                               


 User({ required this.email, required this.id, required this.dob, required this.about, required this.status, required this.gender, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'dob': dob,
      'phone': phone,
      'email': email,
      'about': about,
      'gender': gender,
      'status': status,

    };
  }

}