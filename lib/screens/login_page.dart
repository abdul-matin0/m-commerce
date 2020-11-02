import 'package:firebase_auth/firebase_auth.dart';
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

  // alert dialog
  Future<void> _alertDialog(String errorMessage) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        // prevents users from dismissing the dialog without pressing the close button
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(errorMessage),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close Dialog"),
              ),
            ],
          );
        });
  }

  // create new user account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);

      return null; // successfully
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        return "The password provided is too weak";
      } else if (e.code == "email-already-in-use") {
        return "The account already exists for that email";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // submit form and display error message on alert dialog
  void _submitForm() async{
    // onSubmit form, set loading state
    setState(() {
      _loginFormLoading = true;
    });

    String loginAccountFeedback = await _loginAccount();
    // if createAccountFeedback == null i.e. no errors
    if(loginAccountFeedback != null){
      // errors, show alert dialog displaying error message
      _alertDialog(loginAccountFeedback);

      // stop form loading
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // default form loading page
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for Input Fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    //initialize FocusNode
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  //dispose focusNode
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
                  CustomInput(
                    hintText: "Email",
                    onChanged: (value) {
                      _loginEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,

                  ),
                  CustomInput(
                    hintText: "Password",
                    onChanged: (value) {
                      _loginPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,


                    // submit form when user submits passwordField
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Login",
                    onPressed: () {
                      // submit form
                      _submitForm();
                    },
                    isLoading: _loginFormLoading, // false i.e. not loading
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
