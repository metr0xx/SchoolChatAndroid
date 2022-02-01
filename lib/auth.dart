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
    Text auth = Text("Авторизация",
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontSize: 35,
          color: Colors.purple[800],
          fontWeight: FontWeight.bold,
          fontFamily: "Helvetica",
          shadows: const <Shadow>[
            Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 5.0,
                color: Colors.purple),
          ],
        ));

    Container login = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: TextField(
            decoration: InputDecoration(
                hintText: "Эл. почта или телефон",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "Helvetica"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));

    Container password = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
        child: TextField(
            decoration: InputDecoration(
                hintText: "Пароль",
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.purple[900],
                ),
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "Helvetica"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container signIn = Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 24),
        child: ElevatedButton(
          onPressed: () {
            start_connection();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chats()));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.shade700.withOpacity(0.6),
                  spreadRadius: 8,
                  blurRadius: 30,
                  offset: Offset(0, 10), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 16,
            child: Center(
              child: Text(
                'Войти',
                style: TextStyle(
                    color: Colors.white, fontFamily: "Helvetica", fontSize: 18),
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: Colors.purple[700],
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ));

    ElevatedButton authbtn = ElevatedButton(
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade700.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 3.4,
        height: MediaQuery.of(context).size.height / 16,
        child: Center(
          child: Text(
            'Авторизация',
            style: TextStyle(
                color: Colors.white, fontFamily: "Helvetica", fontSize: 18),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black87,
        primary: Colors.purple[700],
        // minimumSize: Size(, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );

    TextButton regbtn = TextButton(
      onPressed: () {
        start_connection();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3.4,
        height: MediaQuery.of(context).size.height / 16,
        child: Center(
          child: Text(
            'Регистрация',
            style: TextStyle(
                color: Colors.purple[800],
                fontFamily: "Helvetica",
                fontSize: 19),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );

    Container inup = Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[authbtn, regbtn]));

    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.purple[100],
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.purple.shade200,
                    Colors.yellow.shade300,
                  ],
                )),
                child: Column(children: <Widget>[
                  Spacer(),
                  auth,
                  Spacer(),
                  login,
                  password,
                  signIn,
                  Spacer(),
                  inup,
                ] //child: test,
                    ))));
  }
}
