// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'chats.dart';
import 'sign_up_page.dart';
import 'socket_io_manager.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AuthState();
  }
}

class AuthState extends State<Auth> {
  String login = "test";
  String password = "aboba";
  bool authStat = false;
  bool requested = false;
  bool truepassword = true;
  Color? logicolor;
  Color? passwordcolor;

  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  Color checkpassword() {
    if (truepassword) {
      return Colors.white;
    }
    return Colors.red.shade300;
  }

  void authDataHandler(dynamic data) {
    print(data);
    if (data["stat"] != "OK") {
      return;
    }
    var stat = DBCrypt().checkpw(password, data["data"]["password"]);
    if (stat) {
      print(stat);
      authStat = true;
      var dat = data["data"];
      currentuser = User(
          int.parse(dat["id"]),
          dat["name"],
          dat["surname"],
          int.parse(dat["school_id"]),
          int.parse(dat["class_id"]),
          dat["email"],
          dat["phone"],
          dat["picture_url"] ?? "");
      update();
    } else {
      requested = false;
      truepassword = false;
      update();
    }
  }

  @override
  Widget build(BuildContext context) {
    auth_recieve(authDataHandler);

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

    Container enterlogin = Container(
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
            onChanged: (text) {
              login = text;
              update();
            },
            decoration: InputDecoration(
                hintText: "Эл. почта или телефон",
                hintStyle: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: "Helvetica",
                    fontSize: 17),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: checkpassword(),
                filled: true)));

    Container enterpassword = Container(
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
            obscureText: true,
            onChanged: (text) {
              password = text;
              update();
            },
            decoration: InputDecoration(
                hintText: "Пароль",
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.purple[900],
                ),
                hintStyle: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: "Helvetica",
                    fontSize: 17),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: checkpassword(),
                filled: true)));
    Opacity ifNothing = Opacity(
        opacity: 1,
        child: Text(
          "Введите логин и пароль",
          style: TextStyle(color: Colors.red, fontFamily: "Helvetica"),
        ));
    Opacity ifNoLogin = Opacity(
        opacity: 1,
        child: Text(
          "Введите логин и пароль",
          style: TextStyle(color: Colors.red, fontFamily: "Helvetica"),
        ));
    Opacity ifNoPassword = Opacity(
        opacity: 1,
        child: Text(
          "Введите логин и пароль",
          style: TextStyle(color: Colors.red, fontFamily: "Helvetica"),
        ));
    Opacity changer = Opacity(
      opacity: 0,
    );

    Container signIn = Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 24),
        child: ElevatedButton(
          onPressed: () {
            start_connection();
            if (login == "" && password == "") {
              changer = ifNothing;
              update();
            } else if (login == "") {
              changer = ifNoLogin;
              update();
            } else if (password == "") {
              changer = ifNoPassword;
              update();
            } else {
              send_auth_data(login.toLowerCase());
            }
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
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
        primary: Colors.white,
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

    if (authStat) {
      return Chats();
    }

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
                  enterlogin,
                  enterpassword,
                  changer,
                  signIn,
                  Spacer(),
                  inup,
                ] //child: test,
                    ))));
  }
}
