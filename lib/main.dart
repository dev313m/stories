import 'package:flutter/material.dart';
import 'package:easy_job/pages/x_custom_main/index.dart';
import 'package:easy_job/pages/intro_page/index.dart';
import 'package:easy_job/prefrences/default_page.dart';

void main() async {

  bool _userType = await getProfileType(); 
  if(_userType== true)
    runApp(MyApp(IntroPage()));
    else if(_userType == false)
    runApp(MyApp(IntroPage()));
    else
    runApp(MyApp(IntroPage()));
}

class MyApp extends StatefulWidget {
  Widget _homePage; 
  MyApp(this._homePage); 

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Easy Jobs',
        darkTheme: ThemeData.dark(),
        theme: ThemeData.dark(),
        home: widget._homePage);
  }
}