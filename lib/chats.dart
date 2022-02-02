// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'editprofile.dart';
import 'chat_view.dart';
import 'socket_io_manager.dart';
import 'models.dart';
import 'date_format.dart';
import 'cut_last_msg.dart';

String textForChatIcon(String text) {
  String result = '';
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
  const Chats({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChatsState();
  }
}

class ChatsState extends State<Chats> {
  var chatDatas = [];
  var addedNames = [];
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  final ScrollController _controller = ScrollController();

  var shouldUpdate = true;

  void fillChats2(var inc) {
    var incomming = inc["data"];
    print(incomming);
    var chatinfo = incomming['chat'];
    var lastmsg = incomming['last_msg'];
    bool noSame = true;
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

  String name = '';

  bool checker(name) {
    if (name == '') {
      return false;
    }
    return true;
  }

  List removeSame(List mass) {
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

  List fillAllNames(List chatDatas) {
    List allNames = [];
    for (int i = 0; i < chatDatas.length; i++) {
      allNames.add(chatDatas[i].name);
    }
    return allNames;
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    List currNames = fillAllNames(chatDatas);
    for (int i = 0; i < addedNames.length; i++) {
      if (currNames.contains(addedNames[i]) == false) {
        currNames.add(addedNames[i]);
      }
    }
    ScrollController _scrollController = ScrollController();
    print('chatDatas:');
    print(chatDatas);
    print(currNames);

    TextButton plus = TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  backgroundColor: Colors.grey,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    side: BorderSide(width: 2, color: Colors.green),
                  ),

                  // padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Column(
                        children: <Widget>[
                          (TextField(
                            onChanged: (text) {
                              name = text;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Название чата",
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Color(0xFFa40dd6),
                                  fontFamily: "Helvetica"),
                              hintMaxLines: 1,
                            ),
                          )),
                          (ElevatedButton(
                              onPressed: () {
                                if (checker(name)) {
                                  addedNames.add(name);
                                  name = '';
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Chats()));
                                } else {
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Некорректное название чата'),
                                    action: SnackBarAction(
                                      label: 'Ок',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (context) {
                                  //       return Dialog(
                                  //           backgroundColor:
                                  //               Colors.grey,
                                  //           shape:
                                  //               const RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.all(
                                  //                     Radius.circular(
                                  //                         15.0)),
                                  //             side: BorderSide(
                                  //                 width: 2,
                                  //                 color: Colors.red),
                                  //           ),
                                  //           child: Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(
                                  //                       16.0),
                                  //               child: SizedBox(
                                  //                 height:
                                  //                     MediaQuery.of(context)
                                  //                             .size
                                  //                             .height /
                                  //                         9,
                                  //                 child: Column(
                                  //                     children: <Widget>[
                                  //                       (const Text(
                                  //                         'Некорректное название чата',
                                  //                         style: TextStyle(
                                  //                             fontSize: 17,
                                  //                             color: Colors
                                  //                                 .white,
                                  //                             fontFamily:
                                  //                                 "Helvetica"),
                                  //                       )),
                                  //                       Container(
                                  //                           padding:
                                  //                               const EdgeInsets
                                  //                                       .only(
                                  //                                   top:
                                  //                                       10),
                                  //                           child: SizedBox(
                                  //                               height: 35,
                                  //                               child: ElevatedButton(
                                  //                                   onPressed: () {
                                  //                                     Navigator.pop(
                                  //                                         context);
                                  //                                   },
                                  //                                   child: const Text(
                                  //                                     'Ok',
                                  //                                     style: TextStyle(
                                  //                                         fontSize: 17,
                                  //                                         color: Colors.red,
                                  //                                         fontFamily: "Helvetica"),
                                  //                                   ),
                                  //                                   style: ButtonStyle(
                                  //                                       backgroundColor: MaterialStateProperty.all(
                                  //                                     const Color(
                                  //                                         0xFF2b2e2d),
                                  //                                   )))))
                                  //                     ]),
                                  //               )));
                                  //     });
                                }
                              },
                              child: const Text(
                                "Создать чат",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xFFa40dd6),
                                    fontFamily: "Helvetica"),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF2b2e2d),
                              ))))
                        ],
                      )));
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ));

    Text chats = const Text('Чаты',
        style: TextStyle(
            fontSize: 26, color: Colors.white, fontFamily: "Helvetica"));

    Row topBar = Row(children: <Widget>[
      const Spacer(),
      chats,
      const Spacer(),
      Container(child: plus, padding: const EdgeInsets.only())
    ]);
    TextField findChat = TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintStyle:
            const TextStyle(color: Colors.black, fontFamily: "Helvetica"),
        hintText: 'Поиск по чатам...',
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );

    if (shouldUpdate) {
      get_chat_ids(2);
      shouldUpdate = false;
    }
    react_chats(fillChats);
    recieve_chats(fillChats2);

    Column createChats() {
      Column columnOfChats = Column(children: <Widget>[findChat]);
      for (int i = 0; i < chatDatas.length; i++) {
        SizedBox chat = SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 86.0,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatView(chatDatas[i].id,
                              chatDatas[i].name, chatDatas[i].users)));
                  // _scrollController.animateTo(0.0,
                  //     curve: Curves.easeOut,
                  //     duration: const Duration(milliseconds: 300));
                },
                child: Row(children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(),
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Center(
                            child: Text(
                          textForChatIcon(chatDatas[i].name),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ))
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(children: <Widget>[
                    (Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        correctLastMsg(chatDatas[i].name),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    Container(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                        correctLastMsg(chatDatas[i].last_msg_text),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "Helvetica"),
                      ),
                    )
                  ]),
                  const Spacer(),
                  Align(
                      child: Text(
                          correctDate(formatDate(chatDatas[i].last_msg_time)),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Helvetica")))
                ])));
        columnOfChats.children.add(chat);
      }
      return columnOfChats;
    }

    Column chatRows = createChats();
    ElevatedButton changeinfo = ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black87,
        primary: Colors.green[600],
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => EditProfile())),
      child: SizedBox(
          height: 40,
          width: 230,
          child: Row(
            children: <Widget>[
              const Spacer(),
              Icon(
                Icons.create_outlined,
                color: Colors.amber[700],
              ),
              const Spacer(),
              const Text(
                'Редактировать',
                style: TextStyle(
                    fontSize: 23, color: Colors.white, fontFamily: "Helvetica"),
              ),
              const Spacer()
            ],
          )),
    );

    Column userinfo = Column(children: <Widget>[
      Container(
          width: 300,
          height: 200,
          color: Colors.white,
          padding: const EdgeInsets.only(top: 65),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.only(),
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Center(
                            child: Text(
                          textForChatIcon(
                              currentuser.name + ' ' + currentuser.surname),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontFamily: "Helvetica"),
                        ))
                      ],
                    ),
                  ),
                  // Spacer(),
                  Text(
                    '  ' + currentuser.name + ' ' + currentuser.surname,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: "Helvetica"),
                  ),
                  const Spacer()
                ],
              ),
              const Spacer(),
              Text(
                "Телефон: " + currentuser.phone,
                style: const TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: "Helvetica"),
              ),
              // Spacer(),
              Text(
                'E-mail: ' + currentuser.email,
                style: const TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: "Helvetica"),
              ),
              const Spacer()
            ],
          )),
      changeinfo
    ]);
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[200],
              title: topBar,
              centerTitle: true,
            ),
            drawer: Drawer(
              backgroundColor: Colors.grey[300],
              child: Column(
                children: <Widget>[userinfo],
              ),
            ),
            body: ListView(
                controller: _scrollController,
                reverse: true,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      color: Colors.white,
                      alignment: const FractionalOffset(0.5, 0.2),
                      child: Column(children: <Widget>[
                        chatRows,
                      ]))
                ])));
  }
}
