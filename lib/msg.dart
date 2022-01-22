// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dateformat.dart';
Card createMsgView(msg, time) {
  
Card messageView = Card(
  color: Colors.greenAccent[400],
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
            style: TextStyle(color: Colors.black)
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