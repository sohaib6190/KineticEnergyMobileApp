part of 'generics.dart';

String translate(BuildContext context, String key) {
  return Localization.of(context)?.translate(key) ?? "Undefined translation";
}

String formattedDateDMY(DateTime dateTime) {
  String twoDigitString(int value) => value.toString().padLeft(2, '0');

  return '${twoDigitString(dateTime.day)}-${twoDigitString(dateTime.month)}-${dateTime.year}';
}

String formatDateZone(DateTime dateTime) {
  final formattedDate =
      "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T00:00:00Z";

  return formattedDate;
}

String formatDay(String durationString) {
  RegExp regex = RegExp(r'(\d+)d');
  Iterable<Match> matches = regex.allMatches(durationString);

  if (matches.isNotEmpty) {
    int days = int.parse(matches.elementAt(0).group(1)!);
    return days.toStringAsFixed(0);
  } else {
    return '0';
  }
}

String formatDate(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);
  return '${parsedDate.year}/${parsedDate.month}/${parsedDate.day}';
}
