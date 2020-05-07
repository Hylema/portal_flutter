import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/domain/params/params.dart';

class BirthdayParams extends Params{
  int pageIndex;
  int pageSize;
  int startDayNumber;
  int endDayNumber;
  int startMonthNumber;
  int endMonthNumber;
  String searchString;

  BirthdayParams({
    @required this.pageIndex,
    @required this.pageSize,
    @required this.startDayNumber,
    @required this.endDayNumber,
    @required this.startMonthNumber,
    @required this.endMonthNumber,
    @required this.searchString,
  });

  Map toMap(){
    return createParams(map: {
      'pageIndex': pageIndex,
      'pageSize': pageSize,
      'startDayNumber': startDayNumber,
      'endDayNumber': endDayNumber,
      'startMonthNumber': startMonthNumber,
      'endMonthNumber': endMonthNumber,
      'searchString': searchString,
    });
  }
}