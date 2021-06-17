import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udafarm/screen/components/register.dart';
import 'package:udafarm/widget/bottom_navbar.dart';
import 'package:udafarm/widget/button_universal.dart';
import 'dart:convert';

import 'package:udafarm/widget/constant.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum statusLogin { signIn, notSignIn }

class _LoginPageState extends State<LoginPage> {
  statusLogin _loginStatus = statusLogin.notSignIn;

  final _keyForm = GlobalKey<FormState>();
  String? nUsername = '', nPassword = '';
  bool _obscureText = true;

  // Cek Form ketika klik tombol login
  checkForm() {
    final form = _keyForm.currentState;
    if (form!.validate()) {
      form.save();
      submitDataLogin();
    }
  }

  // Mengirim request dan callback data
  submitDataLogin() async {
    final responseData =
        await http.post(Uri.parse(baseUrl + "login.php"), body: {
      "username": nUsername,
      "password": nPassword,
    });

    final data = jsonDecode(responseData.body);
    // print(data);

    // get data & response
    int value = data['value'];
    String pesan = data['message'];

    // cek value 1 or 0 (true/false)
    if (value == 1) {
      setState(() {
        String dataUsername = data['username'];
        String dataEmail = data['email'];
        String dataTanggalDaftar = data['tgl_daftar'];
        String dataIdUser = data['id_user'];
        // set status loginnya sbg login
        _loginStatus = statusLogin.signIn;
        print(_loginStatus);
        // simpan data ke shared preferences
        saveDataPref(
            value, dataIdUser, dataUsername, dataEmail, dataTanggalDaftar);
      });
    } else if (value == 2) {
      print(pesan);
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
            " $pesan",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.amber,
    ));
  }

  // method untuk simpan ke shared preferences
  saveDataPref(int value, String dataIdUser, String dataUsername,
      String dataEmail, String dataTanggalDaftar) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("username", dataUsername);
      sharedPreferences.setString("id_user", dataUsername);
      sharedPreferences.setString("email", dataEmail);
      sharedPreferences.setString("tgl_daftar", dataTanggalDaftar);
    });
  }

  // Method untuk cek user (Login atau blm) jk sudah set value
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int? nvalue = sharedPreferences.getInt("value");
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
      print(_loginStatus);
    });
  }

  void initState() {
    getDataPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
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
                      width: 150,
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text('Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: kTextColor)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (val) => val!.length < 6
                            ? 'Username too short (min 6 character)'
                            : null,
                        onSaved: (val) => nUsername = val,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: kPrimaryColor),
                          hintText: 'username',
                          prefixIcon: Icon(Icons.people, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Please input password' : null,
                        onSaved: (val) => nPassword = val,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() => _obscureText = !_obscureText);
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          hintText: 'Password',
                          labelText: 'Password',
                          labelStyle: TextStyle(color: kPrimaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100.0),
                      child: ButtonUniversal(
                        text: "Submit",
                        press: () {
                          setState(() {
                            checkForm();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: MaterialButton(
                        textColor: Colors.black,
                        child: Text(
                          'Belum punya akun? Silahkan Daftar',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
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

      case statusLogin.signIn:
        return BottomNav();
    }
  }
}
