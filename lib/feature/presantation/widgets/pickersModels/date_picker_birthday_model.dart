import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerBirthdayModel extends CommonPickerModel {
  String digits(int value, int length) {
    return '${value + 1}'.padLeft(length, "0");
  }

  DatePickerBirthdayModel({DateTime currentTime, LocaleType locale}) : super(locale: locale) {
    this.currentTime = DateTime.now();
    this.setLeftIndex(this.currentTime.year);
    this.setMiddleIndex(this.currentTime.day);
    this.setRightIndex(this.currentTime.month);
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 31) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  final month = [
    'Января','Ферваля','Марта',
    'Апреля','Мая','Июня',
    'Июля','Августа','Сентября',
    'Октября','Ноября','Декабря'
  ];

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 12) {
      if(index < 12){
        return month[index];
      }
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  List<int> layoutProportions() {
    return [0, 1, 3];
  }

  @override
  DateTime finalTime() {
    print('YEAR === ${currentTime.year}');
    print('MONTH === ${currentTime.month}');
    print('DAY === ${currentTime.day}');

    return DateTime.utc(
      currentTime.year,
      1 + this.currentRightIndex(),
      1 + this.currentMiddleIndex(),
    );
  }
}