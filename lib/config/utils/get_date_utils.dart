import 'package:intl/intl.dart';

abstract class GetDateUtils {
  static String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String getDayNumber(DateTime date) {
    return DateFormat('dd').format(date);
  }

  static String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  static String getYear(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String getDayNameAndNumber(DateTime date) {
    return DateFormat('EEEE, dd').format(date);
  }

  static String getDayNameAndNumberAndMonthName(DateTime date) {
    return DateFormat('EEEE, dd MMMM').format(date);
  }

  static String getDayNameAndNumberAndMonthNameAndYear(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy').format(date);
  }

  static DateTime getLastWeek() {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));
    return lastWeek;
  }

  static DateTime getNextWeek() {
    final now = DateTime.now();
    final nextWeek = now.add(Duration(days: 7));
    return nextWeek;
  }
}
