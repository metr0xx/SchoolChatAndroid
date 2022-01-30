// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names, must_be_immutable, prefer_const_literals_to_create_immutables, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'dateformat.dart';
import 'socket_io_manager.dart';
import 'models.dart';
import 'chats.dart';
import 'chatInfo.dart';
// import 'package:contextmenu/context/menu.dart';

class ChatView extends StatefulWidget {
  @override
  int? id;
  String? name;
  ChatView(this.id, this.name);
  State<StatefulWidget> createState() {
    return ChatViewState(id!, name!);
  }
}

class ChatViewState extends State<ChatView> {
  @override
  int id;
  List messages = [];
  String name = "";
  ChatViewState(this.id, this.name);
  var ShouldUpdate = true;
  ScrollController _controller = ScrollController();

  void update() {
    if (mounted) {
      setState(() {});
    }
    _controller.animateTo(_controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 1), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    void new_message(dynamic mass) {
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

    if (ShouldUpdate) {
      recieve_chat_msgs(get_message);
      observe_messages(new_message);
      requestChatMsgs(2, id);
      ShouldUpdate = false;
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
        if (message.user_id == currentuser.id) {
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Padding(
              padding: EdgeInsets.all(0.0),
              child: ButtonTheme(
                  // height: 1,
                  child: GestureDetector(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            backgroundColor: Color(0xFF1c1a1c),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              side: BorderSide(width: 2, color: Colors.red),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 9,
                                )));
                      });
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
                              style: TextStyle(),
                              children: <TextSpan>[
                                //real message
                                TextSpan(
                                    text: message.text + "  ",
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: formatDate(message.updatedAt),
                                    style: TextStyle(
                                        // color: Color.fromRGBO(255, 255, 255, 1)
                                        color: Colors.black54)),
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
        padding: EdgeInsets.only(),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: <Widget>[
            Container(
                // padding: EdgeInsets.only(top: 17, left: 4),
                padding: EdgeInsets.all(5),
                child: Center(
                    child: Text(
                  textForChatIcon(name),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                )))
          ],
        ),
      ),
      TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChatInfo(id, name)));
          },
          child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(name,
                  style: TextStyle(fontSize: 18, color: Colors.black))))
    ]);

    TextButton back = TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Chats()));
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
    Container sendmsg = Container(
        width: 40,
        child: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.send,
            color: Colors.blue[400],
            size: 30,
          ),
        ));
    Container entermsg = Container(
        width: 250,
        height: 39,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(35.0)),
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            hintText: 'Сообщение...',
            fillColor: Colors.grey,
            filled: true,
          ),
        ));
    Container loadfile = Container(
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
          Spacer(),
          loadfile,
          Spacer(),
          entermsg,
          Spacer(),
          sendmsg,
          Spacer(),
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
            bottomSheet: Container(
              height: kToolbarHeight,
              child: AppBar(
                title: bottom,
                backgroundColor: Colors.grey[350],
              ),
            ),
            body: SingleChildScrollView(
                controller: _controller,
                padding: EdgeInsets.only(bottom: 63),
                child: Column(
                    children: messages.map<Widget>((msg) {
                  return build_msg(msg);
                }).toList()))));
  }
}
