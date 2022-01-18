//ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'Strings.dart';
import 'chats.dart';
import 'auth.dart';
import 'SignUpPage.dart';
import 'socket_io_manager.dart';

void main() {
  runApp(
    MaterialApp(
      home: Auth()
    )
  );
}