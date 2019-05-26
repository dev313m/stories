import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_job/inhertited_data/x_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class FavoriteList extends StatefulWidget {
  _ImageSwiper createState() => _ImageSwiper();
}

class _ImageSwiper extends State<FavoriteList> {
  List<String> _imageList;
  Function _function;
  @override
  Widget build(BuildContext context) {
    CustomerInheritedData customerInheritedData =
        Provider.of<CustomerInheritedData>(context);
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black.withOpacity(0.9),
        ),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            new Swiper(
              autoplay: true,
              autoplayDelay: 6000,
              fade: 0.3,
              pagination: SwiperPagination(
                builder: SwiperPagination.dots,
              ),
              duration: 2200,
              itemBuilder: (BuildContext context, int index) {
                return ItemFavorite(
                    customerInheritedData.favoriteList.elementAt(index));
              },
              itemCount: customerInheritedData.favoriteList.length,
              curve: Curves.easeInOutQuad,
              scale: 1,
              controller: SwiperController(),
            ),
          ],
        ));
  }
}

class ItemFavorite extends StatelessWidget {
  DocumentSnapshot _snapshot;
  ItemFavorite(this._snapshot);
  @override
  Widget build(BuildContext context) {
    CustomerInheritedData _customerInheritedDate =
        Provider.of<CustomerInheritedData>(context);

    // TODO: implement build
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(25),
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.grey,
                borderRadius: new BorderRadius.all(Radius.circular(40))),
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Hero(
                    tag: _snapshot.data['image_url'],
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: CachedNetworkImage(
                        imageUrl: _snapshot.data['image_url'],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                    splashColor: Colors.purple,
                    onPressed: () async {
                      _customerInheritedDate.loading = true;
                     await _customerInheritedDate
                          .deleteFavorite(_snapshot);
                          return; 
                    },
                  ),
                  Text(
                    'Book Name: ~' + _snapshot.data['name'],
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 22,
                        fontFamily: 'Montserrat-Bold'),
                  ),
                  Text(
                    'Author: ' + _snapshot.data['author'],
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 17,
                        fontFamily: 'Montserrat-Bold'),
                  ),
                  _snapshot.data['status'] == false
                      ? IconButton(
                          icon: Icon(
                            Icons.cast_connected,
                            color: Colors.blue,
                            size: 44,
                          ),
                          onPressed: () async {
                            String status =
                                await _customerInheritedDate.addSubscribe(
                                    _customerInheritedDate.chosenItem);

                            Scaffold.of(context).showSnackBar(
                                new SnackBar(content: new Text(status)));
                          },
                        )
                      : Text(
                          'Release Date: ' +
                              timeago.format(_snapshot.data['release_date']),
                          overflow: TextOverflow
                              .fade, // it wont aloow the the text to go in a new line
                          style: TextStyle(fontSize: 10.0, color: Colors.black),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                        ),
                  Center(
                    child: StarRating(
                      size: 20,
                      color: Colors.purple,
                      borderColor: Colors.white30,
                      rating: _snapshot.data['star'].toDouble(),
                      onRatingChanged: (double) {},
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Visibility(visible: true, child: SizedBox()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Description: ~' + _snapshot.data['desc'],
                          overflow: TextOverflow
                              .fade, // it wont aloow the the text to go in a new line
                          style: TextStyle(
                              fontSize: 17.0,
                              fontFamily: 'Montserrat-Bold',
                              color: Colors.black),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.bubble_chart,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Colors.red,
              size: 40,
            ),
            onPressed: () {
              _customerInheritedDate.isFavorite = false;
            },
          ),
        )
      ],
    );
  }
}
