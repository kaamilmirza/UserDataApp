import 'package:mongo_dart/mongo_dart.dart';
import 'package:userprofileapp/model/user.dart';

import '../utils/constants.dart';

class MongoDatabase {
  static var db;
  static var userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
  }


  static insert(User user) async {
    var ret = await userCollection.insertAll([user.toMap()]);
    return ret;
  }

  static Future<List<Map<String, dynamic>>> getDocuments(User user) async {
    try {
      final users = await userCollection.find().where('_id', user.id ).toList();
      return users;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
  static update(User user) async {
    var u = await userCollection.findOne({"_id": user.id});
    u["name"] = user.name;
    u["dob"] = user.dob;
    u["phone"] = user.phone;
    u["dob"] = user.dob;
    u["email"] = user.email;
    u["about"] = user.about;
    u["gender"] = user.gender;
    u["status"] = user.status;
    await userCollection.save(u);
  }

  static delete(User user) async {
    await userCollection.remove(where.id(user.id));
  }
}