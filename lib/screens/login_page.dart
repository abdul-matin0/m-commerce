import 'package:flutter/material.dart';
import 'package:m_commerce/constants.dart';
import 'package:m_commerce/screens/register_page.dart';
import 'package:m_commerce/widgets/custom_btn.dart';
import 'package:m_commerce/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "Welcome User,\n Login to your account",
                  style: Constants.boldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  CustomInput(hintText: "Email"),
                  CustomInput(hintText: "Password"),
                  CustomBtn(
                    text: "Login",
                    onPressed: () {
                      print("Login Button Clicked");
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 9.0,
                ),
                child: CustomBtn(
                  text: "Create New Account",
                  onPressed: () {
                    // navigate to register_page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
