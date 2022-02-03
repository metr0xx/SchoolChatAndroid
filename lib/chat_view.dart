// ignore_for_file: avoid_print, no_logic_in_create_state, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'date_format.dart';
import 'socket_io_manager.dart';
import 'models.dart';
import 'chats.dart';
import 'chat_info.dart';

class ChatView extends StatefulWidget {
  int? id;
  String? name;
  ChatView(this.id, this.name, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ChatViewState(id!, name!);
  }
}

class ChatViewState extends State<ChatView> {
  @override
  int id = 0;
  List messages = [];
  List chatUsers = [];
  String name = "";
  bool loaded = false;
  ChatViewState(this.id, this.name);
  var shouldUpdate = true;
  final ScrollController _controller = ScrollController();

  void update() {
    if (mounted) {
      setState(() {});
    }
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    void new_message(dynamic arr) {
      var mass = arr["data"];
      print(mass);
      messages.add(Message(
          int.parse(mass["id"]),
          mass["chat_id"],
          mass["user_id"],
          mass["text"],
          mass["attachments"],
          mass["deleted_all"],
          mass["deleted_user"],
          mass["edited"],
          mass["service"],
          mass["updatedAt"]));
      update();
    }

    void get_message(dynamic mass) {
      var data = mass['data'];
      print("new");
      var newmsg = Message(
          int.parse(data["id"]),
          int.parse(data["chat_id"]),
          int.parse(data["user_id"]),
          data["text"],
          data["attachments"],
          data["deleted_all"],
          data["deleted_user"],
          data["edited"],
          data["service"],
          data["updatedAt"]);
      messages.add(newmsg);
      messages.sort((a, b) => a.id.compareTo(b.id));
      update();
    }

    void get_users(dynamic mass) {
      var data = mass["data"];
      print(data);
      print(data[0][0]["name"]);
      print('MASS');
      print(data.length);
      // print(data);
      for (int i = 0; i < data.length; i++) {
        if (data[i].length == 0) {
          continue;
        }
        chatUsers.add(User(
            int.parse(data[i][0]["id"]),
            data[i][0]["name"],
            data[i][0]["surname"],
            int.parse(data[i][0]["school_id"]),
            int.parse(data[i][0]["class_id"]),
            data[i][0]["email"],
            data[i][0]["phone"],
            data[i][0]["picture_url"] ?? ""));
      }
      print('chatUsers:');
      print(chatUsers);
      loaded = true;
    }

    if (shouldUpdate) {
      recieve_chat_msgs(get_message);
      observe_messages(new_message);
      recieve_chat_users(get_users);
      requestChatMsgs(2, id);
      request_chat_users(id);
      shouldUpdate = false;
    }

    Widget build_msg(Message message) {
      double x = 0.0;
      double y = 0.0;
      Color? color;
      if (message.service) {
        color = Colors.green;
        x = 0.0;
        y = -1.0;
      } else {
        if (message.user_id == currentuser!.id) {
          color = Colors.blue;
          x = 1.0;
          y = -1.0;
        } else {
          color = Colors.grey;
          x = -1.0;
          y = -1.0;
        }
      }
      Container messageView = Container(
          alignment: Alignment(x, y),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ButtonTheme(
                  child: GestureDetector(
                onLongPress: () {
                  print("pressed");
                },
                child: Card(
                    color: color,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(),
                              children: <TextSpan>[
                                TextSpan(
                                    text: message.text + "  ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                                TextSpan(
                                    text: formatDate(message.updatedAt),
                                    style:
                                        const TextStyle(color: Colors.black54)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ))));
      return messageView;
    }

    Row chaticon = Row(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(),
        height: 48,
        width: 48,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                // padding: EdgeInsets.only(top: 17, left: 4),
                padding: const EdgeInsets.all(5),
                child: Center(
                    child: Text(
                  textForChatIcon(name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )))
          ],
        ),
      ),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChatInfo(id, name, chatUsers, loaded)));
          },
          child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(name,
                  style: const TextStyle(fontSize: 18, color: Colors.black))))
    ]);

    TextButton back = TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Chats()));
        },
        child: Row(children: <Widget>[
          (Icon(Icons.arrow_back_rounded, size: 25, color: Colors.blue[400])),
          (Text(
            '  Чаты  ',
            style: TextStyle(
              fontSize: 17,
              color: Colors.blue[400],
            ),
          ))
        ]));
    SizedBox sendmsg = SizedBox(
        width: 40,
        child: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.send,
            color: Colors.blue[400],
            size: 30,
          ),
        ));
    SizedBox entermsg = SizedBox(
        width: 250,
        height: 39,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            hintText: 'Сообщение...',
            fillColor: Colors.grey,
            filled: true,
          ),
        ));
    SizedBox loadfile = SizedBox(
        width: 40,
        child: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.attach_file_rounded,
            color: Colors.blue[400],
            size: 30,
          ),
        ));
    Align bottom = Align(
        alignment: Alignment.bottomCenter,
        child: Row(children: <Widget>[
          const Spacer(),
          loadfile,
          const Spacer(),
          entermsg,
          const Spacer(),
          sendmsg,
          const Spacer(),
        ])); //)
    //  ScrollController _controller = ScrollController();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[back, chaticon],
                )),
            bottomSheet: SizedBox(
              height: kToolbarHeight,
              child: AppBar(
                title: bottom,
                backgroundColor: Colors.grey[350],
              ),
            ),
            body: SingleChildScrollView(
                controller: _controller,
                padding: const EdgeInsets.only(bottom: 63),
                child: Column(
                    children: messages.map<Widget>((msg) {
                  return build_msg(msg);
                }).toList()))));
  }
}
