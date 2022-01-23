// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, must_be_immutable, prefer_const_literals_to_create_immutables, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'socket_io_manager.dart';
import 'models.dart';
import 'dart:io';
import 'msg.dart';

class ChatView extends StatefulWidget {
  @override
  int? id;
  ChatView(this.id);
  State<StatefulWidget> createState() {
    print("ID in chatview");
    print(id);
    return ChatViewState(id);
  }
}

var MessagesSize = ValueNotifier<int>(0);

List messages = [];
Column msgRows = Column();

class ChatViewState extends State<ChatView> {
  @override
  int? id;
  ChatViewState(this.id);
  // ChatViewState(this.id);
  int updCount = 0;
  var ShouldUpdate = true;
  void update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    int lastSize = 0;
    void get_message(mass) {
      messages.clear();
      var data = mass['data'];
      for (int o = 0; o < data.length; o++) {
        // if (data[o]["chat_id"] == 2) {
        print("ID:");
        print(id);
        messages.add(Message(
            int.parse(data[o]["id"]),
            int.parse(data[o]["chat_id"]),
            int.parse(data[o]["user_id"]),
            data[o]["text"],
            data[o]["attachments"],
            data[o]["deleted_all"],
            data[o]["deleted_user"],
            data[o]["edited"],
            data[o]["service"],
            data[o]["updatedAt"]));
        update();
        // }
        lastSize = messages.length;
        MessagesSize = ValueNotifier<int>(messages.length);
      } // print(data[o]);
      Column createMsgs() {
        Column columnOfMessages = Column(children: <Widget>[]);
        for (int i = 0; i < messages.length; i++) {
          print("vnizu MSG");
          print(messages[i].text);
          if (messages[i].user_id == currentuser.id) {}
          Container msg = Container(
              child: createMsgView(messages[i].text, messages[i].updatedAt));
          columnOfMessages.children.add(msg);
        }
        return columnOfMessages;
      }

      msgRows = createMsgs();
      update();
      // String tt = messages[0].updatedAt;
      // print(tt);
    }

    print("vnizu messages");
    print(messages);
    print(MessagesSize);
    recieve_chat_msgs(get_message);
    if (ShouldUpdate) {
      requestChatMsgs(2, id!);
      ShouldUpdate = false;
    }
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Container(
                color: Colors.white,
                alignment: FractionalOffset(0.5, 0.2),
                child: Column(
                    children: <Widget>[msgRows] //[msgRows],      //child: test,
                    ))));
  }
  // ChatViewState(this.id);
}
