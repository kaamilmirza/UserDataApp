//default flutter screen
import 'package:flutter/material.dart';
import 'package:userprofileapp/model/user.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Text('Details'),
        
      ),
    );
  }
}