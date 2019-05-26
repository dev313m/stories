import 'package:easy_job/ccommon_ui/buttons.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicorndial/unicorndial.dart';

//This .dart file inherites 

class FullScreenPage extends StatelessWidget {
  final String imageUrl;

  List<UnicornButton> childButtons = List<UnicornButton>();

  FullScreenPage({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Choo choo",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.airplanemode_active))));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => new CircularProgressIndicator(
                      backgroundColor: Colors.purple,
                      strokeWidth: 11,
                      value: 2,
                    ),
                fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              child: NCircleButton(
                imageUrl: 'assets/images/order_picture.jpg',radius: 100,
                function: (){},
                
              ),
            )
          ),
        ],
      ),
      floatingActionButton: UnicornDialer(
          backgroundColor: Colors.black.withOpacity(0.5),
          parentHeroTag: imageUrl,
          parentButtonBackground: Colors.purple,
          orientation: UnicornOrientation.HORIZONTAL,
          parentButton: Icon(Icons.add),
          childButtons: childButtons),
    );
  }
}
