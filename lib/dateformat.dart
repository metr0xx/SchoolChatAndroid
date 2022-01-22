import 'package:intl/intl.dart';

String formatDate(String unformatted) {
  DateTime time = DateTime.parse(unformatted);
  List ydm = [];
  String year = "";
  String day = "";
  DateTime today = DateTime.now();
  Duration oneDay = Duration(days: 1);
  Duration twoDay = Duration(days: 2);
  Duration oneWeek = Duration(days: 7);
  String month = "";
  switch (time.month) {
    case 1:
      month = "января";
      break;
    case 2:
      month = "февраля";
      break;
    case 3:
      month = "марта";
      break;
    case 4:
      month = "апреля";
      break;
    case 5:
      month = "мая";
      break;
    case 6:
      month = "июня";
      break;
    case 7:
      month = "июля";
      break;
    case 8:
      month = "августа";
      break;
    case 9:
      month = "сентября";
      break;
    case 10:
      month = "октября";
      break;
    case 11:
      month = "ноября";
      break;
    case 12:
      month = "декабря";
      break;
  }
  Duration difference = today.difference(time);

  if (difference.compareTo(oneDay) < 1) {
    return "Сегодня";
  } else if (difference.compareTo(twoDay) < 1) {
    return "Вчера";
  } else if (difference.compareTo(oneWeek) < 1) {
    switch (time.weekday) {
      case 1:
        return "понедельник";
      case 2:
        return "вторник";
      case 3:
        return "среда";
      case 4:
        return "четверг";
      case 5:
        return "пятница";
      case 6:
        return "суббота";
      case 7:
        return "воскресенье";
    }
  } else if (time.year == today.year) {
    return '${time.day} $month';
  } else {
    return '${time.day} $month ${time.year}';
  }
  return "";
}
