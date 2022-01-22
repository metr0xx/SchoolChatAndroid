String cutLastMsg(String lastmsg) {
  String result = lastmsg;
  if (lastmsg.length >= 20) {
    result = lastmsg.substring(0, 16) + '...';
  } else {
    while (result.length != 20) {
      result += ' ';
    }
  }
  return result;
}
