String parseTodoDate(DateTime data) {
  int daysLeft = DateTime.now().difference(data).inDays;
  int hoursLeft = (DateTime.now().difference(data).inHours % 24) * -1;
  String parsedDate = '';

  if (daysLeft < 0 && hoursLeft < 0) {
    daysLeft *= -1;
    hoursLeft *= -1;

    parsedDate = '$daysLeft day(s) $hoursLeft hour(s) left';
  } else if (daysLeft < 0 && hoursLeft == 0) {
    daysLeft *= -1;

    parsedDate = '$daysLeft day(s) left';
  } else if (daysLeft == 0 && hoursLeft < 0) {
    hoursLeft *= -1;

    parsedDate = '$hoursLeft hour(s) left';
  } else if (daysLeft > 0 && hoursLeft > 0) {
    parsedDate = '$daysLeft day(s) $hoursLeft hour(s) late';
  } else if (daysLeft > 0 && hoursLeft == 0) {
    parsedDate = '$daysLeft day(s) late';
  } else if (daysLeft == 0 && hoursLeft > 0) {
    parsedDate = '$hoursLeft hour(s) late';
  } else {
    parsedDate = 'DEADLINE';
  }

  return parsedDate;
}
