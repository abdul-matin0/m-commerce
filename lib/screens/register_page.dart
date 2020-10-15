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
  Future<void> _alertDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        // prevents users from dismissing the dialog without pressing the close button
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text("Just Another Message "),
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

  // default form loading page
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";

  // Focus Node for Input Fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    //initialize FoucsNode
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
                    onSubmitted: (value){
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
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: () {
                      // _alertDialog();
                      setState(() {
                        //set state and that state would change some values
                        _registerFormLoading = true;
                      });
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
    ;
  }
}
