import 'package:flutter/material.dart';
import 'package:easy_job/pages/signing_pages/ui.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/foundation.dart';
import 'package:easy_job/pages/x_custom_main/index.dart';
import 'dart:async';

class Validator {
  bool usernameValidator(String username) {
    if (username != null && username.length > 3) return true;
  }

  bool passwordValidator(String password) {
    if (password != null && password.length > 3) return true;
  }
}

class LoginPage extends StatefulWidget {
  String checkCredentials(String username, String password) {
    if (username == 'uxbert' && password == 'uxbert') return 'Success';
    return 'Error';
  }

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;
  double someConst = 45;
  double someConst2 = 340;
  int txt = 0;
  bool _validate = false;
  bool _passValidate = false;

  AnimationController animationController;
  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        upperBound: 340,
        lowerBound: 1);
    animationController.addListener(() {
      this.setState(() {
        someConst = 45 - animationController.value;
        someConst2 = 340 - (0.5 * animationController.value);
      });
    });
    // animationController.forward();
    super.initState();
    // register = WaitLabel();
  }

//This widget shows A brief nice home intro for pages.

  final txtController = TextEditingController(text: '');
  final passswordController = TextEditingController(text: '');

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    txtController.dispose();
    super.dispose();
  }

  validateText() {
    setState(() {
      txt = txtController.text.length;
      _validate = false;
      _passValidate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return new Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            introWidget('Hello', 'There', screenWidth, screenHeight),
            Container(
                padding: EdgeInsets.only(
                    top: screenWidth / 3, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      enabled: true,
                      controller: txtController,
                      maxLength: 9,
                      maxLengthEnforced: true,
                      keyboardType: TextInputType.text,
                      onChanged: (String) {
                        validateText();
                      },
                      decoration: InputDecoration(
                        errorText: _validate ? 'There is an error!' : null,
                        labelText: 'Username: (uxbert)',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                    TextField(
                      enabled: true,
                      controller: passswordController,
                      obscureText: true,
                      maxLength: 9,
                      maxLengthEnforced: true,
                      keyboardType: TextInputType.text,
                      onChanged: (String) {
                        validateText();
                      },
                      decoration: InputDecoration(
                        errorText: _passValidate ? 'There is an error' : null,
                        labelText: 'Password: (uxbert)',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.green)),
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.green)),
                      ),
                    ),
                    txt < 3
                        ? WaitLabel()
                        : Container(
                            height: 60,
                            width: 400 - animationController.value,
                            child: Material(
                              borderRadius: BorderRadius.circular(30.0),
                              shadowColor: Colors.greenAccent,
                              color: Colors.green,
                              elevation: 7.0,
                              child: InkWell(
                                borderRadius: new BorderRadius.circular(30),
                                splashColor: Colors.pinkAccent,
                                onTap: () async {
                                  setState(() {
                                    txtController.text.isEmpty
                                        ? _validate = true
                                        : _validate = false;
                                    passswordController.text.isEmpty
                                        ? _passValidate = true
                                        : _validate = false;
                                  });

                                  if (passswordController.text == 'uxbert' &&
                                      txtController.text == 'uxbert') {
                                    animationController.forward();

                                    await Future.delayed(Duration(seconds: 3))
                                        .then((data) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UserJobPage(),
                                        ), //MaterialPageRoute
                                      );
                                    });
                                  } else {
                                    _validate = true;
                                    _passValidate = true;
                                  }
                                },
                                child: animationController.isCompleted
                                    ? CircularProgressIndicator(
                                        strokeWidth: 4,
                                        backgroundColor: Colors.indigo,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.purple),
                                      )
                                    : Center(
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
                          ),
                  ],
                )),
            SizedBox(height: 15.0),
          ],
        ));
  }
}
