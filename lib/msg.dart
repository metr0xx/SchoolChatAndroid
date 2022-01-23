// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dateformat.dart';
import 'chatView.dart';

Color color = Color(0x0fffffff);
Card createMsgView(msg, time) {
  if (curruser) {
    // color = Color(0x0f1c45d6);
    color = Colors.blue;
  }
  else {
    // color = Color(0x0f656b80);
    color = Colors.grey;
  }
  
Card messageView = Card(
  color: color,
  child: Stack(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(style: TextStyle(),
            children: <TextSpan>[
          //real message
          TextSpan(
            text: msg + "  ",
            style: TextStyle(color: Colors.white)
          ),   
          TextSpan(
              text: formatDate(time),
              style: TextStyle(
                  // color: Color.fromRGBO(255, 255, 255, 1)
                  color: Colors.black54
              )
          ),
        ],
      ),
    ),
  ),

  ],
  ),
  );
  return messageView;
}