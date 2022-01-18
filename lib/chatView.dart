// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'socket_io_manager.dart';
import 'models.dart';

class ChatView extends StatefulWidget {
  @override
  int? id;
  ChatView(this.id);
  State <StatefulWidget> createState() {
    return ChatViewState(id);
  }
}

class ChatViewState extends State<ChatView> {
  @override
  int? id;
  List messages = [];
  void get_message(mass) {
    print(mass['data'][0]);
    var data = mass['data'];
    for(int o = 0; o < data.length; o++) {
      messages.add(
        Message(
          data[o]["id"], 
          data[o]["chat_id"], 
          data[o]["user_id"], 
          data[o]["attachments"],
          data[o]["deleted_all"],
          data[o]["deleted_user"],
          data[o]["edited"],
          data[o]["service"]
        )
      );
    }
  } 
  List fill_all_msgs() {
    List allMsgs = [];
    for(int i = 0; i < messages.length; i++) {
      allMsgs.add(messages[i].text);
    }
  return allMsgs;
  }

  Widget build(BuildContext context) {
    print("vnizu messages");
    print(fill_all_msgs());
    print(messages);
    recieve_chat_msgs(get_message);
    requestChatMsgs(2, id!);

    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar( 
            backgroundColor: Colors.white, 
          ),
        body: Container(        
          color: Colors.white,
          alignment: FractionalOffset(0.5, 0.2), 
          child: Column(   
            // children: <Widget>[messages]           //child: test,
          )
        )
      )
    );
  }
  ChatViewState(this.id);
}
