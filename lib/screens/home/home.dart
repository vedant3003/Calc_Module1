import 'package:flutter/material.dart';
import 'package:my_app/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:my_app/services/auth.dart';

class HomePage extends StatefulWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  List<String> buttons = ['C', '+/-', '%', '<--', '7', '8', '9', '/', '4', '5', '6', 'x', '1', '2', '3', '-', '0', '.', '=','+',];
  var n = '';
  var ans = '';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CALCULATOR', style: TextStyle(color: Colors.white, fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.teal[600],
          actions: <Widget>[
            TextButton.icon(
              icon:Icon(Icons.person, color:Colors.white70),
              label: Text('Logout', style: TextStyle(color:Colors.white70)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        backgroundColor: Colors.white10,
        body:
        Column(
          children: <Widget>[
            Expanded(
              flex:4,
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(18),
                        alignment: Alignment.centerRight,
                        child: Text(
                          n,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(7),
                        alignment: Alignment.centerRight,
                        child: Text(
                          ans,
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {

                      if (index == 0) {
                        return currButton(
                          buttontapped: () {
                            setState(() {
                              n = '';
                              ans = '0';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.indigo,
                        );
                      }


                      else if (index == 1) {
                        return currButton(
                          buttontapped: () {
                            setState(() {
                              n='-'+'('+n+')';
                            });
                          },
                          buttonText: '+/-',
                          color: Colors.black,
                          textColor: Colors.indigo,
                        );
                      }

                      else if (index == 2) {
                        return currButton(
                          buttontapped: () {
                            setState(() {
                              n += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.indigo,
                        );
                      }

                      else if (index == 3) {
                        return currButton(
                          buttontapped: () {
                            setState(() {
                              n =
                                  n.substring(0, n.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.indigo,
                        );
                      }

                      else if (index == 18) {
                        return currButton(
                          buttontapped: () {
                            setState(() {
                              result();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: Colors.indigo,
                        );
                      }


                      else {
                        return currButton(
                          buttontapped: () {
                            setState(() {
                              n += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.black,
                          textColor: OpCheck(buttons[index]) ? Colors.indigo : Colors.white,
                        );
                      }
                    }), // GridView.builder
              ),
            ),
          ],
        )
    );
  }
  bool OpCheck(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }


  void result() {
    String inp = n;
    Parser p = Parser();
    inp = n.replaceAll('x', '*');
    Expression exp = p.parse(inp);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    ans = eval.toString();
  }
}