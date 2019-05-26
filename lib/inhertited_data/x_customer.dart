import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:easy_job/outer_db/user_advertiser.dart';

class CustomerInheritedData with ChangeNotifier {
  bool _isMoreData = false;

  get isMoreData => _isMoreData;
  bool isLoaded = true;
  bool _isNew = false;
  bool _isNot = false;
  bool _isOld = false;
  bool loading = true;
  get isNew => _isNew;
  get isNot => _isNot;
  get isOld => _isOld;

  bool _loadingWidget = true;
  List<String> _mostSeenOrderedList;
  List<String> _newItemList;
  List<String> _uniqueList;
  List<DocumentSnapshot> favoriteIdList = [];
  List<DocumentSnapshot> favoriteList = [];

  List<DocumentSnapshot> list = [];
  List<DocumentSnapshot> allUserList = [];
  DocumentSnapshot lastDocument;
  DocumentSnapshot _chosenItem;

  DocumentSnapshot get chosenItem => _chosenItem;
  set chosenItem(DocumentSnapshot chosenItem) {
    _chosenItem = chosenItem;
    notifyListeners();
  }

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;
  set isFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
    notifyListeners();
  }

  bool _itemVisible = false;

  bool get itemVisible => _itemVisible;
  set itemVisible(bool itemVisible) {
    _itemVisible = itemVisible;
    notifyListeners();
  }

  Future<String> addfavorite(DocumentSnapshot item) async {
    String status = await _userAdvertiserDb.addTofavorite(item);
    return status;
  }

  Future<String> deleteFavorite(DocumentSnapshot item) async {
    String status = await _userAdvertiserDb.removeFavorite(item);
    favoriteList.removeWhere((test) => test == item);
    loadFavorite();
    // notifyListeners();
    return status;
  }

  Future<String> addSubscribe(DocumentSnapshot item) async {
    String status = await _userAdvertiserDb.addToSubscribe(item);
    return status;
  }

  Future loadFavorite() async {
    // this.setUserAdvertiseOptions();
    loading = true;

    favoriteIdList = await _userAdvertiserDb.loadFavoriteList();
    DocumentSnapshot item;
    favoriteList = [];
    if (favoriteIdList.length > 0) {
      for (int i = 0; i < favoriteIdList.length; i++) {
        item = await _userAdvertiserDb
            .loadItem(favoriteIdList.elementAt(i).data['documentId']);
        favoriteList.add(item);
      }
    }
    ;
    loading = false;
    notifyListeners();
    return;
  }
  /**
   * 
   * All required functionality from the User Advertise database. 
   */

  UserAdvertiserDb _userAdvertiserDb;
  // setUserAdvertiseOptions() {
  //   _userAdvertiserDb.setOptions(
  //       _isAll, _isTatoo, _isMakeup, _isShave, _isHair, _isManakir);
  // }

  resetFields() {
    // _isHair = false;
    // _isMakeup = false;
    // _isShave = false;
    // _isTatoo = false;
    notifyListeners();
  }

  CustomerInheritedData() {
    _userAdvertiserDb = UserAdvertiserDb();

    loadAllAdvUser();
  }

  loadMoreAdvuser() async {
    List<DocumentSnapshot> loadedList =
        await _userAdvertiserDb.loadMoreUsers(lastDocument);
    allUserList.addAll(loadedList);
    filterList();
    if (list.length > 0) lastDocument = list[list.length - 1];

    isLoaded = true;
    notifyListeners();
  }

  Future loadAllAdvUser() async {
    loading = true;
    // this.setUserAdvertiseOptions();
    allUserList = await _userAdvertiserDb.loadUsers();

    list = allUserList;

    if (list.length > 0) {
      lastDocument = allUserList[list.length - 1];
      _isMoreData = true;
    }
    ;
    await loadFavorite();
    notifyListeners();
    return;
  }

  filterList() {
    List<DocumentSnapshot> _new = [];
    List<DocumentSnapshot> _notRelease = [];
    List<DocumentSnapshot> _old = [];

    if (_isNew)
      _new = allUserList.where((data) {
        DateTime time = data.data['release_date'];
        if ( data.data['status']) return time.year == 2019;
        return false;
      }).toList();

    if (_isNot)
      _notRelease = allUserList.where((data) => !data.data['status']).toList();

    if (_isOld)
      _old = allUserList.where((data) {
        DateTime time = data.data['release_date'];
        if (data.data['status']) return time.year < 2019;
        return false;
      }).toList();
    if (_isNew || _isNot || _isOld)
      list = _new + _old + _notRelease;
    else
      list = allUserList;
  }

  set isNew(bool isNew) {
    _isNew = isNew;
    filterList();

    notifyListeners();
  }

  set isNot(bool isNot) {
    _isNot = isNot;
    filterList();
    notifyListeners();
  }

  set isOld(bool isOld) {
    _isOld = isOld;
    filterList();
    notifyListeners();
  }

  bool get loadingWidget => _loadingWidget;

  set loadingWidget(bool loadingWidget) {
    _loadingWidget = loadingWidget;
    notifyListeners();
  }
}
