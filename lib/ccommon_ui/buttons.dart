import 'package:flutter/material.dart';
import 'dart:async';
import 'package:easy_job/inhertited_data/x_customer.dart';
import 'package:provider/provider.dart';

Widget introWidget(
    String first, String second, double screenWidth, double screenHeight) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(15.0, 90.0, 0.0, 0.0),
        child: Text(first,
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple)),
      ),
      Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 160.0, 0.0, 0.0),
            child: Text('',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 160.0, 0.0, 0.0),
            child: Text('',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
          )
        ],
      ),
    ],
  );
}

class LightningBtn extends StatefulWidget {
  String txt;
  Function f;
  LightningBtn(this.txt, this.f);
  @override
  State<StatefulWidget> createState() => _LightningBtn(txt, f);
}

class _LightningBtn extends State<LightningBtn> {
  String text;
  Function f;
  Color color = Colors.green;
  _LightningBtn(this.text, this.f);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      height: 60,
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        shadowColor: Colors.greenAccent,
        color: color,
        child: InkWell(
          key: GlobalKey(),
          borderRadius: new BorderRadius.circular(25),
          splashColor: Colors.pinkAccent,
          onTap: () {
            f(text);
            setState(() {
              color = Colors.purple;
            });
          },
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatefulWidget {
  final String type;
  final String imageUrl;
  final Function function;
  final double radius;
  CircleButton(
      {@required this.imageUrl,
      @required this.radius,
      this.function,
      @required this.type});
  @override
  _CircleButton createState() =>
      _CircleButton(imageUrl, radius, function, type);
}

class _CircleButton extends State<CircleButton> {
  String _imageUrl;
  Function _function;
  double _radius;
  String _type;
  bool _isClicked;
  _CircleButton(this._imageUrl, this._radius, this._function, this._type);

  @override
  Widget build(BuildContext context) {
    CustomerInheritedData customerInheritedData =
        Provider.of<CustomerInheritedData>(context);
    if (_type == 'isNew')
      _isClicked = customerInheritedData.isNew;
    else if (_type == 'isOld')
      _isClicked = customerInheritedData.isOld;
    else if (_type == 'isNot')
      _isClicked = customerInheritedData.isNot;


    return InkWell(
      child: Container(
        height: _radius,
        width: _radius,
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
                width: 5.0,
                style: BorderStyle.solid,
                color: _isClicked ? Colors.yellow : Colors.transparent),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('$_imageUrl'))),
        child: Text(''),
      ),
      onTap: () {
        _function();
      },
      borderRadius: new BorderRadius.circular(25),
      splashColor: Colors.pinkAccent,
    );
  }
}

class NCircleButton extends StatefulWidget {
  final String imageUrl;
  final Function function;
  final double radius;
  NCircleButton(
      {@required this.imageUrl, @required this.radius, this.function});
  @override
  _NCircleButton createState() => _NCircleButton(imageUrl, radius, function);
}

class _NCircleButton extends State<NCircleButton> {
  String _imageUrl;
  Function _function;
  double _radius;
  bool _isClicked = true;
  _NCircleButton(this._imageUrl, this._radius, this._function);

  @override
  Widget build(BuildContext context) {


    
    return InkWell(
      child: Container(
        height: _radius,
        width: _radius,
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(
                width: 5.0,
                style: BorderStyle.solid,
                color: _isClicked ? Colors.yellow : Colors.transparent),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('$_imageUrl'))),
        child: Text(''),
      ),
      onTap: () {
        _function();
      },
      borderRadius: new BorderRadius.circular(25),
      splashColor: Colors.pinkAccent,
    );
  }
}
