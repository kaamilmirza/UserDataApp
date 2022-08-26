import 'package:flutter/material.dart';
import 'package:userprofileapp/database/database.dart';
import './screens/UserScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MongoDatabase.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Profile Settings',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Satoshi'),
      initialRoute: '/',
      routes: {
        '/': (context) => ProfilePage(),
      },
    );
  }
}
