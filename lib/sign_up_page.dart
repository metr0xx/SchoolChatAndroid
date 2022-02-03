import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models.dart';
import 'package:flutter_application_1/socket_io_manager.dart';
import 'auth.dart';
import 'chats.dart';

class SignUpPage extends StatefulWidget {
  // const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpStageState createState() => _SignUpStageState();
}

class _SignUpStageState extends State<SignUpPage> {
  String surnameVal = "";
  String nameVal = "";
  String emailVal = "";
  String phoneVal = "";
  String passwordVal = "";
  String confirmPasswordVal = "";
  String inviteCodeVal = "";
  bool requested = false;
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  bool authStat = false;
  void get_auth(mass) {
    print(mass);
    if (mass["stat"] == "CODE") {
      print("incorrect code");
      return;
    }
    if (mass["stat"] != "OK") {
      return;
    }
    var data = mass["data"];
    authStat = true;
    currentuser = User(
        int.parse(data["id"]),
        data["name"],
        data["surname"],
        int.parse(data["school_id"]),
        int.parse(data["class_id"]),
        data["email"],
        data["phone"],
        data["picture_url"] ?? "");
    update();
    requested = true;
  }

  @override
  Widget build(BuildContext context) {
    react_register(get_auth);

    Container registr = Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 20,
            top: MediaQuery.of(context).size.height / 15),
        child: Text("Регистрация",
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
            )));
    Container surname = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 12,
        child: TextField(
            onChanged: (text) {
              surnameVal = text;
            },
            decoration: InputDecoration(
                hintText: "Фамилия",
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
                fillColor: Colors.white,
                filled: true)));
    Container name = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            onChanged: (text) {
              nameVal = text;
            },
            decoration: InputDecoration(
                hintText: "Имя",
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
                fillColor: Colors.white,
                filled: true)));
    Container email = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            onChanged: (text) {
              emailVal = text;
            },
            decoration: InputDecoration(
                hintText: "Эл. почта",
                hintStyle: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: "Helvetica",
                    fontSize: 17),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container phone = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            onChanged: (text) {
              phoneVal = text;
            },
            decoration: InputDecoration(
                hintText: "Номер телефона",
                hintStyle: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: "Helvetica",
                    fontSize: 17),
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Opacity ifPasswordIsClear = Opacity(opacity: 0.0);
    Opacity confirmpassword = Opacity(
        opacity: 1,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 11.5,
            child: TextField(
                onChanged: (text) {
                  confirmPasswordVal = text;
                },
                decoration: InputDecoration(
                    hintText: "Подтверждение пароля",
                    hintStyle: TextStyle(
                        color: Colors.purple[900],
                        fontFamily: "Helvetica",
                        fontSize: 17),
                    prefixIcon: const Icon(
                      Icons.lock_rounded,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0)),
                    fillColor: Colors.white,
                    filled: true))));
    Opacity showConfirmation() {
      if (passwordVal == "") {
        return ifPasswordIsClear;
      } else {
        return confirmpassword;
      }
    }

    Container password = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            onChanged: (text) {
              passwordVal = text;
              showConfirmation();
              update();
            },
            decoration: InputDecoration(
                hintText: "Пароль",
                hintStyle: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: "Helvetica",
                    fontSize: 17),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                fillColor: Colors.white,
                filled: true)));
    Container invitecode = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 11.5,
        child: TextField(
            onChanged: (text) {
              inviteCodeVal = text;
            },
            decoration: InputDecoration(
                hintText: "Код приглашения",
                hintStyle: TextStyle(
                    color: Colors.purple[900],
                    fontFamily: "Helvetica",
                    fontSize: 17),
                prefixIcon: Icon(
                  Icons.quick_contacts_mail_outlined,
                  color: Colors.purple[900],
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0)),
                fillColor: Colors.white,
                filled: true)));
    Container signUp = Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade700.withOpacity(0.5),
              spreadRadius: 0.01,
              blurRadius: 29,
              offset: const Offset(0, 24.4), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 24),
        child: ElevatedButton(
          onPressed: () {
            start_connection();
            if (surnameVal == "" ||
                nameVal == "" ||
                emailVal == "" ||
                phoneVal == "" ||
                passwordVal == "" ||
                confirmPasswordVal == "" ||
                inviteCodeVal == "") {
              print("Бистро ввел все!");
            } else {
              send_registration_data({
                "name": nameVal,
                "surname": surnameVal,
                "email": emailVal,
                "phone": phoneVal,
                "invite_code": inviteCodeVal,
                "password": DBCrypt()
                    .hashpw(passwordVal, DBCrypt().gensaltWithRounds(10))
              });
            }
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 16,
            child: const Center(
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                    color: Colors.white, fontFamily: "Helvetica", fontSize: 18),
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3.4,
        height: MediaQuery.of(context).size.height / 16,
        child: Center(
          child: Text(
            'Авторизация',
            style: TextStyle(
              color: Colors.purple[700],
              fontFamily: "Helvetica",
              fontSize: 18,
            ),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
    ElevatedButton regbtn = ElevatedButton(
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.shade700.withOpacity(0.6),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 3.4,
        height: MediaQuery.of(context).size.height / 16,
        child: const Center(
          child: Text(
            'Регистрация',
            style: TextStyle(
                color: Colors.white, fontFamily: "Helvetica", fontSize: 19),
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.purple[700],
        padding: const EdgeInsets.symmetric(horizontal: 16),
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

    if (authStat) {
      return const Chats();
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
                  registr,
                  surname,
                  name,
                  email,
                  phone,
                  password,
                  showConfirmation(),
                  invitecode,
                  signUp,
                  const Spacer(),
                  authreg
                ]))));
  }
}
