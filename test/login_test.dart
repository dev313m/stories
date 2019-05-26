// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:easy_job/pages/book.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_job/pages/signing_pages/index.dart';
import 'dart:async';

void main() async {
  //   test('Check if the token is generated', () async {
  //   FirebaseMessaging fb = FirebaseMessaging();
  //   String token = await fb.getToken();
  //   String deviceToken =
  //       'eyi4JFn4wxo:APA91bE8ikX_u06X_1qTun0S7HO0GcDHWVpo97qQy8UZaT0u7oc';
  //   expect(deviceToken, token);
  // });
  test('Check if an item were added to the list. ', () {
    List<Book> bookList;

    bookList = [
      Book('author', 'name', 'desc', 'imageUrl', 'releaseDate', 'star'),
      Book('author1', 'name1', 'desc', 'imageUrl', 'releaseDate', 'star'),
      Book('author2', 'name2', 'desc', 'imageUrl', 'releaseDate', 'star'),
      Book('author2', 'name2', 'desc', 'imageUrl', 'releaseDate', 'star')
    ];
    expect(Book.Empty().add(Book('a', 'b', 'c', 'd', 'e', 'f'), bookList),
        'Item is added to list.');
  });

  test('Check handling adding the same item two times. ', () {
    List<Book> bookList;

    bookList = [
      Book('author', 'name', 'desc', 'imageUrl', 'releaseDate', 'star'),
      Book('author1', 'name1', 'desc', 'imageUrl', 'releaseDate', 'star'),
      Book('author2', 'name2', 'desc', 'imageUrl', 'releaseDate', 'star')
    ];
    expect(
        Book.Empty().add(
            Book('author', 'name', 'desc', 'imageUrl', 'releaseDate', 'star'),
            bookList),
        'It was added before.');
  });
}
