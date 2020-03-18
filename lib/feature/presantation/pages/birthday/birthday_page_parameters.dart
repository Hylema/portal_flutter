import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/parameters_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pickersModels/date_picker_birthday_model.dart';

import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

TextEditingController fio = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController periodFrom = TextEditingController();
TextEditingController periodBy = TextEditingController();

int _concreteDay;
int _concreteMonth;
int _startDayNumber;
int _endDayNumber;
int _startMonthNumber;
int _endMonthNumber;

class BirthdayPageParameters extends StatefulWidget {

  @override
  BirthdayPageParametersState createState() => BirthdayPageParametersState();
}

class BirthdayPageParametersState extends State<BirthdayPageParameters> {

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
    'Января','Ферваля','Марта',
    'Апреля','Мая','Июня',
    'Июля','Августа','Сентября',
    'Октября','Ноября','Декабря'
  ];

  _datePicker(context){
//    DatePicker.showPicker(
//      context,
//      showTitleActions: true,
////      minTime: DateTime(DateTime.now().year, 1, 1),
////      maxTime: DateTime(DateTime.now().year, 12, 31),
//      onChanged: (date) {},
//      onConfirm: (result) {
//        print('Дата в итоге $result');
//        String formatData = DateFormat('dd MM yyyy').format(result);
//        _concreteMonth = int.parse(formatData.substring(3, 5));
//        _concreteDay = int.parse(formatData.substring(0, 2));
//        //String year = formatData.substring(6, 10);
//        date.text = '$_concreteDay ${month[_concreteMonth - 1]}';
//      },
////      currentTime: DateTime.now(),
//      locale: LocaleType.ru,
//      pickerModel: DatePickerBirthdayModel(),
//    );
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
          _datePicker(context);
        },
        decoration: InputDecoration(
            labelText: "Дата",
            suffixIcon: date.text.length > 0
                ? IconButton(
              onPressed: () {
                date.clear();
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
//            dispatchSetFilterBirthday(
//                fio: null,
//                startDayNumber: _concreteDay,
//                endDayNumber: _concreteDay,
//                startMonthNumber: _concreteMonth,
//                endMonthNumber: _concreteMonth,
//                title: 'Конкретная дата: ${date.text}'
//            );
//          } else {
//            dispatchSetFilterBirthday(
//                fio: null,
//                startDayNumber: _startDayNumber,
//                endDayNumber: _endDayNumber,
//                startMonthNumber: _startMonthNumber,
//                endMonthNumber: _endMonthNumber,
//                title: ''
//            );
          }
        },
        throwData: () {
          fio.clear();
          date.clear();
          periodFrom.clear();
          periodBy.clear();
//          dispatchResetFilterBirthday();
        }
    );
  }
}
