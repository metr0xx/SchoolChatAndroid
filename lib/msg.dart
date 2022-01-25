// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dateformat.dart';
import 'chatView.dart';

Color color = Color(0x0fffffff);

// DropdownButton<String> msgActions = DropdownButton<String>(
//   items: <String>['A', 'B', 'C', 'D'].map((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(value),
//     );
//   }).toList(),
//   onChanged: (_) {},
// );
createMsgView(msg, time) {
  if (curruser) {
    color = Colors.blue;
  } else {
    color = Colors.grey;
  }
  Container messageView = Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Padding(
          padding: EdgeInsets.all(0.0),
          child: ButtonTheme(
              // height: 1,
              child: GestureDetector(
            onLongPress: () {
              print("pressed");
            },
            child: Card(
                color: color,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(),
                          children: <TextSpan>[
                            //real message
                            TextSpan(
                                text: msg + "  ",
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: formatDate(time),
                                style: TextStyle(
                                    // color: Color.fromRGBO(255, 255, 255, 1)
                                    color: Colors.black54)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ))));
  return messageView;
}
