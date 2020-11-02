import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_commerce/constants.dart';
import 'package:m_commerce/widgets/custom_btn.dart';
import 'package:m_commerce/widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  // create alert dialog
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);

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
      _registerFormLoading = true;
    });

    String createAccountFeedback = await _createAccount();
    // if createAccountFeedback == null i.e. no errors
    if(createAccountFeedback != null){
      // errors, show alert dialog displaying error message
      _alertDialog(createAccountFeedback);

      // stop form loading
      setState(() {
        _registerFormLoading = false;
      });
    }else{
      //no errors navigate to home page
      Navigator.pop(context);
    }
  }

  // default form loading page
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";

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
                  "Create A New Account",
                  style: Constants.boldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,

                  ),
                  CustomInput(
                    hintText: "Password",
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,

                    // submit form when user submits passwordField
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      // submit form
                      _submitForm();
                    },
                    isLoading: _registerFormLoading, // false i.e. not loading
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomBtn(
                  text: "Back to Login",
                  onPressed: () {
                    Navigator.pop(context);
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
