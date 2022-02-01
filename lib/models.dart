// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

class Message {
  int id = 0;
  int chat_id = 0;
  int user_id = 0;
  String text = "";
  var attachments = {};
  bool deleted_all = false;
  bool deleted_user = false;
  bool edited = false;
  bool service = false;
  String updatedAt;
  Message(
      this.id,
      this.chat_id,
      this.user_id,
      this.text,
      this.attachments,
      this.deleted_all,
      this.deleted_user,
      this.edited,
      this.service,
      this.updatedAt);
}

class Chat {
  int? id;
  String? name;
  var users;
  var admins;
  int? creator;
  String? picture_url;
  String? last_msg_text;
  int? last_msg_user;
  String? last_msg_time;
  Chat(
      this.id,
      this.name,
      this.users,
      this.admins,
      this.creator,
      this.picture_url,
      this.last_msg_text,
      this.last_msg_time,
      this.last_msg_user);
}

class User {
  int id = 0;
  String name = "";
  String surname;
  int school_id;
  int class_id;
  String email;
  String phone;
  String avatar;
  User(this.id, this.name, this.surname, this.school_id, this.class_id,
      this.email, this.phone, this.avatar);
}

var currentuser =
    User(2, "Konstantin", "Leonov", 4, 4, "aboba@aboba.com", "88005553535", "");
