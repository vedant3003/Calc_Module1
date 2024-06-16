import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/wrapper.dart';
import 'package:my_app/services/auth.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Calci());
}

class Calci extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    ); // MaterialApp
  }
}



