import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_job/pages/x_custom_main/ui.dart';
import 'package:flutter/animation.dart';
import 'package:easy_job/inhertited_data/x_customer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';
import 'package:easy_job/ccommon_ui/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_job/pages/favorite_page/index.dart';
import 'package:unicorndial/unicorndial.dart';

class UserJobPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserJobPage();
}

class _UserJobPage extends State<UserJobPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  double currentScroll = 0;
  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInToLinear,
        reverseCurve: Curves.easeOutBack);
    _animationController.addListener(() {
      this.setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(context) {
    return ChangeNotifierProvider(
      builder: (context) => CustomerInheritedData(),
      child: Scaffold(
        backgroundColor: Colors.black,
        primary: true,
        body: FadeTransition(opacity: _animation, child: Index()),
      ),
    );
  }
}

class Index extends StatefulWidget {
  @override
  _Index createState() => _Index();
}

class _Index extends State<Index> with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  Widget upperW;
  AnimationController _animationController;
  Animation _animation;

  double currentScroll = 0;
  @override
  void initState() {
    super.initState();

    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInToLinear,
        reverseCurve: Curves.easeOutBack);
    _animationController.addListener(() {
      this.setState(() {});
    });
    _animationController.forward();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      currentScroll = _scrollController.position.pixels;
      setState(() {
        currentScroll = _scrollController.position.pixels;
      });
      if (maxScroll - currentScroll < 50) {
        if (Provider.of<CustomerInheritedData>(context).isLoaded == true) {
          Provider.of<CustomerInheritedData>(context).isLoaded = false;
          Provider.of<CustomerInheritedData>(context).loadMoreAdvuser();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomerInheritedData customerInheritedDate =
        Provider.of<CustomerInheritedData>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await customerInheritedDate.loadAllAdvUser();
        return;
      },
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: upperSearchW(() {}),
                ),
                MySliverAppBar(),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SliverToBoxAdapter(
                  child: ImageSwiper(
                    imageList: [
                      'https://cache.desktopnexus.com/thumbseg/1965/1965220-bigthumbnail.jpg',
                      'https://www.redwallpapers.com/download/original/abstraction-nature-colorful-water-free-stock-photos-images-hd-wallpaper.jpg',
                      'https://image.dhgate.com/0x0/f2/albu/g6/M01/45/D3/rBVaR1rLoDyAEhC2AAfPHBliHGk016.jpg',
                      'https://picserio.com/data/out/77/blue-rose-wallpaper_2988693.jpg'
                    ],
                  ),
                ),
                MySliverList(_scrollController),
                // SliverToBoxAdapter(
                //   child: customerInheritedDate.isMoreData? CircularProgressIndicator() : SizedBox(),
                // )
              ],
            ),
            Positioned.fill(
              child: Visibility(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
                visible: customerInheritedDate.itemVisible ||
                    customerInheritedDate.isFavorite,
              ),
            ),
            Positioned.fill(
              child: Visibility(
                child: ItemDetails(),
                visible: customerInheritedDate.itemVisible,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {
                    Provider.of<CustomerInheritedData>(context).loadFavorite();
                    Provider.of<CustomerInheritedData>(context).isFavorite =
                        true;
                  },
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.favorite),
                )),
            Positioned.fill(
              child: Visibility(
                child: FavoriteList(),
                visible: customerInheritedDate.isFavorite,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: customerInheritedDate.loading? CircularProgressIndicator(): SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class ItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerInheritedData customerInheritedDate =
        Provider.of<CustomerInheritedData>(context);
    // TODO: implement build
    return customerInheritedDate.chosenItem == null
        ? SizedBox()
        : Stack(
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
                          tag: customerInheritedDate
                              .chosenItem.data['image_url'],
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            child: CachedNetworkImage(
                              imageUrl: customerInheritedDate
                                  .chosenItem.data['image_url'],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          splashColor: Colors.purple,
                          onPressed: () async {
                            String status = await customerInheritedDate
                                .addfavorite(customerInheritedDate.chosenItem);

                            Scaffold.of(context).showSnackBar(
                                new SnackBar(content: new Text(status)));
                          },
                        ),
                        Text(
                          'Book Name: ~' +
                              customerInheritedDate.chosenItem.data['name'],
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 22,
                              fontFamily: 'Montserrat-Bold'),
                        ),
                        Text(
                          'Author: ' +
                              customerInheritedDate.chosenItem.data['author'],
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 17,
                              fontFamily: 'Montserrat-Bold'),
                        ),
                        customerInheritedDate.chosenItem.data['status'] == false
                            ? IconButton(
                                icon: Icon(
                                  Icons.cast_connected,
                                  color: Colors.blue,
                                  size: 44,
                                ),
                                onPressed: () async {
                                  String status =
                                      await customerInheritedDate.addSubscribe(
                                          customerInheritedDate.chosenItem);

                                  Scaffold.of(context).showSnackBar(
                                      new SnackBar(content: new Text(status)));
                                },
                              )
                            : Text(
                                'Release Date: ' +
                                    timeago.format(customerInheritedDate
                                        .chosenItem.data['release_date']),
                                overflow: TextOverflow
                                    .fade, // it wont aloow the the text to go in a new line
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black),
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.left,
                              ),
                        Center(
                          child: StarRating(
                            size: 20,
                            color: Colors.purple,
                            borderColor: Colors.white30,
                            rating: customerInheritedDate
                                .chosenItem.data['star']
                                .toDouble(),
                            onRatingChanged: (double) {},
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:
                                  Visibility(visible: true, child: SizedBox()),
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
                                'Description: ~' +
                                    customerInheritedDate
                                        .chosenItem.data['desc'],
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
                    size: 44,
                  ),
                  onPressed: () {
                    customerInheritedDate.itemVisible = false;
                  },
                ),
              )
            ],
          );
  }
}
