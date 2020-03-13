import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/mixins/blocs_dispatches_events.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/parameters_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

TextEditingController fio = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController periodFrom = TextEditingController();
TextEditingController periodBy = TextEditingController();

String _concreteDay;
String _concreteMonth;
String _startDayNumber;
String _endDayNumber;
String _startMonthNumber;
String _endMonthNumber;

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '${value + 1}'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale}) : super(locale: locale) {
    this.currentTime = DateTime.now();
    this.setLeftIndex(this.currentTime.year);
    this.setMiddleIndex(this.currentTime.day);
    this.setRightIndex(this.currentTime.month);
  }

  final month = [
    'Января','Ферваля','Марта',
    'Апреля','Мая','Июня',
    'Июля','Августа','Сентября',
    'Октября','Ноября','Декабря'
  ];

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 31) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

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

class BirthdayPageParameters extends StatefulWidget {

  @override
  BirthdayPageParametersState createState() => BirthdayPageParametersState();
}

class BirthdayPageParametersState extends State<BirthdayPageParameters> with Dispatch {

  List<Widget> fields;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final month = [
    'Январь','Ферваль','Март',
    'Апреля','Май','Июнь',
    'Июль','Август','Сентябрь',
    'Октябрь','Ноябрь','Декабрь'
  ];

  _datePicker(context){
    DatePicker.showPicker(
      context,
      showTitleActions: true,
//      minTime: DateTime(DateTime.now().year, 1, 1),
//      maxTime: DateTime(DateTime.now().year, 12, 31),
      onChanged: (date) {},
      onConfirm: (result) {
        print('Дата в итоге $result');
        String formatData = DateFormat('dd MM yyyy').format(result);
        _concreteMonth = formatData.substring(3, 5);
        _concreteDay = formatData.substring(0, 2);
        //String year = formatData.substring(6, 10);
        date.text = '$_concreteDay ${month[int.parse(_concreteMonth) - 1]}';
        _check();
      },
//      currentTime: DateTime.now(),
      locale: LocaleType.ru,
      pickerModel: CustomPicker(),
    );
  }

  _check({bool throwData = false}){
    setState(() {
      if(throwData){
        fio.clear();
        date.clear();
      }

      if(fio.text != ''
      || date.text != '') disable = false;
      else disable = true;
    });
  }

  bool disable = true;

  @override
  Widget build(BuildContext context) {
    fields = [
      TextField(
        controller: fio,
        decoration: InputDecoration(
            labelText: "ФИО",
            suffixIcon: fio.text.length > 0
                ? IconButton(
              onPressed: () {
                fio.clear();
                //_check();
              },
              icon: Icon(
                Icons.cancel,
                size: 14,
                color: Colors.grey[400],
              ),
            )
                : null
        ),
        onSubmitted: (value) {
          print('value ============== $value');
          print('fio ============== $fio');
          print('fio.text ============== ${fio.text}');
          setState(() {});
        },
      ),
      TextField(
        controller: date,
        readOnly: true,
        onTap: () {
          print('Дата пикер');
          _datePicker(context);
        },
        decoration: InputDecoration(
            labelText: "Дата",
            suffixIcon: date.text.length > 0
                ? IconButton(
              onPressed: () {
                date.clear();
                _check();
              },
              icon: Icon(
                Icons.cancel,
                size: 14,
                color: Colors.grey[400],
              ),
            )
                : null
        ),
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "Период с"
        ),
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "Период по"
        ),
      ),
    ];

    return ParametersWidget(
        title: 'Параметры',
        textButton: 'Показать',
        fields: fields,
        show: () {
          if(date.text.length > 0){
            dispatchSetFilterBirthday(
                fio: fio.text,
                startDayNumber: _concreteDay,
                endDayNumber: _concreteDay,
                startMonthNumber: _concreteMonth,
                endMonthNumber: _concreteMonth,
                titleDate: 'Конкретная дата: ${date.text}'
            );
          } else {
            dispatchSetFilterBirthday(
              fio: fio.text,
              startDayNumber: _startDayNumber,
              endDayNumber: _endDayNumber,
              startMonthNumber: _startMonthNumber,
              endMonthNumber: _endMonthNumber,
                titleDate: ''
            );
          }
        },
        throwData: () {
          fio.clear();
          date.clear();
          periodFrom.clear();
          periodBy.clear();
          dispatchResetFilterBirthday();
        }
    );
  }
}
