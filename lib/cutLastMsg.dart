String correctLastMsg(String lastmsg) {
  String result = lastmsg;
  if (lastmsg.length >= 20) {
    return lastmsg.substring(0, 16) + '...';
  }

  while (result.length != 40) {
    result += ' ';
  }
  print(result.length);
  return result.substring(0, 16);
}

String alignChatName(String name) {
  return '';
}
