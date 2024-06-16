import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({super.key, required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey=GlobalKey<FormState>();

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.0,
          title: Text('Sign Up to Calculator'),
          actions: <Widget>[
            TextButton.icon(
              icon:Icon(Icons.person, color:Colors.white70),
              label: Text('Sign In Instead', style: TextStyle(color:Colors.white70)),
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
                        style: TextStyle(color: Colors.white),
                        validator: (val) => val!.isEmpty?'Email field cannot be empty':null,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        onChanged: (val){
                          setState(() => email=val);

                        },
                      ),
                      const SizedBox(height:20.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                          validator: (val) => val!.length<6?'Password must be atleast 6 characters long':null,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white70),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
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
                            'Register',
                            style: TextStyle(color:Colors.white)
                        ),
                        onPressed: () async{
                          if(_formKey.currentState!.validate()){
                            dynamic result= await _auth.registerWithEmailAndPassword(email,password);
                            if(result==null){
                              setState(() => error='Please enter a valid email!');
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
