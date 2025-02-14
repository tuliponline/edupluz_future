import 'package:intl/intl.dart';

String dateFormat(String dateTimeString) {
  // Create a DateFormat object with the desired pattern
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  // Parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Format the DateTime object using the DateFormat
  String formattedDate = dateFormat.format(dateTime);

  // Print the formatted date
  print("Formatted date: $formattedDate");

  return formattedDate;
}
