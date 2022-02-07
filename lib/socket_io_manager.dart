// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'models.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io(
    'https://school-chat-server-ws.herokuapp.com/',
    IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // disable auto-connection
        .build());

// IO.Socket socket = IO.io(
//     'http://localhost:3000/',
//     IO.OptionBuilder()
//         .setTransports(['websocket']) // for Flutter or Dart VM
//         .disableAutoConnect() // disable auto-connection
//         .build());

void start_connection() {
  socket.connect();
}

void close_connection() {
  socket.disconnect();
}

void react_ans(Function callback) {
  socket.on(
      "register_ans",
      (data) => {
            callback(data),
          });
}

void auth_recieve(Function callback) {
  socket.on(
      "auth-recieve",
      (data) => {
            callback(data),
          });
}

void react_chats(Function callback) {
  socket.on(
      "recieve-chats",
      (data) => {
            callback(data['res']),
          });
}

void recieve_chats(Function callback) {
  socket.on(
      "chat_preview_info",
      (data) => {
            callback(data),
          });
}

void observe_messages(Function callback) {
  socket.on(
      "msg",
      (data) => {
            callback(data),
          });
}

void get_chat_ids(int userId) {
  socket.emit("chats", {"user_id": userId});
}

void request_chat_data_for_preview(int chatId) {
  socket.emit(
      "chat-for-preview", {"chat_id": chatId, "user_id": currentuser!.id});
}

// ignore: use_function_type_syntax_for_parameters
void send(int user_id, int chat_id, String text, attachments) {
  socket.emit("newMessage", {
    "user_id": user_id,
    // "id": message.id,
    "chat_id": chat_id,
    "text": text,
    "attachments": attachments,
    // "deleted_all": message.deleted_all,
    // "deleted_user": message.deleted_user,
    // "edited": message.edited
  });
}

void requestChatMsgs(int userId, int chatId) {
  socket.emit("get-msgs", {"user_id": userId, "chat_id": chatId});
}

void recieve_chat_msgs(Function callback) {
  socket.on(
      "chat-message-recieve",
      (data) => {
            callback(data),
          });
}

void request_chat_users(int chatId) {
  socket.emit("chat-users", {'chat_id': chatId});
}

void recieve_chat_users(Function callback) {
  socket.on(
      "recieve-chat-users",
      (data) => {
            print("recieve"),
            callback(data),
          });
}

void send_auth_data(data) {
  print("emitted");
  socket.emit("auth-data", {"data": data});
}

void send_registration_data(data) {
  socket.emit("register", data);
}

void react_register(Function callback) {
  socket.on("register_ans", (data) => {callback(data)});
}
