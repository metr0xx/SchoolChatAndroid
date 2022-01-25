// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state
import 'package:flutter/material.dart';

class ChatInfo extends StatefulWidget {
  int? id;
  ChatInfo(this.id);
  State<StatefulWidget> createState() {
    return ChatInfoState(id);
  }
}

class ChatInfoState extends State<ChatInfo> {
  ChatInfoState(int? id);
  int? id;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: Text("Avpva")));
  }
}
