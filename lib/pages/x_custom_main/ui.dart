import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_job/ccommon_ui/buttons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:easy_job/inhertited_data/x_customer.dart';
import 'package:easy_job/ccommon_ui/containers.dart';
import 'package:easy_job/pages/x_custom_template/index.dart';

class ImageSwiper extends StatefulWidget {
  final List<String> imageList;
  final Function function;

  ImageSwiper({this.imageList, this.function});
  _ImageSwiper createState() => _ImageSwiper(function, imageList);
}

class _ImageSwiper extends State<ImageSwiper> {
  List<String> _imageList;
  Function _function;

  _ImageSwiper(this._function, this._imageList);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.purple.withOpacity(0),
        ),
        height: MediaQuery.of(context).size.height / 3,
        child: Stack(
          children: <Widget>[
            new Swiper(
              autoplay: true,
              autoplayDelay: 6000,
              fade: 0.3,
              pagination: SwiperPagination(
                builder: SwiperPagination.dots,
              ),
              onTap: (data) {},
              duration: 2200,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: GestureDetector(
                    onTap: () {},
                    child: Hero(
                      tag: _imageList.elementAt(index) + index.toString(),
                      child: CachedNetworkImage(
                        imageUrl: _imageList.elementAt(index),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.plus,
                      ),
                    ),
                  ),
                );
              },
              itemCount: _imageList.length,
              curve: Curves.easeInOutQuad,
              scale: 1,
              controller: SwiperController(),
            ),
          ],
        ));
  }
}

class MySliverList extends StatefulWidget {
  final ScrollController _scrollController;

  @override
  MySliverList(this._scrollController);

  _MySliverList createState() => _MySliverList(_scrollController);
}

class _MySliverList extends State<MySliverList> {
  ScrollController _scrollController;
  _MySliverList(this._scrollController);

  @override
  Widget build(BuildContext context) {
    CustomerInheritedData customerInheritedData =
        Provider.of<CustomerInheritedData>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return RoundWithCircleContainer(
          snapshot: customerInheritedData.list.elementAt(index),
          desc: customerInheritedData.list.elementAt(index).data['desc'],
          img: customerInheritedData.list.elementAt(index).data['image_url'],
          name: customerInheritedData.list.elementAt(index).data['name'],
          star: customerInheritedData.list.elementAt(index).data['star'],
        );
      }, childCount: Provider.of<CustomerInheritedData>(context).list.length),
    );
  }
}

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerInheritedData customerInheritedData =
        Provider.of<CustomerInheritedData>(context);
    return SliverAppBar(
      expandedHeight: 80,
      forceElevated: true,
      floating: true,
      flexibleSpace: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CircleButton(
            imageUrl: 'assets/images/new.png',
            radius: 79,
            type: 'isNew',
            function: () {
              customerInheritedData.isNew = !customerInheritedData.isNew;
            },
          ),
          CircleButton(
              imageUrl: 'assets/images/release.png',
              radius: 79,
              type: 'isNot',
              function: () {
                customerInheritedData.isNot = !customerInheritedData.isNot;
              }),
          CircleButton(
            imageUrl: 'assets/images/old.jpg',
            radius: 79,
            type: 'isOld',
            function: () {
              customerInheritedData.isOld = !customerInheritedData.isOld;
            },
          ),
        ],
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      actions: <Widget>[],
    );
  }
}
