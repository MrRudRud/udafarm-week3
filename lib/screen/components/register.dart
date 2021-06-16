import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udafarm/screen/components/login.dart';
import 'package:udafarm/widget/constant.dart';
import 'dart:convert';

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
      setState(() => Navigator.pop(context));
    } else if (value == 2) {
      print(pesan);
      _snackBar(pesan);
    } else {
      _snackBar(pesan);
    }
  }

  void _snackBar(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          Text(
            "$pesan",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.orange,
    ));
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
                Center(
                  child: Text('Register',
                      style: Theme.of(context).textTheme.headline3),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.all(10.1),
                  child: TextFormField(
                    controller: cUsername,
                    validator: (val) => val!.length < 6
                        ? 'Username too short (min 6 character)'
                        : null,
                    onSaved: (val) => nUsername = cUsername.text,
                    decoration: InputDecoration(
                      hintText: 'username',
                      labelText: 'Input Username',
                      prefixIcon: Icon(Icons.people, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                      hintText: 'Email',
                      labelText: 'Input Email',
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
                      hintText: 'password',
                      labelText: 'Input Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.0),
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Submit',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                    ),
                    elevation: 8.0,
                    onPressed: () {
                      setState(() => checkForm());
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