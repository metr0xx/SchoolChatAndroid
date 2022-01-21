// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, must_be_immutable, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'socket_io_manager.dart';
import 'models.dart';

class ChatView extends StatefulWidget {
  @override
  int? id;
  ChatView(this.id);
  State<StatefulWidget> createState() {
    return ChatViewState(id);
  }
}

var MessagesSize = ValueNotifier<int>(0);

List messages = [];

class ChatViewState extends State<ChatView> {
  @override
  int? id;

  Widget build(BuildContext context) {
    int lastSize = 0;
    bool has = false;
    void get_message(mass) {
      messages.clear();
      // print(mass['data'][0]);
      bool nosame = true;
      var data = mass['data'];
      for (int o = 0; o < data.length; o++) {
        messages.add(Message(
            int.parse(data[o]["id"]),
            int.parse(data[o]["chat_id"]),
            int.parse(data[o]["user_id"]),
            data[o]["text"],
            data[o]["attachments"],
            data[o]["deleted_all"],
            data[o]["deleted_user"],
            data[o]["edited"],
            data[o]["service"]));
        lastSize = messages.length;
        MessagesSize = ValueNotifier<int>(messages.length);
      } // print(data[o]);
    }

    print("vnizu messages");
    print(messages);
    print(MessagesSize);
    recieve_chat_msgs(get_message);
    requestChatMsgs(2, id!);

    Column createMsgs() {
      Column columnOfMessages = Column(children: <Widget>[]);
      for (int i = 0; i < messages.length; i++) {
        print("vnizu MSG");
        print(messages[i].text);
        Container msg = Container(
            child: Text(
          messages[i].text,
          style: TextStyle(color: Colors.black, fontSize: 30),
        ));
        columnOfMessages.children.add(msg);
      }
      return columnOfMessages;
    }

    Column msgRows = createMsgs();

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

  ChatViewState(this.id);
}
