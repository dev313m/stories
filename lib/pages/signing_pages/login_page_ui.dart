import 'package:flutter/material.dart';
import 'dart:async';

AnimationController _controller;

Widget RegisterBtn(AnimationController controller) {
  _controller = controller;
}

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 380.0,
      height: 60.0,
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: const Color.fromRGBO(247, 64, 106, 1.0),
        borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
      ),
      child: new Text(
        "Sign In",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    ));
  }
}

Widget introWidget(
    String first, String second, double screenWidth, double screenHeight) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
        child: Text('Hello',
            style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple)),
      ),
      Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 160.0, 0.0, 0.0),
            child: Text('There',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 160.0, 0.0, 0.0),
            child: Text('.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
          )
        ],
      ),
    ],
  );
}

Widget WaitLabel() {
  return Container(
    alignment: Alignment(0.0, 1.0),
    padding: EdgeInsets.only(top: 15.0, left: 20.0),
    child: InkWell(
      child: Text(
        '(Fill the fields..)',
        style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            decoration: TextDecoration.none),
      ),
    ),
  );
}

Widget loveWidget( double value, AnimationController ctrl) {
  return Container(
    height: 60.0,
    width: 380 - value,
    child: Material(
      borderRadius: BorderRadius.circular(25.0),
      shadowColor: Colors.greenAccent,
      color: Colors.green,
      elevation: 7.0,
      child: InkWell(
        borderRadius: new BorderRadius.circular(25),
        splashColor: Colors.pinkAccent,
        onTap: () {
          ctrl.forward(); 
        },
        child: Center(
          child: Text(
            'Register',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'),
          ),
        ),
      ),
    ),
  );
}