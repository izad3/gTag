import 'package:intl/intl.dart';

String formatMessageDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final messageDate = DateTime(date.year, date.month, date.day);
  String minute = date.minute > 9 ? date.minute.toString() : '0${date.minute}';
  if (messageDate == today) {
    return 'Today ${date.hour}:$minute';
  } else if (messageDate == yesterday) {
    return 'Yesterday ${date.hour}:$minute';
  } else {
    return DateFormat('E, MMM d, H:mm').format(date);
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
