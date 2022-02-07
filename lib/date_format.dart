String formatDate(String unformatted) {
  try {
    DateTime time = DateTime.parse(unformatted);
    DateTime today = DateTime.now();
    Duration oneDay = const Duration(days: 1);
    Duration twoDay = const Duration(days: 2);
    Duration oneWeek = const Duration(days: 7);
    String month = "";
    int currhour = 0;
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
      currhour = time.hour + 3;
      if (time.minute.toString().length == 1) {
        return currhour.toString() + ":" + "0" + time.minute.toString();
      }
      return currhour.toString() + ":" + time.minute.toString();
    } else if (difference.compareTo(twoDay) < 1) {
      return "Вчера";
    } else if (difference.compareTo(oneWeek) < 1) {
      switch (time.weekday) {
        case 1:
          return "пн";
        case 2:
          return "вт";
        case 3:
          return "ср";
        case 4:
          return "чт";
        case 5:
          return "пт";
        case 6:
          return "сб";
        case 7:
          return "вc";
      }
    } else if (time.year == today.year) {
      return '${time.day} $month';
    } else {
      return '${time.day} $month ${time.year}';
    }
    return "";
  } catch (e) {
    return "";
  }
}
