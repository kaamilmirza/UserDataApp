// ignore_for_file: sort_child_properties_last, unnecessary_string_escapes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:userprofileapp/model/user.dart';
import 'package:userprofileapp/utils/constants.dart';
import 'package:userprofileapp/widget/appbar_widget.dart';
import 'package:userprofileapp/widget/button_widget.dart';
import 'package:userprofileapp/widget/numbers_widget.dart';
import 'package:userprofileapp/widget/profile_widget.dart';
import 'package:userprofileapp/database/database.dart';
import 'package:userprofileapp/screens/DetailsScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _status = TextEditingController();
  final TextEditingController _about = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final _formKey1 = GlobalKey<FormState>();
  var gender;

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Form(
              key: _formKey1,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  ProfileWidget(
                    imagePath: 'assets/profilepic.jpg',
                    onClicked: () {},
                  ),
                  const SizedBox(height: 24),
                  NumbersWidget(),
                  // ignore: prefer_const_constructors
                  Container(
                    child: const Text(
                      "Account Settings",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    child: const Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty || v == "") {
                          return 'Enter something!';
                        } else {
                          return null;
                        }
                      },
                      controller: _name,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xff002B5B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: TextFormField(
                        validator: (val) => val!.isEmpty || !val.contains("@")
                            ? "Enter a valid eamil"
                            : null,
                      controller: _email,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xff002B5B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Phone",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: TextFormField(
                      controller: _phone,
                      validator: (v) {
                        if (v!.length != 10) {
                          return 'Incorrect phone number';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xff002B5B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Date of Birth",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${selectedDate.toLocal()}".split(' ')[0]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        IconButton(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_today_outlined),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: DropdownButton<String>(
                      value: gender,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Color.fromARGB(255, 84, 83, 83)),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 84, 83, 83),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          gender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "Status",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty || v == "") {
                          return 'Enter something!';
                        } else {
                          return null;
                        }
                      },
                      controller: _status,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xff002B5B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "About",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 114, 112, 112)),
                    ),
                    margin: const EdgeInsets.only(top: 30, left: 20),
                    width: double.infinity,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty || v == "") {
                          return 'Enter something!';
                        } else {
                          return null;
                        }
                      },
                      controller: _about,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xff002B5B),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey1.currentState!.validate()) {
                          // implement save form
                          print(_phone.text);
                          print(_email.text);
                        }
                       saveForm();
                        showSnackBar("Success", context, Colors.green);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff002B5B),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Details',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff002B5B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void saveForm() async
  {
   final User user = User(
        id: M.ObjectId(),
        email : _email.text,
        dob: selectedDate,
        about: _about.text,
        status: _status.text,
        gender: gender,
        name: _name.text,
        phone: _phone.text,
    );
    await MongoDatabase.insert(user);


  }


  Future<bool> getDetails() async
  {
   final User user = User(
        id: M.ObjectId(),
        email : _email.text,
        dob: selectedDate,
        about: _about.text,
        status: _status.text,
        gender: gender,
        name: _name.text,
        phone: _phone.text,
    );
    var ret = await MongoDatabase.insert(user);
    if(ret.isSuccess)
      {
        return true;
      }
    else
      {
        return false;
      }
  }

  void showSnackBar(String text, BuildContext context, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: color,
          content: Text(
            text,
          )),
    );

  }
}
