import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class DateTimeConverter{

static  String formatDate(DateTime date) {
  return DateFormat('d MMMM, yyyy ' 'AT' ' hh:mm a').format(date);
}






}