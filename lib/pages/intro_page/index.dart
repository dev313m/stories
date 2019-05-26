import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_job/pages/signing_pages/ui.dart';
import 'package:easy_job/pages/x_custom_main/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:easy_job/pages/signing_pages/index.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  FirebaseMessaging fb = new FirebaseMessaging();

  void initState() {
    super.initState();
    fb.getToken().then((onValue) {
      Firestore.instance.collection('bookusers').add({'token': onValue});
    });
    fb.configure(
      onLaunch: (Map<String, dynamic> msg) {},
      onMessage: (Map<String, dynamic> msg) {},
      onResume: (Map<String, dynamic> msg) {},
    );
    fb.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    fb.onIosSettingsRegistered.listen((IosNotificationSettings setting) {});
  }

  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
      pageColor: Colors.pink,
      bubble: Image.asset('assets/images/books.png'),
      body: Text(
        'Choose your prefrences and enjoy easy apply?',
      ),
      title: Text(
        '',
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      mainImage: Image.asset(
        'assets/images/books.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Colors.yellow,
      iconImageAssetPath: 'assets/images/noti.png',
      body: Text(
        'Get notification for book releases.',
      ),
      title: Text(
        '',
        style: TextStyle(color: Colors.red),
      ),
      mainImage: Image.asset(
        'assets/images/noti.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.red),
    ),
    PageViewModel(
      pageColor: Colors.purple,
      iconImageAssetPath: 'assets/images/favorite.gif',
      body: Text(
        'Your favorite books will not be lost.',
      ),
      title: Text('Favorite Books'),
      mainImage: Image.asset(
        'assets/images/favorite.gif',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'EASY JOB', //title of app
      home: Builder(
        builder: (context) => IntroViewsFlutter(
              pages,
              doneText: Icon(
                Icons.check_circle,
                size: 55,
                color: Colors.blue,
              ),
              onTapDoneButton: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ), //MaterialPageRoute
                );
              },
              pageButtonTextStyles: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}
