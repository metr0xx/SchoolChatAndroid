// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile.dart';
import 'Strings.dart';
import 'chats.dart';
import 'SignUpPage.dart';
import 'socket_io_manager.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email;
    String _password;
    Text auth = Text(
      Strings.auth, 
      textDirection: TextDirection.ltr, 
      style: TextStyle(
        fontSize: 35, 
        color: Color(0xFF75d9c8), 
        fontWeight: FontWeight.bold
        )
      );
    Text bigclear = Text('', style: TextStyle(fontSize: 60));
    Text midclear = Text('', style: TextStyle(fontSize: 45));

    TextField login = TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: Strings.email,
        hintStyle: TextStyle(color: Color(0xFFa40dd6)),
        fillColor: Color(0xFFbfbfbf),
        filled: true,
      )
    );

    TextField password = TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Color(0xFFa40dd6), ),
        hintText: Strings.password,
        fillColor: Color(0xFFbfbfbf),
        filled: true,
    ),
  );

    ElevatedButton signIn = ElevatedButton(
      onPressed: () {
        start_connection();
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Chats()
          )
        );
        // showDialog(
        //   context: context,     
        //   builder: (context) {
        //     Future.delayed(          
        //       Duration(seconds: 3), () {     
        //         // print('loaded in AUTH');
        //         Navigator.push(
        //           context, 
        //           MaterialPageRoute(
        //             builder: (context) => Chats()
        //           )
        //         );                                    
        //       }
        //     );                        
        //     return AlertDialog(
        //       title: Text('Загрузка чатов...'),
        //     );
        //   }
        // );
      },
      child: Text(
        Strings.signIn, 
        style: TextStyle(
          color: Color(0xFFa40dd6), 
          fontSize: 25
          )
        ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xFF1c1a1c)
          ), 
        )
      );

    ElevatedButton signUp = ElevatedButton(
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => SignUpPage()
          )
        );
      },
     child: Text(
       Strings.signUp, 
       style: TextStyle(
         color: Color(0xFFa40dd6), 
         fontSize: 25
         ),
        ),
     style: ButtonStyle(
       backgroundColor: MaterialStateProperty.all(
         Color(0xFF1c1a1c)
        ),
       )
      );

    Row inup = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
      children: <Widget>[
        signIn, signUp
        ]
      );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.homeTittle, 
            textScaleFactor: 1, 
            style: TextStyle(
              fontSize: 25
              )
            ), 
            backgroundColor: Color(0xFF350752), 
            centerTitle: false,
          ),
        body: Container(
          color: Color(0xFF140513),
          // color: Colors.white,
          alignment: FractionalOffset(0.5, 0.2), 
          child: Column(   
            children: <Widget>[
              bigclear, auth, bigclear, login, midclear, password, bigclear, Center(
                child: inup
                )
              ]           //child: test,
          )
        )
      )
    );
  }
}


