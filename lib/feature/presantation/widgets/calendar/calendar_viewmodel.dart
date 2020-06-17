import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/untils/calendar_untils.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/calendar/widgets/calendar_tile.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:stacked/stacked.dart';

class CalendarViewModel extends BaseViewModel {
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeekDays;
  DateTime selectedDate = DateTime.now();
  String currentMonth;
  bool isExpanded = true;
  String displayMonth = "";
  List weekDays = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"];
  List events;

  CalendarViewModel({this.events});

  List<Widget> calendarBuilder() {
    selectedMonthsDays = CalendarUtils.daysInMonth(selectedDate);
    selectedWeekDays = CalendarUtils.daysInWeek(selectedDate);

    final monthFormat = DateFormat("MMMM yyyy").format(selectedDate);
    displayMonth = "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";

    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
    isExpanded ? selectedMonthsDays : selectedWeekDays;

    weekDays.forEach((day) =>
        dayWidgets.add(
          CalendarTile(
            isDayOfWeek: true,
            dayOfWeek: day,
          ),
        )
    );

    calendarDays.forEach((day) => dayWidgets.add(
      CalendarTile(
        events: events,
        onDateSelected: () => handleSelectedDate(day),
        date: day,
        isSelected: CalendarUtils.isSameDay(selectedDate, day),
        inMonth: day.month == selectedDate.month,
        isWeekend: CalendarUtils.isWeekend(day),
      ),
    ));

    return dayWidgets;
  }

  void resetToToday() {
    selectedDate = DateTime.now();

    _launchDateSelectionCallback(selectedDate);
  }

  void nextMonth() {
    selectedDate = CalendarUtils.nextMonth(selectedDate);

    _launchDateSelectionCallback(selectedDate);
  }

  void previousMonth() {
    selectedDate = CalendarUtils.previousMonth(selectedDate);

    _launchDateSelectionCallback(selectedDate);
  }

  void nextWeek() {
    selectedDate = CalendarUtils.nextWeek(selectedDate);

    _launchDateSelectionCallback(selectedDate);
  }

  void previousWeek() {
    selectedDate = CalendarUtils.previousWeek(selectedDate);

    _launchDateSelectionCallback(selectedDate);
  }

  void toggleExpanded() {
    selectedMonthsDays = CalendarUtils.daysInMonth(selectedDate);
    isExpanded = !isExpanded;
    notifyListeners();
  }

  void onVerticalSwipe(SwipeDirection swipeDirection) {}

  void onHorizontalSwipe(SwipeDirection swipeDirection) {
    if (isExpanded) nextMonth();
    else nextWeek();
    notifyListeners();
  }

  void _launchDateSelectionCallback(DateTime day) {
    notifyListeners();
  }

  void handleSelectedDate(DateTime day) {
    selectedDate = day;
    final result = DateFormat("yyyy-MM-dd").format(day);

    print('day ======================= $day');
    print('result ======================= $result');
    _launchDateSelectionCallback(day);
  }
}