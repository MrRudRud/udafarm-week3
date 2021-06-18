import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:udafarm/screen/components/login.dart';
import 'package:udafarm/widget/button_universal.dart';
import 'package:udafarm/widget/constant.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Validation
  var cUsername = TextEditingController();
  var cEmail = TextEditingController();
  var cPassword = TextEditingController();

  //deklarasi untuk masing-masing widget
  String? nUsername, nEmail, nPassword;

  //menambahkan key form

  final _keyForm = GlobalKey<FormState>();

  // event when user clicked register button
  checkForm() {
    final form = _keyForm.currentState;

    if (form!.validate()) {
      form.save();
      submitDataRegister();
    }
  }

  submitDataRegister() async {
    final response =
        await http.post(Uri.parse(baseUrl + 'register.php'), body: {
      "username": nUsername,
      "email": nEmail,
      "password": nPassword,
    });

    final data = jsonDecode(response.body);
    print(data);

    int value = data["value"];
    String pesan = data["message"];

    // check value 1 and 0
    if (value == 1) {
      _snackBar(pesan);
      await Future.delayed(Duration(milliseconds: 2000));
      setState(() => Navigator.pop(context));
    } else if (value == 2) {
      print(pesan);
      _snackBar(pesan);
    } else {
      _snackBar(pesan);
    }
  }

  void _snackBar(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            Text(
              " $pesan",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        duration: Duration(seconds: 3),
        backgroundColor: kPrimaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                SvgPicture.asset(
                  'assets/svg/farm-ico.svg',
                  width: 120,
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Text('Register',
                      style: Theme.of(context).textTheme.headline4),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: cUsername,
                    validator: (val) => val!.length < 6
                        ? 'Username too short (min 6 character)'
                        : null,
                    onSaved: (val) => nUsername = cUsername.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: kPrimaryColor),
                      hintText: 'Input username',
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.people, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.1),
                  child: TextFormField(
                    controller: cEmail,
                    validator: (val) =>
                        val!.contains('@') ? null : 'Invalid Email',
                    onSaved: (val) => nEmail = cEmail.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: kPrimaryColor),
                      hintText: 'Input Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.1),
                  child: TextFormField(
                    controller: cPassword,
                    validator: (val) => val!.length < 6
                        ? 'Password too short (min 6 character)'
                        : null,
                    onSaved: (val) => nPassword = cPassword.text,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kPrimaryColor,
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(color: kPrimaryColor),
                      hintText: 'Input Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.0),
                  child: ButtonUniversal(
                    text: 'Submit',
                    press: () {
                      setState(() {
                        checkForm();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text('Sudah Punya Akun? Silahkan Login',
                        style: Theme.of(context).textTheme.bodyText2),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
