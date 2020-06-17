//import 'package:flutter/material.dart';
//import 'package:flutter_clean_calendar/simple_gesture_detector.dart';
//import 'package:intl/intl.dart';
//import 'package:intl/date_symbol_data_local.dart';
//
//typedef DayBuilder(BuildContext context, DateTime day);
//
//class CustomCalendar extends StatefulWidget {
//  final ValueChanged<DateTime> onDateSelected;
//  final ValueChanged<DateTime> onMonthChanged;
//  final ValueChanged onRangeSelected;
//  final bool isExpandable;
//  final DayBuilder dayBuilder;
//  final bool hideArrows;
//  final bool hideTodayIcon;
//  final Map<DateTime, List> events;
//  final Color selectedColor;
//  final Color todayColor;
//  final Color eventColor;
//  final Color eventDoneColor;
//  final DateTime initialDate;
//  final bool isExpanded;
//  final List<String> weekDays;
//  final String locale;
//  final bool hideBottomBar;
//  final TextStyle dayOfWeekStyle;
//  final TextStyle bottomBarTextStyle;
//  final Color bottomBarArrowColor;
//  final Color bottomBarColor;
//
//  CustomCalendar({
//    this.onMonthChanged,
//    this.onDateSelected,
//    this.onRangeSelected,
//    this.hideBottomBar: false,
//    this.isExpandable: false,
//    this.events,
//    this.dayBuilder,
//    this.hideTodayIcon: false,
//    this.hideArrows: false,
//    this.selectedColor,
//    this.todayColor,
//    this.eventColor,
//    this.eventDoneColor,
//    this.initialDate,
//    this.isExpanded = false,
//    this.weekDays = const ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
//    this.locale = "en_US",
//    this.dayOfWeekStyle,
//    this.bottomBarTextStyle,
//    this.bottomBarArrowColor,
//    this.bottomBarColor,
//  });
//
//  @override
//  _CalendarState createState() => _CalendarState();
//}
//
//class _CalendarState extends State<CustomCalendar> {
//  final calendarUtils = Utils();
//  List<DateTime> selectedMonthsDays;
//  Iterable<DateTime> selectedWeekDays;
//  DateTime _selectedDate = DateTime.now();
//  String currentMonth;
//  bool isExpanded = false;
//  String displayMonth = "";
//  DateTime get selectedDate => _selectedDate;
//
//  void initState() {
//    super.initState();
//    _selectedDate = widget?.initialDate ?? DateTime.now();
//    isExpanded = widget?.isExpanded ?? false;
//    selectedMonthsDays = _daysInMonth(_selectedDate);
//
//    selectedWeekDays = Utils.daysInRange(
//        _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
//        .toList();
//
//    initializeDateFormatting(widget.locale, null).then((_) => setState(() {
//      var monthFormat =
//      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
//      displayMonth =
//      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
//    }));
//  }
//
//  List<Widget> calendarBuilder() {
//    List<Widget> dayWidgets = [];
//
//    List<DateTime> calendarDays =
//    isExpanded ? selectedMonthsDays : selectedWeekDays;
//
//    widget.weekDays.forEach(
//          (day) {
//        dayWidgets.add(
//          CalendarTile(
//            selectedColor: widget.selectedColor,
//            todayColor: widget.todayColor,
//            eventColor: widget.eventColor,
//            eventDoneColor: widget.eventDoneColor,
//            events: widget.events[day],
//            isDayOfWeek: true,
//            dayOfWeek: day,
//            dayOfWeekStyle: widget.dayOfWeekStyle ??
//                TextStyle(
//                  color: widget.selectedColor,
//                  fontWeight: FontWeight.w500,
//                  fontSize: 11,
//                ),
//          ),
//        );
//      },
//    );
//
//    calendarDays.forEach((day) => dayWidgets.add(
//      CalendarTile(
//        selectedColor: widget.selectedColor,
//        todayColor: widget.todayColor,
//        eventColor: widget.eventColor,
//        eventDoneColor: widget.eventDoneColor,
//        events: widget.events[day],
//        onDateSelected: () => handleSelectedDateAndUserCallback(day),
//        date: day,
//        isSelected: Utils.isSameDay(selectedDate, day),
//        inMonth: day.month == selectedDate.month,
//        isWeekend: Utils.isWeekend(day),
//      ),
//    ));
//
//    return dayWidgets;
//  }
//
//  TextStyle configureDateStyle(monthStarted, monthEnded) {
//    TextStyle dateStyles;
//    final TextStyle body1Style = Theme.of(context).textTheme.body1;
//
//    if (isExpanded) {
//      final TextStyle body1StyleDisabled = body1Style.copyWith(
//          color: Color.fromARGB(
//            100,
//            body1Style.color.red,
//            body1Style.color.green,
//            body1Style.color.blue,
//          ));
//
//      dateStyles =
//      monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
//    } else {
//      dateStyles = body1Style;
//    }
//    return dateStyles;
//  }
//
//  Widget get nameAndIconRow {
//    var todayIcon;
//    var leftArrow;
//    var rightArrow;
//
//    if (!widget.hideArrows) {
//      leftArrow = IconButton(
//        onPressed: isExpanded ? previousMonth : previousWeek,
//        icon: Icon(Icons.chevron_left),
//      );
//      rightArrow = IconButton(
//        onPressed: isExpanded ? nextMonth : nextWeek,
//        icon: Icon(Icons.chevron_right),
//      );
//    } else {
//      leftArrow = Container();
//      rightArrow = Container();
//    }
//
//    if (!widget.hideTodayIcon) {
//      todayIcon = InkWell(
//        child: Text('Сегодня'),
//        onTap: resetToToday,
//      );
//    } else {
//      todayIcon = Container();
//    }
//    print('displayMonth ================== $displayMonth');
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: [
//        leftArrow ?? Container(),
//        Column(
//          children: <Widget>[
//            todayIcon ?? Container(),
//            Text(
//              displayMonth,
//              style: TextStyle(
//                fontSize: 20.0,
//              ),
//            ),
//          ],
//        ),
//        rightArrow ?? Container(),
//      ],
//    );
//  }
//
//  Widget get calendarGridView {
//    return Container(
//      child: SimpleGestureDetector(
//        onSwipeUp: _onSwipeUp,
//        onSwipeDown: _onSwipeDown,
//        onSwipeLeft: _onSwipeLeft,
//        onSwipeRight: _onSwipeRight,
//        swipeConfig: SimpleSwipeConfig(
//          verticalThreshold: 10.0,
//          horizontalThreshold: 40.0,
//          swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
//        ),
//        child: Column(children: <Widget>[
//          GridView.count(
//            childAspectRatio: 1.5,
//            primary: false,
//            shrinkWrap: true,
//            crossAxisCount: 7,
//            padding: EdgeInsets.only(bottom: 0.0),
//            children: calendarBuilder(),
//          ),
//        ]),
//      ),
//    );
//  }
//
//  Widget get expansionButtonRow => SimpleGestureDetector(
//      onSwipeUp: _onSwipeUp,
//      onSwipeDown: _onSwipeDown,
//      swipeConfig: SimpleSwipeConfig(
//        verticalThreshold: 10.0,
//        swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
//      ),
//      child: GestureDetector(
//        onTap: toggleExpanded,
//        child: Container(
//          color: Colors.black12,
//          height: 40,
//          margin: EdgeInsets.only(top: 8.0),
//          padding: EdgeInsets.all(0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(left: 20),
//                child: Text(
//                  Utils.fullDayFormat(selectedDate),
//                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
//                ),
//              ),
//              SizedBox(width: 40.0),
//              IconButton(
//                onPressed: toggleExpanded,
//                iconSize: 25.0,
//                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
//                icon: isExpanded
//                    ? Icon(
//                  Icons.arrow_drop_up,
//                  color: widget.bottomBarArrowColor ?? Colors.black,
//                )
//                    : Icon(
//                  Icons.arrow_drop_down,
//                  color: widget.bottomBarArrowColor ?? Colors.black,
//                ),
//              ),
//            ],
//          ),
//        ),
//      )
//  );
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          nameAndIconRow,
//          ExpansionCrossFade(
//            collapsed: calendarGridView,
//            expanded: calendarGridView,
//            isExpanded: isExpanded,
//          ),
//          expansionButtonRow
//        ],
//      ),
//    );
//  }
//
//  void resetToToday() {
//    setState(() {
//      _selectedDate = DateTime.now();
//      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
//      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
//
//      selectedWeekDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList();
//      selectedMonthsDays = _daysInMonth(_selectedDate);
//      var monthFormat =
//      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
//      displayMonth =
//      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
//    });
//
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void nextMonth() {
//    setState(() {
//      print('displayMonth =============11============= $displayMonth');
//      _selectedDate = Utils.nextMonth(_selectedDate);
//      selectedMonthsDays = _daysInMonth(_selectedDate);
//
//      var monthFormat =
//      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
//
//      displayMonth =
//      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
//
//      print('displayMonth =============22============= $displayMonth');
//    });
//
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void previousMonth() {
//    setState(() {
//      _selectedDate = Utils.previousMonth(_selectedDate);
//      selectedMonthsDays = _daysInMonth(_selectedDate);
//      var monthFormat =
//      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
//      displayMonth =
//      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
//    });
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void nextWeek() {
//    setState(() {
//      _selectedDate = Utils.nextWeek(_selectedDate);
//      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
//      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
//      selectedWeekDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList();
//      var monthFormat =
//      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
//      displayMonth =
//      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
//    });
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void previousWeek() {
//    setState(() {
//      _selectedDate = Utils.previousWeek(_selectedDate);
//      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
//      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
//      selectedWeekDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList();
//      var monthFormat =
//      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
//      displayMonth =
//      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
//    });
//    _launchDateSelectionCallback(_selectedDate);
//  }
//
//  void _onSwipeUp() {
//    if (isExpanded) toggleExpanded();
//  }
//
//  void _onSwipeDown() {
//    if (!isExpanded) toggleExpanded();
//  }
//
//  void _onSwipeRight() {
//    if (isExpanded) {
//      previousMonth();
//    } else {
//      previousWeek();
//    }
//  }
//
//  void _onSwipeLeft() {
//    if (isExpanded) {
//      nextMonth();
//    } else {
//      nextWeek();
//    }
//  }
//
//  void toggleExpanded() {
//    if (widget.isExpandable) {
//      setState((){
//        selectedMonthsDays = _daysInMonth(_selectedDate);
//        isExpanded = !isExpanded;
//      });
//    }
//  }
//
//  void handleSelectedDateAndUserCallback(DateTime day) {
//    var firstDayOfCurrentWeek = _firstDayOfWeek(day);
//    var lastDayOfCurrentWeek = _lastDayOfWeek(day);
//
//    setState(() {
//      _selectedDate = day;
//      selectedWeekDays =
//          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
//              .toList();
//      selectedMonthsDays = _daysInMonth(day);
//
//      if (_selectedDate.month > day.month) {
//        previousMonth();
//      }
//      if (_selectedDate.month < day.month) {
//        nextMonth();
//      }
//    });
//    _launchDateSelectionCallback(day);
//  }
//
//  void _launchDateSelectionCallback(DateTime day) {
//    if (widget.onDateSelected != null) {
//      widget.onDateSelected(day);
//    }
//    if (widget.onMonthChanged != null) {
//      widget.onMonthChanged(day);
//    }
//  }
//
//  _firstDayOfWeek(DateTime date) {
//    var day = new DateTime.utc(date.year, date.month, date.day, 12);
//    return day.subtract(
//        new Duration(days: day.weekday - 1));
//  }
//
//  _lastDayOfWeek(DateTime date) {
//    return _firstDayOfWeek(date).add(new Duration(days: 7));
//  }
//
//  List<DateTime> _daysInMonth(DateTime selectedDay) {
//    var first = Utils.firstDayOfMonth(selectedDay);
//    var daysBefore = first.weekday;
//    var firstToDisplay = first
//        .subtract(new Duration(days: daysBefore - 1))
//        .subtract(new Duration(days: 0));
//
//
//    var last = Utils.lastDayOfMonth(selectedDay);
//
//    var daysAfter = 8 - last.weekday;
//
//    var lastToDisplay = last.add(new Duration(days: daysAfter));
//    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
//  }
//}
//
//class ExpansionCrossFade extends StatelessWidget {
//  final Widget collapsed;
//  final Widget expanded;
//  final bool isExpanded;
//
//  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});
//
//  @override
//  Widget build(BuildContext context) {
//    return Flexible(
//      flex: 1,
//      child: AnimatedCrossFade(
//        firstChild: collapsed,
//        secondChild: expanded,
//        firstCurve: const Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
//        secondCurve: const Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
//        sizeCurve: Curves.decelerate,
//        crossFadeState:
//        isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//        duration: const Duration(milliseconds: 300),
//      ),
//    );
//  }
//}
//
//
//class CalendarTile extends StatelessWidget {
//  final VoidCallback onDateSelected;
//  final DateTime date;
//  final String dayOfWeek;
//  final bool isDayOfWeek;
//  final bool isSelected;
//  final bool isWeekend;
//  final bool inMonth;
//  final List events;
//  final TextStyle dayOfWeekStyle;
//  final TextStyle dateStyles;
//  final Widget child;
//  final Color selectedColor;
//  final Color todayColor;
//  final Color eventColor;
//  final Color eventDoneColor;
//
//  CalendarTile({
//    this.onDateSelected,
//    this.date,
//    this.child,
//    this.dateStyles,
//    this.dayOfWeek,
//    this.dayOfWeekStyle,
//    this.isDayOfWeek: false,
//    this.isSelected: false,
//    this.isWeekend: false,
//    this.inMonth: true,
//    this.events,
//    this.selectedColor,
//    this.todayColor,
//    this.eventColor,
//    this.eventDoneColor,
//  });
//
//  Widget renderDateOrDayOfWeek(BuildContext context) {
//    if (isDayOfWeek) {
//      return new InkWell(
//        child: new Container(
//          alignment: Alignment.center,
//          child: new Text(
//            dayOfWeek,
//            style: dayOfWeekStyle,
//          ),
//        ),
//      );
//    } else {
//      int eventCount = 0;
//      return InkWell(
//        onTap: onDateSelected,
//        child: Padding(
//          padding: const EdgeInsets.all(1.0),
//          child: Container(
//            decoration: isSelected
//                ? BoxDecoration(
//              shape: BoxShape.rectangle,
//              color: selectedColor != null
//                  ? Utils.isSameDay(this.date, DateTime.now())
//                  ? Colors.red
//                  : selectedColor
//                  : Theme.of(context).primaryColor,
//              borderRadius: BorderRadius.circular(10),
//            )
//                : BoxDecoration(),
//            alignment: Alignment.center,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  DateFormat("d").format(date),
//                  style: TextStyle(
//                      fontSize: 14.0,
//                      fontWeight: FontWeight.w400,
//                      color: !isWeekend ? isSelected
//                          ? Colors.red
//                          : Utils.isSameDay(this.date, DateTime.now())
//                          ? todayColor
//                          : inMonth ? Colors.black : Colors.grey[500] : Colors.grey[500]
//                  ),
//                ),
//                events != null && events.length > 0
//                    ? Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: events.map((event) {
//                      eventCount++;
//                      if (eventCount > 3) return Container();
//                      return Container(
//                        margin: EdgeInsets.only(
//                            left: 2.0, right: 2.0, top: 1.0),
//                        width: 5.0,
//                        height: 5.0,
//                        decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          color: event["isDone"]
//                              ? eventDoneColor ??
//                              Theme.of(context).primaryColor
//                              : eventColor ?? Theme.of(context).accentColor,
//                        ),
//                      );
//                    }).toList())
//                    : Container(),
//              ],
//            ),
//          ),
//        ),
//      );
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (child != null) {
//      return new InkWell(
//        child: child,
//        onTap: onDateSelected,
//      );
//    }
//    return new Container(
//      child: renderDateOrDayOfWeek(context),
//    );
//  }
//}
//
//class Utils {
//  static final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
//  static final DateFormat _dayFormat = new DateFormat("dd");
//  static final DateFormat _firstDayFormat = new DateFormat("MMM dd");
////  static final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy", 'ru');
//  static final DateFormat _fullDayFormat = new DateFormat("dd MMMM, EEEE", 'ru');
//  static final DateFormat _apiDayFormat = new DateFormat("yyyy-MM-dd");
//
//  static String formatMonth(DateTime d) => _monthFormat.format(d);
//  static String formatDay(DateTime d) => _dayFormat.format(d);
//  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
//  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
//  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
//
//  static const List<String> weekdays = const [
//    "Sun",
//    "Mon",
//    "Tue",
//    "Wed",
//    "Thu",
//    "Fri",
//    "Sat"
//  ];
//
//  /// The list of days in a given month
//  static List<DateTime> daysInMonth(DateTime month) {
//    var first = firstDayOfMonth(month);
//    var daysBefore = first.weekday;
//    var firstToDisplay = first.subtract(new Duration(days: daysBefore));
//    var last = Utils.lastDayOfMonth(month);
//
//    var daysAfter = 7 - last.weekday;
//
//    // If the last day is sunday (7) the entire week must be rendered
//    if (daysAfter == 0) {
//      daysAfter = 7;
//    }
//
//    var lastToDisplay = last.add(new Duration(days: daysAfter));
//    return daysInRange(firstToDisplay, lastToDisplay).toList();
//  }
//
//  static bool isFirstDayOfMonth(DateTime day) {
//    return isSameDay(firstDayOfMonth(day), day);
//  }
//
//  static bool isLastDayOfMonth(DateTime day) {
//    return isSameDay(lastDayOfMonth(day), day);
//  }
//
//  static bool isWeekend(DateTime day) {
//    final dateFormat = new DateFormat("EEE", 'ru');
//    final result = dateFormat.format(day);
//    if(result == 'сб' || result == 'вс') return true;
//    else return false;
//  }
//
//  static DateTime firstDayOfMonth(DateTime month) {
//    return new DateTime(month.year, month.month);
//  }
//
//  static DateTime firstDayOfWeek(DateTime day) {
//    /// Handle Daylight Savings by setting hour to 12:00 Noon
//    /// rather than the default of Midnight
//    day = new DateTime.utc(day.year, day.month, day.day, 12);
//
//    /// Weekday is on a 1-7 scale Monday - Sunday,
//    /// This Calendar works from Sunday - Monday
//    var decreaseNum = day.weekday % 7;
//    return day.subtract(new Duration(days: decreaseNum));
//  }
//
//  static DateTime lastDayOfWeek(DateTime day) {
//    /// Handle Daylight Savings by setting hour to 12:00 Noon
//    /// rather than the default of Midnight
//    day = new DateTime.utc(day.year, day.month, day.day, 12);
//
//    /// Weekday is on a 1-7 scale Monday - Sunday,
//    /// This Calendar's Week starts on Sunday
//    var increaseNum = day.weekday % 7;
//    return day.add(new Duration(days: 7 - increaseNum));
//  }
//
//  /// The last day of a given month
//  static DateTime lastDayOfMonth(DateTime month) {
//    var beginningNextMonth = (month.month < 12)
//        ? new DateTime(month.year, month.month + 1, 1)
//        : new DateTime(month.year + 1, 1, 1);
//    return beginningNextMonth.subtract(new Duration(days: 1));
//  }
//
//  /// Returns a [DateTime] for each day the given range.
//  ///
//  /// [start] inclusive
//  /// [end] exclusive
//  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
//    var i = start;
//    var offset = start.timeZoneOffset;
//    while (i.isBefore(end)) {
//      yield i;
//      i = i.add(new Duration(days: 1));
//      var timeZoneDiff = i.timeZoneOffset - offset;
//      if (timeZoneDiff.inSeconds != 0) {
//        offset = i.timeZoneOffset;
//        i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
//      }
//    }
//  }
//
//  /// Whether or not two times are on the same day.
//  static bool isSameDay(DateTime a, DateTime b) {
//    return a.year == b.year && a.month == b.month && a.day == b.day;
//  }
//
//  static bool isSameWeek(DateTime a, DateTime b) {
//    /// Handle Daylight Savings by setting hour to 12:00 Noon
//    /// rather than the default of Midnight
//    a = new DateTime.utc(a.year, a.month, a.day);
//    b = new DateTime.utc(b.year, b.month, b.day);
//
//    var diff = a.toUtc().difference(b.toUtc()).inDays;
//    if (diff.abs() >= 7) {
//      return false;
//    }
//
//    var min = a.isBefore(b) ? a : b;
//    var max = a.isBefore(b) ? b : a;
//    var result = max.weekday % 7 - min.weekday % 7 >= 0;
//    return result;
//  }
//
//  static DateTime previousMonth(DateTime m) {
//    var year = m.year;
//    var month = m.month;
//    if (month == 1) {
//      year--;
//      month = 12;
//    } else {
//      month--;
//    }
//    return new DateTime(year, month);
//  }
//
//  static DateTime nextMonth(DateTime m) {
//    var year = m.year;
//    var month = m.month;
//
//    if (month == 12) {
//      year++;
//      month = 1;
//    } else {
//      month++;
//    }
//    return new DateTime(year, month);
//  }
//
//  static DateTime previousWeek(DateTime w) {
//    return w.subtract(new Duration(days: 7));
//  }
//
//  static DateTime nextWeek(DateTime w) {
//    return w.add(new Duration(days: 7));
//  }
//}
//
////import 'package:flutter/material.dart';
////import 'package:flutter_clean_calendar/simple_gesture_detector.dart';
////import 'package:intl/intl.dart';
////import 'package:intl/date_symbol_data_local.dart';
////
////typedef DayBuilder(BuildContext context, DateTime day);
////
////class Range {
////  final DateTime from;
////  final DateTime to;
////  Range(this.from, this.to);
////}
////
////class CustomCalendar extends StatefulWidget {
////  final ValueChanged<DateTime> onDateSelected;
////  final ValueChanged<DateTime> onMonthChanged;
////  final ValueChanged onRangeSelected;
////  final bool isExpandable;
////  final DayBuilder dayBuilder;
////  final bool hideArrows;
////  final bool hideTodayIcon;
////  final Map<DateTime, List> events;
////  final Color selectedColor;
////  final Color todayColor;
////  final Color eventColor;
////  final Color eventDoneColor;
////  final DateTime initialDate;
////  final bool isExpanded;
////  final List<String> weekDays;
////  final String locale;
////  final bool hideBottomBar;
////  final TextStyle dayOfWeekStyle;
////  final TextStyle bottomBarTextStyle;
////  final Color bottomBarArrowColor;
////  final Color bottomBarColor;
////
////  CustomCalendar({
////    this.onMonthChanged,
////    this.onDateSelected,
////    this.onRangeSelected,
////    this.hideBottomBar: false,
////    this.isExpandable: false,
////    this.events,
////    this.dayBuilder,
////    this.hideTodayIcon: false,
////    this.hideArrows: false,
////    this.selectedColor,
////    this.todayColor,
////    this.eventColor,
////    this.eventDoneColor,
////    this.initialDate,
////    this.isExpanded = false,
////    this.weekDays = const ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
////    this.locale = "en_US",
////    this.dayOfWeekStyle,
////    this.bottomBarTextStyle,
////    this.bottomBarArrowColor,
////    this.bottomBarColor,
////  });
////
////  @override
////  _CalendarState createState() => _CalendarState();
////}
////
////class _CalendarState extends State<CustomCalendar> {
////  final calendarUtils = Utils();
////  List<DateTime> selectedMonthsDays;
////  Iterable<DateTime> selectedWeekDays;
////  DateTime _selectedDate = DateTime.now();
////  String currentMonth;
////  bool isExpanded = false;
////  String displayMonth = "";
////  DateTime get selectedDate => _selectedDate;
////
////  void initState() {
////    super.initState();
////    _selectedDate = widget?.initialDate ?? DateTime.now();
////    isExpanded = widget?.isExpanded ?? false;
////    selectedMonthsDays = _daysInMonth(_selectedDate);
////
////    selectedWeekDays = Utils.daysInRange(
////        _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
////        .toList();
////
////    initializeDateFormatting(widget.locale, null).then((_) => setState(() {
////      var monthFormat =
////      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
////      displayMonth =
////      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
////    }));
////  }
////
////  List<Widget> calendarBuilder() {
////    List<Widget> dayWidgets = [];
////
////    List<DateTime> calendarDays =
////    isExpanded ? selectedMonthsDays : selectedWeekDays;
////
////    widget.weekDays.forEach(
////          (day) {
////        dayWidgets.add(
////          CalendarTile(
////            selectedColor: widget.selectedColor,
////            todayColor: widget.todayColor,
////            eventColor: widget.eventColor,
////            eventDoneColor: widget.eventDoneColor,
////            events: widget.events[day],
////            isDayOfWeek: true,
////            dayOfWeek: day,
////            dayOfWeekStyle: widget.dayOfWeekStyle ??
////                TextStyle(
////                  color: widget.selectedColor,
////                  fontWeight: FontWeight.w500,
////                  fontSize: 11,
////                ),
////          ),
////        );
////      },
////    );
////
////    calendarDays.forEach((day) => dayWidgets.add(
////      CalendarTile(
////        selectedColor: widget.selectedColor,
////        todayColor: widget.todayColor,
////        eventColor: widget.eventColor,
////        eventDoneColor: widget.eventDoneColor,
////        events: widget.events[day],
////        onDateSelected: () => handleSelectedDateAndUserCallback(day),
////        date: day,
////        isSelected: Utils.isSameDay(selectedDate, day),
////        inMonth: day.month == selectedDate.month,
////        isWeekend: Utils.isWeekend(day),
////      ),
////    ));
////
////    return dayWidgets;
////  }
////
////  TextStyle configureDateStyle(monthStarted, monthEnded) {
////    TextStyle dateStyles;
////    final TextStyle body1Style = Theme.of(context).textTheme.body1;
////
////    if (isExpanded) {
////      final TextStyle body1StyleDisabled = body1Style.copyWith(
////          color: Color.fromARGB(
////            100,
////            body1Style.color.red,
////            body1Style.color.green,
////            body1Style.color.blue,
////          ));
////
////      dateStyles =
////      monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
////    } else {
////      dateStyles = body1Style;
////    }
////    return dateStyles;
////  }
////
////  Widget get nameAndIconRow {
////    var todayIcon;
////    var leftArrow;
////    var rightArrow;
////
////    if (!widget.hideArrows) {
////      leftArrow = IconButton(
////        onPressed: isExpanded ? previousMonth : previousWeek,
////        icon: Icon(Icons.chevron_left),
////      );
////      rightArrow = IconButton(
////        onPressed: isExpanded ? nextMonth : nextWeek,
////        icon: Icon(Icons.chevron_right),
////      );
////    } else {
////      leftArrow = Container();
////      rightArrow = Container();
////    }
////
////    if (!widget.hideTodayIcon) {
////      todayIcon = InkWell(
////        child: Text('Сегодня'),
////        onTap: resetToToday,
////      );
////    } else {
////      todayIcon = Container();
////    }
////    print('displayMonth ================== $displayMonth');
////    return Row(
////      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////      children: [
////        leftArrow ?? Container(),
////        Column(
////          children: <Widget>[
////            todayIcon ?? Container(),
////            Text(
////              displayMonth,
////              style: TextStyle(
////                fontSize: 20.0,
////              ),
////            ),
////          ],
////        ),
////        rightArrow ?? Container(),
////      ],
////    );
////  }
////
////  Widget get calendarGridView {
////    return Container(
////      child: SimpleGestureDetector(
////        onSwipeUp: _onSwipeUp,
////        onSwipeDown: _onSwipeDown,
////        onSwipeLeft: _onSwipeLeft,
////        onSwipeRight: _onSwipeRight,
////        swipeConfig: SimpleSwipeConfig(
////          verticalThreshold: 10.0,
////          horizontalThreshold: 40.0,
////          swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
////        ),
////        child: Column(children: <Widget>[
////          GridView.count(
////            childAspectRatio: 1.5,
////            primary: false,
////            shrinkWrap: true,
////            crossAxisCount: 7,
////            padding: EdgeInsets.only(bottom: 0.0),
////            children: calendarBuilder(),
////          ),
////        ]),
////      ),
////    );
////  }
////
////  Widget get expansionButtonRow => SimpleGestureDetector(
////      onSwipeUp: _onSwipeUp,
////      onSwipeDown: _onSwipeDown,
////      swipeConfig: SimpleSwipeConfig(
////        verticalThreshold: 10.0,
////        swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
////      ),
////      child: GestureDetector(
////        onTap: toggleExpanded,
////        child: Container(
////          color: Colors.black12,
////          height: 40,
////          margin: EdgeInsets.only(top: 8.0),
////          padding: EdgeInsets.all(0),
////          child: Row(
////            mainAxisAlignment: MainAxisAlignment.spaceBetween,
////            children: <Widget>[
////              Padding(
////                padding: EdgeInsets.only(left: 20),
////                child: Text(
////                  Utils.fullDayFormat(selectedDate),
////                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
////                ),
////              ),
////              SizedBox(width: 40.0),
////              IconButton(
////                onPressed: toggleExpanded,
////                iconSize: 25.0,
////                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
////                icon: isExpanded
////                    ? Icon(
////                  Icons.arrow_drop_up,
////                  color: widget.bottomBarArrowColor ?? Colors.black,
////                )
////                    : Icon(
////                  Icons.arrow_drop_down,
////                  color: widget.bottomBarArrowColor ?? Colors.black,
////                ),
////              ),
////            ],
////          ),
////        ),
////      )
////  );
////
////  @override
////  Widget build(BuildContext context) {
////    return Container(
////      child: Column(
////        mainAxisAlignment: MainAxisAlignment.start,
////        mainAxisSize: MainAxisSize.min,
////        children: <Widget>[
////          nameAndIconRow,
////          ExpansionCrossFade(
////            collapsed: calendarGridView,
////            expanded: calendarGridView,
////            isExpanded: isExpanded,
////          ),
////          expansionButtonRow
////        ],
////      ),
////    );
////  }
////
////  void resetToToday() {
////    setState(() {
////      _selectedDate = DateTime.now();
////      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
////      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
////
////      selectedWeekDays =
////          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
////              .toList();
////      selectedMonthsDays = _daysInMonth(_selectedDate);
////      var monthFormat =
////      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
////      displayMonth =
////      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
////    });
////
////    _launchDateSelectionCallback(_selectedDate);
////  }
////
////  void nextMonth() {
////    setState(() {
////      print('displayMonth =============11============= $displayMonth');
////      _selectedDate = Utils.nextMonth(_selectedDate);
////
////      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
////      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
////
////      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
////
////      selectedMonthsDays = _daysInMonth(_selectedDate);
////
////      var monthFormat =
////      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
////
////      displayMonth =
////      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
////
////      print('displayMonth =============22============= $displayMonth');
////    });
////
////    _launchDateSelectionCallback(_selectedDate);
////  }
////
////  void previousMonth() {
////    setState(() {
////      _selectedDate = Utils.previousMonth(_selectedDate);
////      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
////      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
////      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
////      selectedMonthsDays = _daysInMonth(_selectedDate);
////      var monthFormat =
////      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
////      displayMonth =
////      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
////    });
////    _launchDateSelectionCallback(_selectedDate);
////  }
////
////  void nextWeek() {
////    setState(() {
////      _selectedDate = Utils.nextWeek(_selectedDate);
////      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
////      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
////      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
////      selectedWeekDays =
////          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
////              .toList();
////      var monthFormat =
////      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
////      displayMonth =
////      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
////    });
////    _launchDateSelectionCallback(_selectedDate);
////  }
////
////  void previousWeek() {
////    setState(() {
////      _selectedDate = Utils.previousWeek(_selectedDate);
////      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
////      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
////      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
////      selectedWeekDays =
////          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
////              .toList();
////      var monthFormat =
////      DateFormat("MMMM yyyy", widget.locale).format(_selectedDate);
////      displayMonth =
////      "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
////    });
////    _launchDateSelectionCallback(_selectedDate);
////  }
////
////  void updateSelectedRange(DateTime start, DateTime end) {
////    Range _rangeSelected = Range(start, end);
////    if (widget.onRangeSelected != null) {
////      widget.onRangeSelected(_rangeSelected);
////    }
////  }
////
////  void _onSwipeUp() {
////    if (isExpanded){
////      toggleExpanded();
////    }
////  }
////
////  void _onSwipeDown() {
////    if (!isExpanded) toggleExpanded();
////  }
////
////  void _onSwipeRight() {
////    if (isExpanded) {
////      previousMonth();
////    } else {
////      previousWeek();
////    }
////  }
////
////  void _onSwipeLeft() {
////    if (isExpanded) {
////      nextMonth();
////    } else {
////      nextWeek();
////    }
////  }
////
////  void toggleExpanded() {
////    if (widget.isExpandable) {
////      setState((){
////        selectedMonthsDays = _daysInMonth(_selectedDate);
////        isExpanded = !isExpanded;
////      });
////    }
////  }
////
////  void handleSelectedDateAndUserCallback(DateTime day) {
////    var firstDayOfCurrentWeek = _firstDayOfWeek(day);
////    var lastDayOfCurrentWeek = _lastDayOfWeek(day);
////
////    setState(() {
////      _selectedDate = day;
////      selectedWeekDays =
////          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
////              .toList();
////      selectedMonthsDays = _daysInMonth(day);
////
////      if (_selectedDate.month > day.month) {
////        previousMonth();
////      }
////      if (_selectedDate.month < day.month) {
////        nextMonth();
////      }
////    });
////    _launchDateSelectionCallback(day);
////  }
////
////  void _launchDateSelectionCallback(DateTime day) {
////    if (widget.onDateSelected != null) {
////      widget.onDateSelected(day);
////    }
////    if (widget.onMonthChanged != null) {
////      widget.onMonthChanged(day);
////    }
////  }
////
////  _firstDayOfWeek(DateTime date) {
////    var day = new DateTime.utc(date.year, date.month, date.day, 12);
////    return day.subtract(
////        new Duration(days: day.weekday - 1));
////  }
////
////  _lastDayOfWeek(DateTime date) {
////    return _firstDayOfWeek(date).add(new Duration(days: 7));
////  }
////
////  List<DateTime> _daysInMonth(DateTime selectedDay) {
////    var first = Utils.firstDayOfMonth(selectedDay);
////    var daysBefore = first.weekday;
////    var firstToDisplay = first
////        .subtract(new Duration(days: daysBefore - 1))
////        .subtract(new Duration(days: 0));
////
////
////    var last = Utils.lastDayOfMonth(selectedDay);
////
////    var daysAfter = 8 - last.weekday;
////
////    var lastToDisplay = last.add(new Duration(days: daysAfter));
////    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
////  }
////}
////
////class ExpansionCrossFade extends StatelessWidget {
////  final Widget collapsed;
////  final Widget expanded;
////  final bool isExpanded;
////
////  ExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});
////
////  @override
////  Widget build(BuildContext context) {
////    return Flexible(
////      flex: 1,
////      child: AnimatedCrossFade(
////        firstChild: collapsed,
////        secondChild: expanded,
////        firstCurve: const Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
////        secondCurve: const Interval(1.0, 1.0, curve: Curves.fastOutSlowIn),
////        sizeCurve: Curves.decelerate,
////        crossFadeState:
////        isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
////        duration: const Duration(milliseconds: 300),
////      ),
////    );
////  }
////}
////
////
////class CalendarTile extends StatelessWidget {
////  final VoidCallback onDateSelected;
////  final DateTime date;
////  final String dayOfWeek;
////  final bool isDayOfWeek;
////  final bool isSelected;
////  final bool isWeekend;
////  final bool inMonth;
////  final List events;
////  final TextStyle dayOfWeekStyle;
////  final TextStyle dateStyles;
////  final Widget child;
////  final Color selectedColor;
////  final Color todayColor;
////  final Color eventColor;
////  final Color eventDoneColor;
////
////  CalendarTile({
////    this.onDateSelected,
////    this.date,
////    this.child,
////    this.dateStyles,
////    this.dayOfWeek,
////    this.dayOfWeekStyle,
////    this.isDayOfWeek: false,
////    this.isSelected: false,
////    this.isWeekend: false,
////    this.inMonth: true,
////    this.events,
////    this.selectedColor,
////    this.todayColor,
////    this.eventColor,
////    this.eventDoneColor,
////  });
////
////  Widget renderDateOrDayOfWeek(BuildContext context) {
////    if (isDayOfWeek) {
////      return new InkWell(
////        child: new Container(
////          alignment: Alignment.center,
////          child: new Text(
////            dayOfWeek,
////            style: dayOfWeekStyle,
////          ),
////        ),
////      );
////    } else {
////      int eventCount = 0;
////      return InkWell(
////        onTap: onDateSelected,
////        child: Padding(
////          padding: const EdgeInsets.all(1.0),
////          child: Container(
////            decoration: isSelected
////                ? BoxDecoration(
////              shape: BoxShape.rectangle,
////              color: selectedColor != null
////                  ? Utils.isSameDay(this.date, DateTime.now())
////                  ? Colors.red
////                  : selectedColor
////                  : Theme.of(context).primaryColor,
////              borderRadius: BorderRadius.circular(10),
////            )
////                : BoxDecoration(),
////            alignment: Alignment.center,
////            child: Column(
////              mainAxisAlignment: MainAxisAlignment.center,
////              children: <Widget>[
////                Text(
////                  DateFormat("d").format(date),
////                  style: TextStyle(
////                      fontSize: 14.0,
////                      fontWeight: FontWeight.w400,
////                      color: !isWeekend ? isSelected
////                          ? Colors.red
////                          : Utils.isSameDay(this.date, DateTime.now())
////                          ? todayColor
////                          : inMonth ? Colors.black : Colors.grey[500] : Colors.grey[500]
////                  ),
////                ),
////                events != null && events.length > 0
////                    ? Row(
////                    mainAxisAlignment: MainAxisAlignment.center,
////                    children: events.map((event) {
////                      eventCount++;
////                      if (eventCount > 3) return Container();
////                      return Container(
////                        margin: EdgeInsets.only(
////                            left: 2.0, right: 2.0, top: 1.0),
////                        width: 5.0,
////                        height: 5.0,
////                        decoration: BoxDecoration(
////                          shape: BoxShape.circle,
////                          color: event["isDone"]
////                              ? eventDoneColor ??
////                              Theme.of(context).primaryColor
////                              : eventColor ?? Theme.of(context).accentColor,
////                        ),
////                      );
////                    }).toList())
////                    : Container(),
////              ],
////            ),
////          ),
////        ),
////      );
////    }
////  }
////
////  @override
////  Widget build(BuildContext context) {
////    if (child != null) {
////      return new InkWell(
////        child: child,
////        onTap: onDateSelected,
////      );
////    }
////    return new Container(
////      child: renderDateOrDayOfWeek(context),
////    );
////  }
////}
////
////class Utils {
////  static final DateFormat _monthFormat = new DateFormat("MMMM yyyy");
////  static final DateFormat _dayFormat = new DateFormat("dd");
////  static final DateFormat _firstDayFormat = new DateFormat("MMM dd");
//////  static final DateFormat _fullDayFormat = new DateFormat("EEE MMM dd, yyyy", 'ru');
////  static final DateFormat _fullDayFormat = new DateFormat("dd MMMM, EEEE", 'ru');
////  static final DateFormat _apiDayFormat = new DateFormat("yyyy-MM-dd");
////
////  static String formatMonth(DateTime d) => _monthFormat.format(d);
////  static String formatDay(DateTime d) => _dayFormat.format(d);
////  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);
////  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);
////  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);
////
////  static const List<String> weekdays = const [
////    "Sun",
////    "Mon",
////    "Tue",
////    "Wed",
////    "Thu",
////    "Fri",
////    "Sat"
////  ];
////
////  /// The list of days in a given month
////  static List<DateTime> daysInMonth(DateTime month) {
////    var first = firstDayOfMonth(month);
////    var daysBefore = first.weekday;
////    var firstToDisplay = first.subtract(new Duration(days: daysBefore));
////    var last = Utils.lastDayOfMonth(month);
////
////    var daysAfter = 7 - last.weekday;
////
////    // If the last day is sunday (7) the entire week must be rendered
////    if (daysAfter == 0) {
////      daysAfter = 7;
////    }
////
////    var lastToDisplay = last.add(new Duration(days: daysAfter));
////    return daysInRange(firstToDisplay, lastToDisplay).toList();
////  }
////
////  static bool isFirstDayOfMonth(DateTime day) {
////    return isSameDay(firstDayOfMonth(day), day);
////  }
////
////  static bool isLastDayOfMonth(DateTime day) {
////    return isSameDay(lastDayOfMonth(day), day);
////  }
////
////  static bool isWeekend(DateTime day) {
////    final dateFormat = new DateFormat("EEE", 'ru');
////    final result = dateFormat.format(day);
////    if(result == 'сб' || result == 'вс') return true;
////    else return false;
////  }
////
////  static DateTime firstDayOfMonth(DateTime month) {
////    return new DateTime(month.year, month.month);
////  }
////
////  static DateTime firstDayOfWeek(DateTime day) {
////    /// Handle Daylight Savings by setting hour to 12:00 Noon
////    /// rather than the default of Midnight
////    day = new DateTime.utc(day.year, day.month, day.day, 12);
////
////    /// Weekday is on a 1-7 scale Monday - Sunday,
////    /// This Calendar works from Sunday - Monday
////    var decreaseNum = day.weekday % 7;
////    return day.subtract(new Duration(days: decreaseNum));
////  }
////
////  static DateTime lastDayOfWeek(DateTime day) {
////    /// Handle Daylight Savings by setting hour to 12:00 Noon
////    /// rather than the default of Midnight
////    day = new DateTime.utc(day.year, day.month, day.day, 12);
////
////    /// Weekday is on a 1-7 scale Monday - Sunday,
////    /// This Calendar's Week starts on Sunday
////    var increaseNum = day.weekday % 7;
////    return day.add(new Duration(days: 7 - increaseNum));
////  }
////
////  /// The last day of a given month
////  static DateTime lastDayOfMonth(DateTime month) {
////    var beginningNextMonth = (month.month < 12)
////        ? new DateTime(month.year, month.month + 1, 1)
////        : new DateTime(month.year + 1, 1, 1);
////    return beginningNextMonth.subtract(new Duration(days: 1));
////  }
////
////  /// Returns a [DateTime] for each day the given range.
////  ///
////  /// [start] inclusive
////  /// [end] exclusive
////  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
////    var i = start;
////    var offset = start.timeZoneOffset;
////    while (i.isBefore(end)) {
////      yield i;
////      i = i.add(new Duration(days: 1));
////      var timeZoneDiff = i.timeZoneOffset - offset;
////      if (timeZoneDiff.inSeconds != 0) {
////        offset = i.timeZoneOffset;
////        i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
////      }
////    }
////  }
////
////  /// Whether or not two times are on the same day.
////  static bool isSameDay(DateTime a, DateTime b) {
////    return a.year == b.year && a.month == b.month && a.day == b.day;
////  }
////
////  static bool isSameWeek(DateTime a, DateTime b) {
////    /// Handle Daylight Savings by setting hour to 12:00 Noon
////    /// rather than the default of Midnight
////    a = new DateTime.utc(a.year, a.month, a.day);
////    b = new DateTime.utc(b.year, b.month, b.day);
////
////    var diff = a.toUtc().difference(b.toUtc()).inDays;
////    if (diff.abs() >= 7) {
////      return false;
////    }
////
////    var min = a.isBefore(b) ? a : b;
////    var max = a.isBefore(b) ? b : a;
////    var result = max.weekday % 7 - min.weekday % 7 >= 0;
////    return result;
////  }
////
////  static DateTime previousMonth(DateTime m) {
////    var year = m.year;
////    var month = m.month;
////    if (month == 1) {
////      year--;
////      month = 12;
////    } else {
////      month--;
////    }
////    return new DateTime(year, month);
////  }
////
////  static DateTime nextMonth(DateTime m) {
////    var year = m.year;
////    var month = m.month;
////
////    if (month == 12) {
////      year++;
////      month = 1;
////    } else {
////      month++;
////    }
////    return new DateTime(year, month);
////  }
////
////  static DateTime previousWeek(DateTime w) {
////    return w.subtract(new Duration(days: 7));
////  }
////
////  static DateTime nextWeek(DateTime w) {
////    return w.add(new Duration(days: 7));
////  }
////}