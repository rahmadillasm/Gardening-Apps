part of 'models.dart';

class CalendarDayModel {
  String dayLetter;
  int dayNumber;
  int month;
  int year;
  bool isChecked;

  CalendarDayModel(
      {this.dayLetter, this.dayNumber, this.month, this.year, this.isChecked});

  List<CalendarDayModel> getCurrentDays() {
    // ignore: deprecated_member_use
    final List<CalendarDayModel> dayList = List();
    DateTime currentTime = DateTime.now();
    for (int i = 0; i < 7; i++) {
      dayList.add(CalendarDayModel(
          dayLetter: DateFormat.E().format(currentTime).toString()[0],
          dayNumber: currentTime.day,
          month: currentTime.month,
          year: currentTime.year,
          isChecked: false));
      currentTime = currentTime.add(Duration(days: 1));
    }
    dayList[0].isChecked = true;
    return dayList;
  }
}
