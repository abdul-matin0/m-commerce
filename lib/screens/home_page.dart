import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // style: Constants.regularHeading,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlatButton(
              onPressed: () {
                // log-out
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                "Logout",
                style: Constants.regularHeading,
              ),
          ),
      ),
    );
  }
}
