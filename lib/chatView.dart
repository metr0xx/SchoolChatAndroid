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
  String name = "";
  ChatView(this.id, this.name);
  State<StatefulWidget> createState() {
    print("ID in chatview");
    print(id);
    return ChatViewState(id, name);
  }
}

Column msgRows = Column();
bool curruser = true;

class ChatViewState extends State<ChatView> {
  @override
  int? id;
  List messages = [];
  String name = "";
  double x = 0.0;
  double y = 0.0;
  Color color = Color(0x0fffffff);
  ChatViewState(this.id, this.name);
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
    String? text;
    String? updatedat;
    createMsgView(msg, time) {
      if (curruser) {
        color = Colors.blue;
      } else {
        color = Colors.grey;
      }
      Container messageView = Container(
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
                                    text: msg + "  ",
                                    style: TextStyle(color: Colors.white)),
                                TextSpan(
                                    text: formatDate(time),
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

    ScrollController _scrollController = ScrollController();
    void new_message(mass) {
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
    
    // Column columnOfMessages = Column(
    //   children: <Widget>[],
    // );
    
    Align msg = Align(
        alignment: Alignment(x, y),
        child: Container(
            color: color,
            child:
          createMsgView(messages[messages.length - 1].text, messages[messages.length - 1].updatedAt)));
    msgRows.children.add(msg);
    
        
      

    void get_message(mass) {
      //messages.clear();
      // print("id: ");
      // print(id);
      // if (id! != last_chat) {
      //   last_chat = id!;
      //   messages.clear();
      // }
      var data = mass['data'];
      // if (data[o]["chat_id"] == 2) {
      print("ID:");
      print(id);
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
      if (messages[messages.length - 1].service) {
            x = 0.0;
            y = -1.0;
            curruser = false;
            color = Color(0x0f2adb71);
          } else {
            if (messages[messages.length - 1].user_id == currentuser.id) {
              x = 1.0;
              y = -1.0;
              curruser = true;
              color = Color(0x0f4d76ff);
            } else {
              x = -1.0;
              y = -1.0;
              curruser = false;
              color = Color(0x0f656b80);
            }
          }
      // update();
      print(messages.length);
      update();
    }
    print("vnizu messages");
    print(messages);

    if (ShouldUpdate) {
      recieve_chat_msgs(get_message);
      observe_messages(new_message);
      requestChatMsgs(2, id!);
      ShouldUpdate = false;
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatInfo(id)));
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
        height: 34,
        child: TextField(
          decoration: InputDecoration(
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
          Container(child: loadfile),
          Container(padding: EdgeInsets.only(left: 6), child: entermsg),
          Container(padding: EdgeInsets.only(left: 10), child: sendmsg)
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
            body: Container(
                padding: EdgeInsets.only(bottom: 63),
                child: ListView(
                    controller: _scrollController,
                    reverse: true,
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                          color: Colors.white,
                          alignment: FractionalOffset(0.5, 0.2),
                          child: Column(children: <Widget>[
                            msgRows
                          ] //[msgRows],      //child: test,
                              ))
                    ]))));
  }
}
