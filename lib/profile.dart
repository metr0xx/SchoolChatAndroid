import 'package:flutter/material.dart';
import 'Strings.dart';
import 'chats.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Text profileTxt = Text(
      Strings.profile, 
      style: const TextStyle(
        fontSize: 25
        )
      );
    TextButton msgs = TextButton(
      onPressed: () {
        // Navigator.push(
        //   context, MaterialPageRoute(
        //     builder: (context) => Chats()
        //     )
        //   );
          Navigator.pop(context);
        },
      child: Column(
        children: const <Widget>[(
          Icon(
            Icons.message_rounded, 
            size: 25, 
            color: Color(0xFF948e94),
            )
          ), 
          (
            Text(
              'Messages', 
              style: TextStyle(
                fontSize: 14, 
                color: Color(0xFF948e94),
                 )
                )
              )
            ]
          )
        );
    TextButton profile = TextButton(
      onPressed: () {}, 
      child: Column(
        children: const <Widget>[(
          Icon(
            Icons.contact_mail, 
            size: 25, 
            color: Color(0xFFa40dd6)
            )
          ), 
          (
            Text(
              'Profile', 
              style: TextStyle(
                fontSize: 14, 
                color: Color(0xFFa40dd6),
                ),
              )
            )
          ]
        )
      );
  
    Align navigation = Align(
      alignment: Alignment.bottomCenter, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: <Widget>[
          msgs, profile
          ]
        )
      );

    Row topBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: <Widget>[
        profileTxt
        ]
      );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: topBar, 
          backgroundColor: Color(0xFF350752), 
          centerTitle: true,
          ),
        bottomSheet: Container(
          height: kToolbarHeight,
          child: AppBar(
            title: navigation, backgroundColor: Color(0xFF1c061c),
          ),
        ),
        body: Container(
          color: Color(0xFF1c1a1c),
          alignment: FractionalOffset(0.5, 0.2), 
          child: Column(   
          children: <Widget>[]           
          )
        )
      )
    );
  }
}