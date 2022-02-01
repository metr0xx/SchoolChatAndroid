import 'package:flutter/material.dart';
import 'auth.dart';
import 'strings.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpStageState createState() => _SignUpStageState();
}

class _SignUpStageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Container registr = Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 20,
            top: MediaQuery.of(context).size.height / 18),
        child: Text("Регистрация",
            textDirection: TextDirection.ltr,
            style: TextStyle(
                fontSize: 35,
                color: Colors.purple[800],
                fontWeight: FontWeight.bold,
                fontFamily: "OpenSans")));
    Container surname = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 12,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Фамилия",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container name = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Имя",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container email = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Эл. почта",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container phone = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Номер телефона",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container password = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Пароль",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container confirmpassword = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Подтверждение пароля",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container invitecode = Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            decoration: InputDecoration(
                hintText: "Код приглашения",
                hintStyle: TextStyle(
                    color: Colors.purple[900], fontFamily: "OpenSans"),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container signUp = Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 24),
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 16,
            child: const Center(
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                    color: Colors.white, fontFamily: "OpenSans", fontSize: 18),
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: Colors.purple[700],
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ));
    TextButton authbtn = TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3.7,
        height: MediaQuery.of(context).size.height / 16,
        child: Center(
          child: Text(
            'Авторизация',
            style: TextStyle(
              color: Colors.purple[700],
              fontFamily: "OpenSans",
              fontSize: 18,
            ),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
    ElevatedButton regbtn = ElevatedButton(
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width / 3.7,
        height: MediaQuery.of(context).size.height / 16,
        child: const Center(
          child: Text(
            'Регистрация',
            style: TextStyle(
                color: Colors.white, fontFamily: "OpenSans", fontSize: 19),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.purple[700],
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
    Container authreg = Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[authbtn, regbtn]));

    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.purple[100],
            body: Column(children: <Widget>[
              registr,
              surname,
              name,
              email,
              phone,
              password,
              invitecode,
              signUp,
              Spacer(),
              authreg
            ])));
  }
}
