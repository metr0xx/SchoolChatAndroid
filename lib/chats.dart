// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_equal_for_default_values

import 'package:flutter/material.dart';
import 'Strings.dart';
import 'chatView.dart';
import 'profile.dart';
import 'socket_io_manager.dart';
import 'models.dart';
import 'dateformat.dart';
import 'cutLastMsg.dart';
// import 'package:hexcolor/hexcolor.dart';

var chatDatas = [];
var addedNames = [];

String textForChatIcon(String text) {
  String result = '';
  // result += text[0].toUpperCase();
  // result += text[1].toUpperCase();
  // if (text.length >= 4) {
  //   if (text[4] != '') {
  //     result += text[4].toUpperCase();
  //   }
  // } else if (text.length >= 3) {
  //   if (text[2] != '') {
  //     result += text[2].toUpperCase();
  //   }
  // }

  if (text.split(" ").length >= 2) {
    try {
      result += int.parse(text.split(" ")[0][0]).toString();
      try {
        result += int.parse(text.split(" ")[0][1]).toString();
      } catch (e) {
        pass();
      }
    } catch (e) {
      result += text.split(" ")[0][0].toUpperCase();
      result += text.split(" ")[1][0].toUpperCase();
    }
  }
  if (text.split(" ").length == 1) {
    result += text[0].toUpperCase();
  }
  return result;
}

void pass() {}

class Chats extends StatefulWidget {
  @override
  Chats();
  State<StatefulWidget> createState() {
    return ChatsState();
  }
}

class ChatsState extends State<Chats> {
  @override
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  var ShouldUpdate = true;

  void fillChats2(var incomming) {
    print(incomming);
    var chatinfo = incomming['chat'];
    var lastmsg = incomming['last_msg'];
    bool noSame = true;
    var chatDatasOld = chatDatas;
    for (int i = 0; i < chatDatas.length; i++) {
      if (chatDatas[i].id == chatinfo['id'] ||
          chatDatas[i].name == chatinfo['name']) {
        noSame = false;
        break;
      }
    }
    if (noSame) {
      chatDatas.add(Chat(
          int.parse(chatinfo['id']),
          chatinfo['name'],
          chatinfo['users'],
          chatinfo['admins'],
          int.parse(chatinfo['creator']),
          chatinfo['pic'],
          lastmsg['text'],
          lastmsg['time'],
          int.parse(lastmsg['user_id'])));
        update();
    }
  }

  void fillChats(var chatinfo) {
    print(chatinfo);
    for (int o = 0; o < chatinfo.length; o++) {
      fillChats2(chatinfo[o]);
      print("proshlo");
    }
  }

  Text smallclear = Text(
    '',
    style: TextStyle(fontSize: 6),
  );
  Text midclear = Text('', style: TextStyle(fontSize: 11));
  Text bigclear = Text(
    '',
    style: TextStyle(fontSize: 40),
  );
  String name = '';

  bool checker(name) {
    if (name == '') {
      return false;
    }
    return true;
  }

  List remove_same(List mass) {
    for (int i = 0; i < mass.length; i++) {
      for (int j = i + 1; j < mass.length; j++) {
        if (mass.length > 1) {
          if (mass[i] == mass[j]) {
            mass.removeAt(i);
          }
        }
      }
    }
    return mass;
  }

