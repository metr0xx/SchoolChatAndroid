// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state, file_names
import 'package:flutter/material.dart';
import 'chats.dart';

class ChatInfo extends StatefulWidget {
  int? id;
  String? name;
  var users;
  ChatInfo(this.id, this.name, this.users);
  State<StatefulWidget> createState() {
    return ChatInfoState(id!, name!, users);
  }
}

class ChatInfoState extends State<ChatInfo> {
  @override
  ChatInfoState(this.id, this.name, this.users);
  int? id;
  String name = "";
  var users;
  @override
  Widget build(BuildContext context) {
    TextButton back = TextButton(
        onPressed: () {
          print(users);
          Navigator.pop(context);
        },
        child: Container(
            padding: const EdgeInsets.only(top: 60),
            width: 100,
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
        decoration: const BoxDecoration(
          color: Colors.green,
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
                    fontSize: 57,
                  ),
                )))
          ],
        ),
      )
    ]);

    Container upper = Container(
        color: Colors.white,
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[back, const Spacer()],
          ),
          const Spacer(),
          Row(children: <Widget>[const Spacer(), chaticon, const Spacer()]),
          const Spacer(),
          Text(name, style: const TextStyle(color: Colors.black, fontSize: 30)),
          const Spacer()
        ]));
    Column createUsers() {
      Column columnOfUsers = Column(children: <Widget>[]);
      columnOfUsers.children.add(Text(
        users,
        style: const TextStyle(color: Colors.black, fontSize: 50),
      ));
      return columnOfUsers;
    }

    Column test = createUsers();
    return MaterialApp(
        home: Scaffold(
      body: Column(children: <Widget>[upper, test]),
      backgroundColor: Colors.grey[350],
    ));
  }
}
