import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:m_commerce/constants.dart';
import 'package:m_commerce/screens/home_page.dart';
import 'package:m_commerce/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // If snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        // Connection Initialized - Firebase App is running
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              //if stream snapshot has error, display error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                );
              }

              // keep track live, check if user is logged in, checking the auth state
              if (streamSnapshot.connectionState == ConnectionState.active) {   // this just means FirebaseAuth.instance.authStateChanges(), code works

                // get user data
                User _user = streamSnapshot.data;

               // if user is not null, not logged in
                if(_user == null){
                  // user not logged in, head to loginPage
                  return LoginPage();

                }else{
                  // user is logged in, head to homePage
                  return HomePage();
                }
              }

              // checking the auth state
              return Scaffold(
                body: Center(
                  child:
                      Text('Checking Authentication...', style: Constants.regularHeading),
                ),
              );
            },
          );
        }

        // Connecting to Firebase - Loading
        return Scaffold(
          body: Center(
            child: Text(
              'Initializing App...',
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