  List fill_all_names(List chatDatas) {
    List allNames = [];
    for (int i = 0; i < chatDatas.length; i++) {
      allNames.add(chatDatas[i].name);
    }
    return allNames;
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Widget build(BuildContext context) {
    List currNames = fill_all_names(chatDatas);
    for (int i = 0; i < addedNames.length; i++) {
      if (currNames.contains(addedNames[i]) == false) {
        currNames.add(addedNames[i]);
      }
    }
    print('ПЕРВЫЙ chatDatas:');
    print(chatDatas);
    print(
        currNames); // Имена чатов, взятые из chatDatas, + введенные через плюсик

    TextButton plus = TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  backgroundColor: Color(0xFF1c1a1c),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    side: BorderSide(width: 2, color: Color(0xFFa40dd6)),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height / 6,
                          child: Column(
                            children: <Widget>[
                              (TextField(
                                onChanged: (text) {
                                  name = text;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Strings.writeTittle,
                                  fillColor: Color(0xFFbfbfbf),
                                  filled: true,
                                  hintStyle:
                                      TextStyle(color: Color(0xFFa40dd6)),
                                  hintMaxLines: 1,
                                ),
                              )),
                              midclear,
                              (ElevatedButton(
                                  onPressed: () {
                                    if (checker(name)) {
                                      addedNames.add(name);
                                      name = '';
                                      print('ВТОРОЙ chatDatas:');
                                      print(chatDatas);
                                      //Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Chats()));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                                backgroundColor:
                                                    Color(0xFF1c1a1c),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                  side: BorderSide(
                                                      width: 2,
                                                      color: Colors.red),
                                                ),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              9,
                                                      child: Column(
                                                          children: <Widget>[
                                                            (Text(
                                                              'Неправильно, попробуй еще раз!',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                            smallclear,
                                                            Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child: Container(
                                                                    height: 35,
                                                                    child: ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                          'Ok',
                                                                          style: TextStyle(
                                                                              fontSize: 17,
                                                                              color: Colors.red),
                                                                        ),
                                                                        style: ButtonStyle(
                                                                            backgroundColor: MaterialStateProperty.all(
                                                                          Color(
                                                                              0xFF2b2e2d),
                                                                        )))))
                                                          ]),
                                                    )));
                                          });
                                    }
                                  },
                                  child: Text(
                                    Strings.createChat,
                                    style: TextStyle(
                                        fontSize: 17, color: Color(0xFFa40dd6)),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                    Color(0xFF2b2e2d),
                                  ))))
                            ],
                          ))));
            },
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
        ));
    TextButton edit = TextButton(
        onPressed: () {},
        child: Icon(
          Icons.toc_rounded,
          size: 30,
        ));
    TextButton msgs = TextButton(
        onPressed: () {},
        child: Column(children: const <Widget>[
          (Icon(
            Icons.message_rounded,
            size: 25,
            color: Color(0xFFa40dd6),
          )),
          (Text('Messages',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFa40dd6),
              )))
        ]));

    TextButton profile = TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        },
        child: Column(children: const <Widget>[
          (Icon(Icons.contact_mail, size: 25, color: Color(0xFF948e94))),
          (Text(
            'Profile',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF948e94),
            ),
          ))
        ]));

    Text chats = Text(Strings.chats,
        style: TextStyle(fontSize: 20, color: Colors.black));

    Row topBar = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[edit, chats, plus]);
    Align navigation = Align(
        alignment: Alignment.bottomCenter,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[msgs, profile]));

    if (ShouldUpdate) {
      get_chat_ids(2);
      ShouldUpdate = false;
    }
    react_chats(fillChats);
    recieve_chats(fillChats2);

    Column createChats() {
      Column columnOfChats = Column(children: <Widget>[]);
      for (int i = 0; i < chatDatas.length; i++) {
        Container chat = Container(
            width: MediaQuery.of(context).size.width,
            height: 83.0,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatView(chatDatas[i].id, chatDatas[i].name)));

                  print(chatDatas[i].id);
                },
                child: Row(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Center(
                                child: Text(
                              textForChatIcon(chatDatas[i].name),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            )))
                      ],
                    ),
                  ),
                  (Row(children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 35),
                        child: Column(children: <Widget>[
                          // smallclear,
                          (Container(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              chatDatas[i].name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            // alignment: Alignment.centerRight,
                          )),
                          Container(
                            padding: EdgeInsets.only(top: 23),
                            child: Text(
                              cutLastMsg(chatDatas[i].last_msg_text),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ])),
                    Container(
                        padding: EdgeInsets.only(bottom: 45),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(formatDate(chatDatas[i].last_msg_time),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ))))
                  ]))
                ])));
        columnOfChats.children.add(chat);
      }
      return columnOfChats;
    }

    Column chatRows = createChats();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: topBar,
              backgroundColor: Colors.white,
              centerTitle: true,
            ),
            bottomSheet: Container(
              height: kToolbarHeight,
              child: AppBar(
                title: navigation,
                backgroundColor: Color(0xFF1c061c),
              ),
            ),
            body: Container(
                //color: Color(0xFF1c1a1c),
                color: Colors.white,
                alignment: FractionalOffset(0.5, 0.2),
                child: Column(children: <Widget>[
                  chatRows,
                ]))));
  }
}
