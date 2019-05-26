import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:easy_job/inhertited_data/x_customer.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoundWithCircleContainer extends StatelessWidget {
  final String name;
  final String desc;
  final int star;
  final String img;
  final DocumentSnapshot snapshot;
  RoundWithCircleContainer(
      {@required this.desc, this.img, this.name, this.star, this.snapshot});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    CustomerInheritedData inheritedData =
        Provider.of<CustomerInheritedData>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Material(
        color: Colors.purple.withOpacity(0.40),
        borderOnForeground: true,
        // for the rounded border and the shadow for the dev
        borderRadius: BorderRadius.circular(30.0),

        shadowColor: Theme.of(context).canvasColor,
        child: InkWell(
          onTap: () {
            inheritedData.chosenItem = snapshot;
            inheritedData.itemVisible = true;
          },
          highlightColor: Colors.transparent,
          borderRadius: new BorderRadius.circular(25),
          splashColor: Colors.pink,
          child: Padding(
            padding: const EdgeInsets.all(15.0), //
            child: Container(
                height: 250.0,
                constraints: BoxConstraints(minHeight: 120, maxHeight: 350),
                child: Row(
                  children: <Widget>[
                    Container(
                        child: Hero(
                      tag: img,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: CachedNetworkImage(
                          imageUrl: img,
                          fadeInCurve: Curves.decelerate,
                          placeholder: (context, s) {
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    )),
                    Flexible(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Book Name: ~$name~',
                            overflow: TextOverflow.fade,
                            style:
                                TextStyle(color: Colors.purple, fontSize: 15),
                          ),
                        Text(
                          snapshot.data['status'] == false
                              ? 'Release Date: Not yet'
                              : 'Release Date: ' +
                                  timeago.format(snapshot.data['release_date']),
                          overflow: TextOverflow
                              .fade, // it wont aloow the the text to go in a new line
                          style: TextStyle(fontSize: 10.0, color: Colors.white.withOpacity(0.8)),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.left,
                        ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: StarRating(
                              size: 20,
                              color: Colors.purple,
                              borderColor: Colors.white30,
                              rating: star.toDouble(),
                              onRatingChanged: (double) {},
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Visibility(
                                    visible: true, child: SizedBox()),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5.0,0,0,0),
                                  child: Text(
                                     desc,softWrap: true,
                                     maxLines: 7,
                                    overflow: TextOverflow
                                        .fade, // it wont aloow the the text to go in a new line
                                    style: TextStyle(fontSize: 13.0),
                                    textDirection: TextDirection.ltr,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
