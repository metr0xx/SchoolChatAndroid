// ignore_for_file: use_key_in_widget_constructors, no_logic_in_create_state
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: Text("clear")));
  }
}
