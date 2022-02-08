// ignore_for_file: no_logic_in_create_state, avoid_print
import 'package:flutter/material.dart';
import 'chats.dart';
import 'chat_view.dart';

class ChatInfo extends StatefulWidget {
  int? id;
  String? name;
  List? chatUsers;
  bool? loaded;
  ChatInfo(this.id, this.name, this.chatUsers, this.loaded, {Key? key})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChatInfoState(id!, name!, chatUsers!, loaded!);
  }
}

class ChatInfoState extends State<ChatInfo> {
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  ChatInfoState(this.id, this.name, this.chatUsers, this.loaded);
  int? id;
  String name = "";
  List chatUsers;
  bool loaded = false;
  String searchusers = "";

  List getSortedFilteredUsers() {
    return chatUsers
        .where((element) =>
            element.name.toLowerCase().contains(searchusers.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    TextButton back = TextButton(
        onPressed: () {
          print(chatUsers);
          Navigator.pop(context);
        },
        child: Container(
            // padding: const EdgeInsets.only(top: ),
            height: MediaQuery.of(context).size.height / 28,
            width: MediaQuery.of(context).size.width / 4,
            child: Row(children: <Widget>[
              (Icon(Icons.arrow_back_rounded,
                  size: 25, color: Colors.blue[400])),
              (Text(
                ' Назад ',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.blue[400],
                ),
              ))
            ])));

    Row chaticon = Row(children: <Widget>[
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.purple.shade700.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(5),
                child: Center(
                    child: Text(
                  textForChatIcon(name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 43,
                  ),
                )))
          ],
        ),
      )
    ]);
    Container findusers = Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 50,
            bottom: MediaQuery.of(context).size.height / 50),
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 12,
        child: TextField(
          onChanged: (text) {
            searchusers = text;
            update();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
            contentPadding: const EdgeInsets.all(10),
            hintStyle:
                TextStyle(color: Colors.grey.shade800, fontFamily: "Helvetica"),
            prefixIcon: const Icon(Icons.search_rounded),
            hintText: 'Найти пользователей',
            fillColor: Colors.blueGrey.shade100.withOpacity(0.5),
            filled: true,
          ),
        ));
    Container addUser = Container(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 19),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 17,
        child: TextButton(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Icon(Icons.person_add_alt_1_rounded),
              Text(
                "  Добавить пользователя",
                style: TextStyle(fontFamily: "Helvetica", fontSize: 18),
              )
            ])));
    SizedBox upper = SizedBox(
        // padding:
        //     EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 15),
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[back, const Spacer()],
          ),
          const Spacer(),
          Row(children: <Widget>[const Spacer(), chaticon, const Spacer()]),
          const Spacer(),
          Text(name, style: const TextStyle(color: Colors.black, fontSize: 30)),
          const Spacer(),
          findusers,
          addUser
        ]));

    Column createUsers() {
      var filtered = getSortedFilteredUsers();
      Column infopage = Column(
        children: <Widget>[
          upper,
          // SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height / 35,
          // )
        ],
      );
      try {
        for (int i = 0; i < filtered.length; i++) {
          infopage.children.add(Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 19,
                  top: MediaQuery.of(context).size.width / 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 15,
              child: Row(children: <Widget>[
                Container(
                  // padding: EdgeInsets.only(
                  //     left: MediaQuery.of(context).size.width / 5),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade700.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Center(
                          child: Text(
                        textForChatIcon(
                            filtered[i].name + " " + filtered[i].surname),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: "Helvetica"),
                      ))
                    ],
                  ),
                ),
                Text(
                  "  " + filtered[i].name + " " + filtered[i].surname,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ])));
        }
      } catch (e) {}
      return infopage;
    }

    return MaterialApp(
        home: Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.cyan.withOpacity(0.3),
            ],
          )),
          child: ListView(children: <Widget>[createUsers()])),

      // Container(
      //     height: MediaQuery.of(context).size.height / 1.8,
      //     child: ListView(children: <Widget>[test])),

      backgroundColor: Colors.grey[300],
    ));
  }
}
