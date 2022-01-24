import 'models.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket socket = IO.io(
    'https://school-chat-server-ws.herokuapp.com/',
    IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // disable auto-connection
        .build());

void start_connection() {
  socket.connect();
}

void close_connection() {
  socket.disconnect();
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
            // print(data)
          });
}

void get_chat_ids(int user_id) {
  socket.emit("chats", {"user_id": user_id});
}

void request_chat_data_for_preview(int chat_id) {
  socket.emit("get-info", {
    "flag": "chat-for-preview",
    "data": {"chat_id": chat_id, "user_id": currentuser.id}
  });
}

void send(Message message) {
  socket.emit("newMessage", {
    "user_id": message.user_id,
    "id": message.id,
    "chat_id": message.chat_id,
    "text": message.text,
    "attachments": message.attachments,
    "deleted_all": message.deleted_all,
    "deleted_user": message.deleted_user,
    "edited": message.edited
  });
}

void requestChatMsgs(int user_id, int chat_id) {
  socket.emit("get-msgs", {"user_id": user_id, "chat_id": chat_id});
}

void recieve_chat_msgs(Function callback) {
  socket.on(
      "chat-message-recieve",
      (data) => {
            callback(data),
          });
}
