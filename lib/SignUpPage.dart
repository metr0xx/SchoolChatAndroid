import 'package:flutter/material.dart';
import 'strings.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpStageState createState() => _SignUpStageState();
}

class _SignUpStageState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomPaint(
          // painter: BackgroundSignUp(),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                  child: Container(
                      padding: const EdgeInsets.only(left: 25, top: 35.0),
                      child: Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                        ),
                        height: 33.0,
                        width: 45.0,
                      ))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: <Widget>[
                    _getHeader(),
                    _getInputs(),
                    _getSignUp(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_getHeader() {
  return Expanded(
    flex: 3,
    child: Container(
      alignment: Alignment.bottomCenter,
      child: const Text('Регистрация аккаунта',
          style: TextStyle(color: Colors.white, fontSize: 25)),
    ),
  );
}

_getInputs() {
  return Expanded(
      flex: 4,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            TextField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Введите e-mail',
                    labelStyle: TextStyle(color: Colors.black))),
            SizedBox(height: 5),
            TextField(
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Придумайте пароль',
                    labelStyle: TextStyle(color: Colors.black))),
            SizedBox(height: 5),
            TextField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Подтвердите пароль',
                  labelStyle: TextStyle(color: Colors.black)),
            )
          ]));
}

_getSignUp() {
  return Expanded(
      flex: 2,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Регистрация',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 30,
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            )
          ]));
}

class BackgroundSignUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.orange.shade100;
    canvas.drawPath(mainBackground, paint);

    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.65);
    blueWave.cubicTo(sw * 0.8, sh * 0.8, sw * 0.1, sh * 0.35, sw * 0, sh);
    blueWave.lineTo(0, sh);
    blueWave.close();
    paint.color = Colors.grey.shade300;
    canvas.drawPath(blueWave, paint);

    Path secWave = Path();
    secWave.lineTo(sw, 0);
    secWave.lineTo(sw, sh * 0.65);
    secWave.cubicTo(sw * 0.75, sh * 0.15, sw * 0.27, sh * 0.6, 0, sh * 0.37);
    secWave.lineTo(0, sh);
    secWave.close();
    paint.color = Colors.purple.shade400;
    canvas.drawPath(secWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
