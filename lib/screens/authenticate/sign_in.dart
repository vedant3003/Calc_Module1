import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        title: Text('Sign In to Calculator'),
        actions: <Widget>[
          TextButton.icon(
            icon:Icon(Icons.person, color:Colors.white70),
            label: Text('Register Instead', style: TextStyle(color:Colors.white70)),
            onPressed: () async {
              widget.toggleView();

            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val!.isEmpty?'Email field cannot be empty':null,
                cursorColor: Colors.black87,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                  ),
                onChanged: (val){
                  setState(() => email=val);

                },
              ),
              const SizedBox(height:20.0),
              TextFormField(
                validator: (val) => val!.length<6?'Password must be atleast 6 characters long':null,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
                cursorColor: Colors.black87,
                obscureText: true,
                onChanged: (val){
                  setState(() => password=val);

                },
              ),
              SizedBox(height:20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color:Colors.white)
                ),
                onPressed: () async{
                  if(_formKey.currentState!.validate()){
                    dynamic result=await _auth.signInWithEmailAndPassword(email, password);

                     if(result==null){
                     setState(() => error='There was an error signing in with these credentials!');
                    }
                  }
                },
              ),
              SizedBox(height:12.0),
              Text(
                error,
                style: TextStyle(color:Colors.red, fontSize: 14.0),
              ),
            ]
          )
        )

      )
    );
  }
}
