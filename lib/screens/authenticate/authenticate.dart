import 'package:flutter/material.dart';
import 'package:my_app/screens/authenticate/sign_in.dart';
import 'package:my_app/screens/authenticate/register.dart';
class Authenticate extends StatefulWidget {
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn=true;
  void toggleView(){
    setState(() => showSignIn=!showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
