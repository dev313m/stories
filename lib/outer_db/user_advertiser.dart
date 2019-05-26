import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class UserAdvertiserDb {
  List<String> imgList = [
    'http://www.creativindie.com/wp-content/uploads/2013/10/Enchantment-Book-Cover-Best-Seller1.jpg',
    'http://www.creativindie.com/wp-content/uploads/2013/10/got_hc1.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51GPBofO8iL.jpg',
    'https://stephenmitchellbooks.com/wp-content/uploads/2013/07/mitchellodyssey.jpg',
    'http://www.creativindie.com/wp-content/uploads/2013/10/lolita-book-cover.png',
    'https://www.paolini.net/wp-content/uploads/2015/06/431645_10151085333212749_1513735547_n.jpg',
    'https://groveatlantic.com/core/wp-content/uploads/2017/04/9780802124944.jpg',
    'https://res.cloudinary.com/bookbub/image/upload/t_ci_fixed_aspect_w_border_padding,q_auto,f_auto/v1506420175/pro_pbid_3649511.jpg',
    'https://images-na.ssl-images-amazon.com/images/I/51TII5bYcTL._SX329_BO1,204,203,200_.jpg',
    'http://goodnightbooks.com/wp-content/uploads/2018/10/GN-Maui-Cover-535x535.jpg',
    'http://carolewilkinson.com.au/wp-content/uploads/2016/06/IMG_2667.jpg',
    'http://goodnightbooks.com/wp-content/uploads/2017/11/GN-Mumbai-Cover-535x535.jpg',
    'https://milkweed.org/sites/default/files/styles/book_cover/public/books/cover/Carrying_Cover_Hi_Res_5.gif?itok=1vjC8B-3',
    'https://ebooks.adelaide.edu.au/b/boothby/guy/red-rat-s-daughter/images/cover.jpg',
    'https://thereaderteacher.files.wordpress.com/2019/04/titanicdetectiveagency.jpg?w=620',
    'https://www.armalyte.com/CC_BloodH.jpg'
  ];
//     this.setUserAdvertiseOptions();
  List<String> nameList = [
    'Asia',
    'Walaa',
    'Nano',
    'Noob',
    'Sofia',
    'Penelope',
    'Riley',
    'Zoey',
    'Nora',
    'Lily',
    'Eleanor',
    'Hannah',
    'Lillian',
    'Addison',
    'Aubrey',
    'Ellie',
  ];

  List<String> bookNames = [
    'Life',
    'Our HOUSE',
    'SANDRA BROWN',
    'PERMAFROST',
    'ANNATOOD',
    'THE FALLEN',
    'REDEMPTION',
    'A SECRET',
    'LOST GIRL',
    'MUELLER',
    'THRONES',
    'FIVE FEET',
    'THE DREAM',
    'NEVER LOST',
    'IN HOUSE',
    'UNTIL DAWN',
  ];
  List<String> desc = [
    'Jack Reacher hits the pavement and sticks out his thumb. He plans to follow the sun on an epic trip across America, from Maine to California. He doesn’t get far. On a country road deep in the New England woods, he sees a sign to a place he has never been: the town where his father was born. He thinks, What’s one extra day? He takes the detour.',
    'At the same moment, in the same isolated area, a car breaks down. Two young Canadians had been on their way to New York City to sell a treasure. Now they’re stranded at a lonely motel in the middle of nowhere. The owners seem almost too friendly. It’s a strange place, but it’s all there is.',
    'The next morning, in the city clerk’s office, Reacher asks about the old family home. He’s told no one named Reacher ever lived in town. He’s always known his father left and never returned, but now Reacher wonders, Was he ever there in the first place?',
    'As Reacher explores his father’s life, and as the Canadians face lethal dangers, strands of different stories begin to merge. Then Reacher makes a shocking discovery: The present can be tough, but the past can be tense . . . and deadly. ',
    'Don’t miss a sneak peek of Lee Child’s novel Blue Moon in the back of the book.',
    '“Superb . . . Child neatly interweaves multiple narratives, ratchets up the suspense (the reveal of the motel plot is delicious), and delivers a powerful, satisfying denouement. Fans will enjoy learning more of this enduring character’s roots, and Child’s spare prose continues to set a very high bar.”—Publishers Weekly (boxed and starred review)',
    '“Another first-class entry in a series that continues to set the gold standard for aspiring thriller authors.”—Booklist (starred review)',
    '“With his usual flair for succinctness and eye for detail, Child creates another rollicking Reacher road trip that will please fans and newcomers alike.”—Library Journal (starred review)',
    '“[Lee Child] shows no signs of slowing down. . . . Reacher is a man for whom the phrase moral compass was invented: His code determines his direction. . . . You need Jack Reacher.”—The Atlantic',
    '“Superb . . . Child neatly interweaves multiple narratives, ratchets up the suspense (the reveal of the motel plot is delicious), and delivers a powerful, satisfying denouement. Fans will enjoy learning more of this enduring character’s roots, and Child’s spare prose continues to set a very high bar.”—Publishers Weekly (boxed and starred review) ',
    '“Cerebral . . . One doesn’t want Mr. Child’s storytelling to end. . . . Get your copy soon before Past Tense sells out. Then enjoy the ride.”—New York Journal of Books',
  ];
  /**
   * 
   * This is database data required to consume required data from firestore
   */
  final int _limit = 15;
  // bool _isAll = true;
  // bool _isTatoo = true;  
  // bool _isMakeup = true;
  // bool _isShave = true;
  // bool _isHair = true;
  // bool _isManakir = false;

  /**
   * 
   * This method is to set the options of the data to be retrieved. 
   */

  // void setOptions(bool isAll, bool isTatoo, bool isMakeup, bool isShave,
  //     bool isHair, bool isManakir) {
  //   _isAll = isAll;
  //   _isTatoo = isTatoo;
  //   _isMakeup = isMakeup;
  //   _isShave = isShave;
  //   _isHair = isHair;
  //   _isManakir = isManakir;
  // }

  Query _query;
  QuerySnapshot querySnapshot;

  // Query queryGenerator() {
  //   _query = Firestore.instance.collection('user_advertiser').orderBy('name', descending: false);

  //   if (_isHair) _query = _query.where('isHair', isEqualTo: true);

  //   if (_isMakeup) _query = _query.where('isMakeup', isEqualTo: true);

  //   // if (_isManakir) _query = _query.where('isManakir', isEqualTo: true);

  //   if (_isShave) _query = _query.where('isShave', isEqualTo: true);

  //   if (_isTatoo) _query = _query.where('isTatoo', isEqualTo: true);
  //   return _query;

  // }

  /**
   * This method return a limited list of users upon the settings of the class.
   */

  Future<List<DocumentSnapshot>> loadUsers() async {


      //  for (int i = 0; i < nameList.length; i++)
      // Firestore.instance.collection('books').add({
      //   'image_url': imgList.elementAt(i),
      //   'status': Random().nextBool(),
      //   'author': nameList.elementAt(i),
      //   'name': bookNames.elementAt(i),
      //   'release_date':
      //       DateTime.now().subtract(Duration(days: 1000)),
      //   'star': Random().nextInt(5),
      //   'desc': desc.elementAt(Random().nextInt(desc.length))
      // });

    _query = Firestore.instance
        .collection('books')
        .orderBy('release_date', descending: false)
        .limit(_limit);
    querySnapshot = await _query.getDocuments();
    return querySnapshot.documents;
  }

  Future<List<DocumentSnapshot>> loadFavoriteList() async {
    _query = Firestore.instance.collection('favorite');
    querySnapshot = await _query.getDocuments();
    return querySnapshot.documents;
  }

  Future<DocumentSnapshot> loadItem(String id) async {
    DocumentSnapshot item;
    item = await Firestore.instance.collection('books').document(id).get();
    if (item != null) return item;
    return null;
  }

  Future<String> addTofavorite(DocumentSnapshot item) async {
    List<DocumentSnapshot> list;
    querySnapshot = await Firestore.instance
        .collection('favorite')
        .where('documentId', isEqualTo: item.documentID)
        .getDocuments();
    list = querySnapshot.documents;
    if (list.length == 0) {
      await Firestore.instance
          .collection('favorite')
          .add({'user': 'uxbert', 'documentId': item.documentID});
      return 'The book is added to favorite list.';
    }

    return 'This book is already in the favorite list.';
  }

  Future<String> removeFavorite(DocumentSnapshot item) async {
    querySnapshot=  await Firestore.instance.collection('favorite').where('documentId', isEqualTo: item.documentID).getDocuments(); 
    List<DocumentSnapshot> li = querySnapshot.documents; 
    await li.elementAt(0).reference.delete(); 
    return 'The book is removed from the list.';
  }

  Future<String> addToSubscribe(DocumentSnapshot item) async {
    List<DocumentSnapshot> list;
    querySnapshot = await Firestore.instance
        .collection('subscribe')
        .where('documentId', isEqualTo: item.documentID)
        .getDocuments();
    list = querySnapshot.documents;
    if (list.length == 0) {
      await Firestore.instance
          .collection('subscribe')
          .add({'user': 'uxbert', 'documentId': item.documentID});
      return 'You will be notified.';
    }

    return 'This book is already in the subscribtion list.';
  }

  /**
   * 
   * This method takes last DocumentSnapshot as parameter and return a list of 10 more rows after the last one consumed~ 
   */
  Future<List<DocumentSnapshot>> loadMoreUsers(
      DocumentSnapshot lastDocument) async {
    _query = Firestore.instance
        .collection('books')
        .orderBy('release_date')
        .startAfter([lastDocument.data['release_date']]).limit(_limit);

    querySnapshot = await _query.getDocuments();

    return querySnapshot.documents;
  }
}
