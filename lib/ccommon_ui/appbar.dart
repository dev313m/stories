import 'package:flutter/material.dart'; 

Widget upperSearchW(Function f) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
    child: Container(
      width: double.infinity,
      height: 60,
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.purple,
        child: InkWell(
            borderRadius: new BorderRadius.circular(25),
            splashColor: Colors.pinkAccent,
            onTap: () {},
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.spa),
                    onPressed: () {
                      f();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                  child: new TextField(
                    cursorColor: Colors.purple,
                    decoration: InputDecoration.collapsed(hintText: 'ابحث'),
                    textAlign: TextAlign.right,
                    enableInteractiveSelection: true,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(),
                  ),
                )),
              ],
            )),
      ),
    ),
  );
}