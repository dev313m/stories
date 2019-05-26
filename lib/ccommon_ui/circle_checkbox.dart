import 'package:flutter/material.dart';

class CircleCheckBox extends StatefulWidget {
  String image;
  Function f;
  bool checked; 
  List<CircleCheckBox> allButtons; 
  GlobalKey<_CircleCheckBox> key = GlobalKey();  
  CircleCheckBox(this.image, this.checked, this.f);
  @override
  State<StatefulWidget> createState() => _CircleCheckBox(image,checked,allButtons, f);
}

class _CircleCheckBox extends State<CircleCheckBox> {
  String image;
  Function f;
  List<CircleCheckBox> allButtons; 
  bool checked;
  setCheck(bool state){
    setState(() {
      f(); 
     checked = false;  
    });

  }

  Color color = Colors.green;
  _CircleCheckBox(this.image,this.checked,this.allButtons, this.f){
    
  }
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
      height: 80.0,
      width: 80.0,
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
              width: 2.0, style: BorderStyle.solid, color: checked == true? Colors.purple : Colors.transparent),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  image))),
      child: InkWell(
        child: Text('data'),
        onTap: () {

          for(int i=0; i<allButtons.length; i++){
            allButtons.elementAt(i);

          }
        },
      ),
    ));
  }
}
