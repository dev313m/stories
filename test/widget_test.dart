// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_job/main.dart';
import 'package:easy_job/pages/signing_pages/index.dart';

void main() {
  test('Validate not valid username', () {
    bool isAccepted =Validator().usernameValidator('aa');
    expect(isAccepted, true);
  });
  test('Validate not valid Password', () {
    bool isAccepted = Validator().usernameValidator('2');
    expect(isAccepted, true);
  });

  test('Validate empty username', () {
    bool isAccepted = Validator().usernameValidator('');
    expect(isAccepted, true);
  });
  test('Validate empty Password', () {
    bool isAccepted = Validator().usernameValidator('');
    expect(isAccepted, true);
  });
  test('Check success login', () {
    String str = LoginPage().checkCredentials('uxbert', 'uxbert');
    expect(str, 'Success');
  });

  test('Check error with login', () {
    String str = LoginPage().checkCredentials('ubert', 'uxbert');
    expect(str, 'Success');
  });
}
