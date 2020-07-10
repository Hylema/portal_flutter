import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class BirthdayParams extends Params{
  int pageIndex;
  int dayNumber;
  int monthNumber;
  int pageSize;
  int startDayNumber;
  int endDayNumber;
  int startMonthNumber;
  int endMonthNumber;
  String searchString;

  BirthdayParams({
    @required this.dayNumber,
    @required this.monthNumber,
    @required this.pageIndex,
    @required this.pageSize,
    @required this.startDayNumber,
    @required this.endDayNumber,
    @required this.startMonthNumber,
    @required this.endMonthNumber,
    @required this.searchString,
  });

  @override
  List get props => [
    pageIndex, dayNumber, monthNumber,
    pageSize, startDayNumber, endDayNumber,
    startMonthNumber, endMonthNumber, searchString
  ];

  @override
  Map get urlProps =>   {
    'dayNumber': dayNumber,
    'monthNumber': monthNumber,
    'pageIndex': pageIndex,
    'pageSize': pageSize,
    'startDayNumber': startDayNumber,
    'endDayNumber': endDayNumber,
    'startMonthNumber': startMonthNumber,
    'endMonthNumber': endMonthNumber,
    'searchString': searchString,
  };

  bool dataIsEmpty() {
    if (monthNumber == null &&
        dayNumber == null &&
        startDayNumber == null &&
        endDayNumber == null &&
        startMonthNumber == null &&
        endMonthNumber == null &&
        searchString == ''
    )
      return true;
    else
      return false;
  }

  void clear() {
    monthNumber = null;
    dayNumber = null;
    startDayNumber = null;
    endDayNumber = null;
    startMonthNumber = null;
    endMonthNumber = null;
    searchString = '';
  }
}