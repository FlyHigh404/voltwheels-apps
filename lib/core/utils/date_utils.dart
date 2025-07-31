import 'package:intl/intl.dart';

class DayOfWeekModel {
  DateTime date;
  String dayName;

  DayOfWeekModel({required this.date, required this.dayName});
}

List<String> listDays = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

List<String> labelHours = [
  '01:00',
  '03:00',
  '06:00',
  '09:00',
  '12:00',
  '15:00',
  '18:00',
  '21:00',
  '23:00',
];

String convertTimestampToHHMM(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  String formattedTime = DateFormat('HH:mm').format(dateTime);

  return formattedTime;
}

int dateTimeToUnix(DateTime dateTime) {
  // Get the date without the time part
  DateTime dateWithoutTime =
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  print(dateWithoutTime);

  // Calculate Unix timestamp in seconds
  int unixTimestamp = dateWithoutTime.millisecondsSinceEpoch ~/ 1000;

  print(unixTimestamp);

  return unixTimestamp;
}

List<DayOfWeekModel> getDaysOfWeek() {
  List<DayOfWeekModel> daysOfWeek = [];
  DateTime now = DateTime.now();
  int dayOfWeek = now.weekday; // 1 (Monday) to 7 (Sunday)

  // Calculate Monday of the current week
  DateTime monday = now.subtract(Duration(days: dayOfWeek - 1));

  // Generate dates for Monday to Sunday
  for (int i = 0; i < 7; i++) {
    DateTime day = monday.add(Duration(days: i));
    String dayName = '';
    switch (day.weekday) {
      case 1:
        dayName = 'Sen';
        break;
      case 2:
        dayName = 'Sel';
        break;
      case 3:
        dayName = 'Rab';
        break;
      case 4:
        dayName = 'Kam';
        break;
      case 5:
        dayName = 'Jum';
        break;
      case 6:
        dayName = 'Sab';
        break;
      case 7:
        dayName = 'Min';
        break;
    }

    daysOfWeek.add(DayOfWeekModel(date: day, dayName: dayName));
  }

  return daysOfWeek;
}

String formatDuration(Duration duration) {
  if (duration.inHours >= 24) {
    return "${duration.inDays} hari";
  } else {
    return "${duration.inHours} jam";
  }
}

String formatDateTime(DateTime dateTime) {
  DateFormat formatter = DateFormat('dd MMMM yyyy HH:mm', 'id_ID');

  return formatter.format(dateTime);
}

String formatHM(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

String getExpiryStatus(DateTime expiryTime) {
  Duration remaining = expiryTime.difference(DateTime.now());

  if (remaining.isNegative) {
    return "Selesai";
  }

  if (remaining.inDays > 0) {
    return "${remaining.inDays} hari lagi";
  } else if (remaining.inHours > 0) {
    return "${remaining.inHours} jam lagi";
  } else if (remaining.inMinutes > 0) {
    return "${remaining.inMinutes} menit lagi";
  } else {
    return "${remaining.inSeconds} detik lagi";
  }
}

String formatDurationTimer(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String hoursString = (duration.inHours % 24).toString().padLeft(2, '0');
  String minutesString = twoDigits(duration.inMinutes.remainder(60));
  String secondsString = twoDigits(duration.inSeconds.remainder(60));

  if (duration.inDays > 0) {
    int days = duration.inDays;
    return '$days:$hoursString:$minutesString:$secondsString';
  } else if (duration.inHours > 0) {
    return '$hoursString:$minutesString:$secondsString';
  } else {
    return '$minutesString:$secondsString';
  }
}
