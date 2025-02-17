String formatDuration(int milliseconds) {
  // Convert milliseconds to seconds
  final int seconds = (milliseconds / Duration.millisecondsPerSecond).floor();

  final int hours = (seconds / 3600).floor(); // Get whole hours
  final int minutes = ((seconds % 3600) / 60).floor(); // Get remaining minutes

  String formattedHours = hours.toString();
  if (hours == 1) {
    formattedHours = hours.toString(); // Keep "1" as is
    // Pad with leading zero for hours > 1
  } else {
    // hours == 0, so formattedHours remains empty
  }

  final String formattedMinutes =
      minutes.toString().padLeft(2, '0'); // Pad minutes with leading zero

  if ((formattedHours.isEmpty || formattedHours == "0") &&
      formattedMinutes == '00') {
    return 'Comming Soon';
  }
  if (formattedHours.isEmpty || formattedHours == "0") {
    return '$formattedMinutes นาที'; // Show only minutes if hours are 0
  } else {
    return '$formattedHours ชม. $formattedMinutes นาที';
  }
}

String formatDurationLesson(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);

  int minutes = duration.inMinutes;
  int seconds = duration.inSeconds % 60;

  String formattedMinutes = minutes.toString();
  if (minutes >= 1) {
    formattedMinutes = formattedMinutes.toString(); // Keep "1" as is
    // Pad with leading zero for minutes > 1
  } else {
    // minutes == 0, so formattedMinutes remains empty
  }

  final String formattedSecconds = seconds.toString().padLeft(2, '0');
  if (formattedSecconds.isEmpty || formattedMinutes == "0") {
    return '$formattedSecconds วินาที';
  } else {
    return '$formattedMinutes นาที $formattedSecconds วินาที';
  }
}
