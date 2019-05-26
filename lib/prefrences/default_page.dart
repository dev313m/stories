import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';


//Checking, setting  the type of the profile
void setProfileType(bool b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('profile_type', b); //True is for employee 
}

Future<bool> getProfileType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('profile_type'); //False is for employer
}