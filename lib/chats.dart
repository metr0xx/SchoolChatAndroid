// ignore_for_file: avoid_print, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/sign_up_page.dart';
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
      } catch (e) {}
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
  var searchText = "";
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
      var uid = 0;
      try {
        uid = int.parse(lastmsg['user_id']);
      } catch (e) {
        uid = 0;
      }
      chatDatas.add(Chat(
          int.parse(chatinfo['id']),
          chatinfo['name'],
          chatinfo['users'],
          chatinfo['admins'],
          int.parse(chatinfo['creator']),
          chatinfo['pic'] ?? "",
          lastmsg['text'] ?? "",
          lastmsg['time'] ?? "",
          uid));
      chatDatas.sort((a, b) => a.id.compareTo(b.id));
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

  List getSortedFilteredChats() {
    return chatDatas
        .where((element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
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
                    side: BorderSide(width: 2, color: Colors.purple),
                  ),
                  // padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(35.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 11.5,
                              // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 50),
                              child: TextField(
                                  onChanged: (text) {
                                    name = text;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Название чата",
                                      hintStyle: TextStyle(
                                          color: Colors.purple[900],
                                          fontFamily: "Helvetica"),
                                      prefixIcon: Icon(
                                        Icons.edit_rounded,
                                        color: Colors.purple[900],
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(35.0)),
                                      fillColor: Colors.white,
                                      filled: true))),
                          // Spacer(),
                          Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 65),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (checker(name)) {
                                    addedNames.add(name);
                                    name = '';
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Chats()));
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
                                  }
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(35.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.purple.shade800
                                              .withOpacity(0.6),
                                          spreadRadius: 8,
                                          blurRadius: 30,
                                          offset: const Offset(0,
                                              10), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    child: const Center(
                                      child: Text(
                                        "Создать чат",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                            fontFamily: "Helvetica"),
                                      ),
                                    )),
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Colors.black87,
                                  primary: Colors.purple[800],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                              )),
                          // Spacer()
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
    Container findChat = Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 50,
            bottom: MediaQuery.of(context).size.height / 50),
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 12,
        child: TextField(
          onChanged: (text) {
            print(text);
            searchText = text;
            update();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(10),
            hintStyle:
                const TextStyle(color: Colors.black, fontFamily: "Helvetica"),
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Поиск',
            fillColor: Colors.grey[200],
            filled: true,
          ),
        ));

    if (shouldUpdate) {
      get_chat_ids(currentuser!.id);
      shouldUpdate = false;
    }
    react_chats(fillChats);
    recieve_chats(fillChats2);

    Column createChats() {
      Column columnOfChats = Column(children: <Widget>[findChat]);
      var filtered = getSortedFilteredChats();
      for (int i = 0; i < filtered.length; i++) {
        SizedBox chat = SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 86.0,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChatView(chatDatas[i].id, filtered[i].name)));
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
                          textForChatIcon(filtered[i].name),
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
                        correctLastMsg(filtered[i].name),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    Container(
                      padding: const EdgeInsets.only(top: 23),
                      child: Text(
                        correctLastMsg(filtered[i].last_msg_text),
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
                          correctDate(formatDate(filtered[i].last_msg_time)),
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
    Container exit = Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: Colors.white,
            minimumSize: const Size(88, 36),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Auth())),
          child: Center(
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Row(children: const <Widget>[
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.red,
                    ),
                    Text(
                      ' Выход',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontFamily: "Helvetica"),
                    ),
                  ]))),
        ));

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
                              currentuser!.name + ' ' + currentuser!.surname),
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
                    '  ' + currentuser!.name + ' ' + currentuser!.surname,
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
                "Телефон: " + currentuser!.phone,
                style: const TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: "Helvetica"),
              ),
              // Spacer(),
              Text(
                'E-mail: ' + currentuser!.email,
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.green[200],
              title: topBar,
              centerTitle: true,
            ),
            drawer: Drawer(
              backgroundColor: Colors.grey[300],
              child: Column(
                children: <Widget>[userinfo, exit],
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
