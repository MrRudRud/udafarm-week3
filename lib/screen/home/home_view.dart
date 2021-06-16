import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udafarm/screen/components/login.dart';

import 'package:udafarm/screen/home/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? username = '', fullname = '';

  // Method Sign out
  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", 0);
      sharedPreferences.clear();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    });
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      username = sharedPreferences.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: HomeBody(),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataPref();
  }

  AppBar buildAppbar() {
    return AppBar(
      title: Text(
        'Welcome $username ',
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: Icon(Icons.person),
      actions: [
        IconButton(
          onPressed: () {
            signOut();
          },
          icon: Icon(Icons.exit_to_app),
        )
      ],
    );
  }
}
