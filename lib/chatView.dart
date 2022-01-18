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

var MessagesSize = ValueNotifier<int>(0);
List messages = [];
List allMsgs = [];
Column columnOfMessages = Column(children: <Widget>[]);

void get_message(mass) {
    // print(mass['data'][0]);
    bool noSame = true;
    var data = mass['data'];
    // var chatId = data["id"];
    for(int i = 0; i < messages.length; i++) {
      // if(messages[i].id == chatId) {
      //   noSame = false;
      //   break;
      // }
    }
    // if(noSame) {
      for(int o = 0; o < data.length; o++) {
        messages.add(
          Message(
            int.parse(data[o]["id"]), 
            int.parse(data[o]["chat_id"]), 
            int.parse(data[o]["user_id"]), 
            data[o]["attachments"],
            data[o]["deleted_all"],
            data[o]["deleted_user"],
            data[o]["edited"],
            data[o]["service"]
          )
        );
        MessagesSize = ValueNotifier<int>(messages.length);
               // print(data[o]);
      }
    }
  // } 
  void fill_all_msgs() {
    for(int i = 0; i < messages.length; i++) {
      allMsgs.add(messages[i].text);
    }
  }

class ChatViewState extends State<ChatView> {
  @override
  int? id;

  Widget build(BuildContext context) {
    print("vnizu messages");
    print(messages);
    print(MessagesSize);
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
            children: [
              ValueListenableBuilder(valueListenable: MessagesSize, builder: (context, value, widget) {
                // print('messages:');
                // print(messages);
                // print(MessagesSize);
                for(int i = 0; i < messages.length; i++) {
                  columnOfMessages.children.add(
                    Container(
                      child: Text(messages[i].text,
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                    )
                  );
                }
                // return (Text("aboba"));
                return columnOfMessages;
              })
            ],      //child: test,
          )
        )
      )
    );
  }
  ChatViewState(this.id);
}
