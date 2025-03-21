Duration getTimeDifference(String time, String time2) {
  var date1 = DateTime.parse(time);
  var date2 = DateTime.parse(time2);

  return date1.difference(date2);
}

Duration getTimeDifferenceFromNow(String? time) {
  if (time == null) return Duration(seconds: 0);
  var date1 = DateTime.now();
  var date2 = DateTime.parse(time);

  return date1.difference(date2);
}

String representTimeDifferenceInWords(Duration difference) {
  var days = difference.inDays;
  var hours = difference.inHours;
  var minutes = difference.inMinutes;
  var seconds = difference.inSeconds;

  var secondsToMinutes = setSecondsToMinutes(seconds);
  var minutesToHours = setMinutesToHours(minutes);
  var hoursToDays = setHoursToDays(hours);

  minutes += secondsToMinutes["minutes"] ?? 0;
  seconds = secondsToMinutes["remainingSeconds"] ?? 0;

  hours += minutesToHours["hours"] ?? 0;
  minutes = minutesToHours["remainingMinutes"] ?? 0;

  days += hoursToDays["days"] ?? 0;
  hours = hoursToDays["remainingHours"] ?? 0;

  String resultString = "";

  if (days > 0) resultString = "$resultString ${days}d";
  if (hours > 0) resultString = "$resultString ${hours}h";
  if (minutes > 0) resultString = "$resultString ${minutes}m";
  if (seconds >= 0) resultString = "$resultString ${seconds}s";

  return resultString;
}

Map<String, int> setSecondsToMinutes(int totalSeconds) {
  int minutes = totalSeconds ~/ 60; // Full minutes
  int remainingSeconds = totalSeconds % 60; // Remainder of seconds

  return {"minutes": minutes, "remainingSeconds": remainingSeconds};
}

Map<String, int> setMinutesToHours(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int remainingMinutes = totalMinutes % 60;

  return {"hours": hours, "remainingMinutes": remainingMinutes};
}

Map<String, int> setHoursToDays(int totalHours) {
  int days = totalHours ~/ 24;
  int remainingHours = totalHours % 24;

  return {"days": days, "remainingHours": remainingHours};
}
