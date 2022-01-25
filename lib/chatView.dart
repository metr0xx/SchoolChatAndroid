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

String selectedPopupRoute = "My Home";
final List<String> popupRoutes = <String>[
  "My Home",
  "Favorite Room 1",
  "Favorite Room 2"
];

var MessagesSize = ValueNotifier<int>(0);

List messages = [];
Column msgRows = Column();
bool curruser = true;

class ChatViewState extends State<ChatView> {
  @override
  int? id;
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
    // ContextMenuArea contextmenu() {
    //   return ContextMenuArea(
    //     items: [
    //       ListTile(
    //         title: Text('Option 1'),
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content: Text('Whatever'),
    //             ),
    //           );
    //         },
    //       ),
    //       ListTile(
    //         leading: Icon(Icons.model_training),
    //         title: Text('Option 2'),
    //         onTap: () {
    //           Navigator.of(context).pop();
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(
    //               content: Text('Foo!'),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //     child: Card(
    //       color: Theme.of(context).primaryColor,
    //       child: Center(
    //         child: Text(
    //           'Press somewhere for context menu.',
    //           style: TextStyle(
    //             color: Theme.of(context).colorScheme.onPrimary,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

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
    int lastSize = 0;
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
        // update();

        lastSize = messages.length;
        MessagesSize = ValueNotifier<int>(messages.length);
      } // print(data[o]);
      Column createMsgs() {
        Column columnOfMessages = Column(
          children: <Widget>[],
        );
        for (int i = 0; i < messages.length; i++) {
          print("vnizu MSG");
          print(messages[i].text);

          if (messages[i].user_id == currentuser.id) {
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

          Align msg = Align(
              alignment: Alignment(x, y),
              child: Container(
                  color: color,
                  child:
                      createMsgView(messages[i].text, messages[i].updatedAt)));
          columnOfMessages.children.add(msg);
        }
        return columnOfMessages;
      }

      msgRows = createMsgs();
      update();
    }

    print("vnizu messages");
    print(messages);
    print(MessagesSize);
    recieve_chat_msgs(get_message);
    observe_messages(new_message);
    update();
    if (ShouldUpdate) {
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
