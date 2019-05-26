import 'package:flutter/material.dart';
import 'package:easy_job/pages/signing_pages/login_page_ui.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/foundation.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;
  double someConst = 45;
  double someConst2 = 340;
  int txt = 0;

  // Widget register = Container(
  //     height: 60,
  //     width: someConst2,
  //     child: Material(
  //       borderRadius: BorderRadius.circular(25.0),
  //       shadowColor: Colors.greenAccent,
  //       color: Colors.green,
  //       elevation: 7.0,
  //       child: InkWell(
  //         borderRadius: new BorderRadius.circular(25),
  //         splashColor: Colors.pinkAccent,
  //         onTap: () {
  //           setState(() {
  //             someConst2 = someConst2 - 14;
  //           });
  //         },
  //         child: Center(
  //           child: Text(
  //             'Register',
  //             style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontFamily: 'Montserrat'),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );

  // double animationNum = 1;
  // String a = '';
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    txtController.dispose();
    super.dispose();
  }

  validateText() {
    setState(() {
      txt = txtController.text.length;
    });
    // setState(() {
    //   if (txt Controller.text.length < 9 || txtController.text == null)
    //     register = WaitLabel();
    //     register = loadingWidget;
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            introWidget('Hello', 'There', screenWidth, screenHeight),
            // introWidget('Hello', 'There', screenWidth, screenHeight),
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
                      keyboardType: TextInputType.number,
                      onChanged: (String) {
                        validateText();
                      },
                      decoration: InputDecoration(
                        labelText: '+966',
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
                    txt != 9
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
                                onTap: () {
                                  animationController.forward(); 
                                },
                                child: animationController.isCompleted? CircularProgressIndicator(
                                  strokeWidth: 4,
                                  backgroundColor: Colors.indigo,
                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.purple),
                                ) : Center(
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     Text(
            //       'For more information',
            //       style: TextStyle(fontFamily: 'Montserrat'),
            //     ),
            //     SizedBox(width: 5.0),
            //     InkWell(
            //       onTap: () {},
            //       child: Text(
            //         'Register',
            //         style: TextStyle(
            //             fontSize: someConst,
            //             color: Colors.green,
            //             fontFamily: 'Montserrat',
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.underline),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ));
  }
}
