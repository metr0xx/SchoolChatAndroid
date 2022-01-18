
// ignore_for_file: prefer_const_constructors, duplicate_ignore, file_names
import 'package:flutter/material.dart';
import 'Strings.dart';
import 'profile.dart';
class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextButton plus = TextButton(onPressed: () {}, child: Icon(Icons.add, size: 30,));
    TextButton edit = TextButton(onPressed: () {}, child: Icon(Icons.toc_rounded, size: 30,));
    TextButton msgs = TextButton(onPressed: () {}, child: Column(children: const <Widget>[(Icon(Icons.message_rounded, size: 25, color: Color(0xFFa40dd6),)), (Text('Messages', style: TextStyle(fontSize: 14, color: Color(0xFFa40dd6), )))]));
    TextButton profile = TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));}, child: Column(children: const <Widget>[(Icon(Icons.contact_mail, size: 25, color: Color(0xFF948e94))), (Text('Profile', style: TextStyle(fontSize: 14, color: Color(0xFF948e94),),))]));

    Text chats = Text(Strings.chats, style: TextStyle(fontSize: 25));

    Row topBar = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[edit, chats, plus]);
    Align navigation = Align(alignment: Alignment.bottomCenter, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[msgs, profile]));
   
    return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: topBar, backgroundColor: Color(0xFA350752), centerTitle: true,),
      bottomSheet: Container(
        height: kToolbarHeight,
        // ignore: duplicate_ignore
        child: AppBar(
          // ignore: prefer_const_constructors
          title: navigation, backgroundColor: Color(0xFF1c061c),
        ),
      ),
      body: Container(
        color: Color(0xFF1c1a1c),
        alignment: FractionalOffset(0.5, 0.2), 
        child: Column(   
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[]           
     )
    )
   )
  );
 }
}