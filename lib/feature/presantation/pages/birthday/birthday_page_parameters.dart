import 'dart:async';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pickersModels/date_picker_birthday_model.dart';

import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class BirthdayPageParameters extends StatefulWidget {

  @override
  BirthdayPageParametersState createState() => BirthdayPageParametersState();
}

TextEditingController _fio = TextEditingController();
TextEditingController _date = TextEditingController();
TextEditingController _periodFrom = TextEditingController();
TextEditingController _periodBy = TextEditingController();

int _concreteDay;
int _concreteMonth;
int _startDayNumber;
int _endDayNumber;
int _startMonthNumber;
int _endMonthNumber;

bool disable = true;
bool disableConcreteData = false;
bool disablePeriodFromBy = false;

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
    DatePicker.showPicker(
      context,
      showTitleActions: true,
//      minTime: DateTime(DateTime.now().year, 1, 1),
//      maxTime: DateTime(DateTime.now().year, 12, 31),
      onChanged: (date) {},
      onConfirm: (result) {
        print('Дата в итоге $result');
        String formatData = DateFormat('dd MM yyyy').format(result);
        _concreteMonth = int.parse(formatData.substring(3, 5));
        _concreteDay = int.parse(formatData.substring(0, 2));
        //String year = formatData.substring(6, 10);
        setState(() {
          _date.text = '$_concreteDay ${month[_concreteMonth - 1]}';
          _checkFields();
        });
      },
//      currentTime: DateTime.now(),
      locale: LocaleType.ru,
      pickerModel: DatePickerBirthdayModel(),
    );
  }
  _dateFromPicker(context){
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      onChanged: (date) {},
      onConfirm: (result) {
        print('Дата в итоге $result');
        String formatData = DateFormat('dd MM yyyy').format(result);
        _startMonthNumber = int.parse(formatData.substring(3, 5));
        _startDayNumber = int.parse(formatData.substring(0, 2));
        setState(() {
          _periodFrom.text = '$_startDayNumber ${month[_startMonthNumber - 1]}';
          _checkFields();
        });
      },
      locale: LocaleType.ru,
      pickerModel: DatePickerBirthdayModel(),
    );
  }
  _dateByPicker(context){
    DatePicker.showPicker(
      context,
      showTitleActions: true,
      onChanged: (date) {},
      onConfirm: (result) {
        print('Дата в итоге $result');
        String formatData = DateFormat('dd MM yyyy').format(result);
        _endMonthNumber = int.parse(formatData.substring(3, 5));
        _endDayNumber = int.parse(formatData.substring(0, 2));
        setState(() {
          _periodBy.text = '$_endDayNumber ${month[_endMonthNumber - 1]}';
          _checkFields();
        });
      },
      locale: LocaleType.ru,
      pickerModel: DatePickerBirthdayModel(),
    );
  }

  _checkFields(){
    if(_fio.text != '' || _date.text != '' || _periodFrom.text != '' || _periodBy.text != '')
      disable = false;
    else disable = true;

    if(_date.text != ''){
      disablePeriodFromBy = true;
    }

    if(_periodFrom.text != '' || _periodBy.text != ''){
      disableConcreteData = true;
    }

    if(_date.text == ''){
      disablePeriodFromBy = false;
    }

    if(_periodFrom.text == '' || _periodBy.text == ''){
      disableConcreteData = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          title: Text('Параметры', style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: [
            MaterialButton(
                onPressed: () {
                  setState(() {
                    _fio.clear();
                    _date.clear();
                    _periodFrom.clear();
                    _periodBy.clear();
                    _checkFields();
                  });

                  _concreteDay = null;
                  _concreteMonth = null;
                  _startDayNumber = null;
                  _endDayNumber = null;
                  _startMonthNumber = null;
                  _endMonthNumber = null;
                },
                child: Text('Сбросить', style: TextStyle(color: Colors.lightBlue, fontSize: 16),)
            ),
          ]
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextField(
                              controller: _fio,
                              decoration: InputDecoration(
                                  labelText: "ФИО",
                                  suffixIcon: _fio.text.length > 0
                                      ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _fio.clear();
                                        _checkFields();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 14,
                                      color: Colors.grey[400],
                                    ),
                                  )
                                      : null
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _checkFields();
                                });
                              },
                            ),
                            TextField(
                              enabled: !disableConcreteData,
                              controller: _date,
                              readOnly: true,
                              onTap: () {
                                _datePicker(context);
                              },
                              decoration: InputDecoration(
                                  labelText: "Дата",
                                  suffixIcon: _date.text.length > 0
                                      ? IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _date.clear();
                                        _concreteDay = null;
                                        _concreteMonth = null;
                                        _checkFields();
                                      });
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
                              enabled: !disablePeriodFromBy,
                              controller: _periodFrom,
                              readOnly: true,
                              onTap: () {
                                _dateFromPicker(context);
                              },
                              decoration: InputDecoration(
                                  labelText: "Период с",
                                  suffixIcon: _periodFrom.text.length > 0
                                      ? IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _periodFrom.clear();
                                        _startDayNumber = null;
                                        _startMonthNumber = null;
                                        _checkFields();
                                      });
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
                              enabled: !disablePeriodFromBy,
                              controller: _periodBy,
                              readOnly: true,
                              onTap: () {
                                _dateByPicker(context);
                              },
                              decoration: InputDecoration(
                                  labelText: "Период по",
                                  suffixIcon: _periodBy.text.length > 0
                                      ? IconButton(
                                    onPressed: (){
                                      setState(() {
                                        _periodBy.clear();
                                        _endDayNumber = null;
                                        _endMonthNumber = null;
                                        _checkFields();
                                      });
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
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        child: RoundedLoadingButton(
                          child: Text('Показать', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            int endDayNumber;
                            int endMonthNumber;
                            int startDayNumber;
                            int startMonthNumber;
                            String title;

                            if(_concreteDay != null && _concreteMonth != null){
                              startDayNumber = _concreteDay;
                              endDayNumber = _concreteDay;

                              startMonthNumber = _concreteMonth;
                              endMonthNumber = _concreteMonth;

                              title = 'Конкретная дата: ${_date.text}';
                            }

                            if(_startDayNumber != null && _startMonthNumber != null){
                              startDayNumber = _startDayNumber;
                              startMonthNumber = _startMonthNumber;

                              title = 'Поиск с ${_periodFrom.text}:';
                            }

                            if(_endDayNumber != null && _endMonthNumber != null){
                              endDayNumber = _endDayNumber;
                              endMonthNumber = _endMonthNumber;

                              title = 'Поиск по ${_periodBy.text}:';
                            }

                            if(_startDayNumber != null && _startMonthNumber != null && _endDayNumber != null && _endMonthNumber != null){
                              title = 'Поиск c ${_periodFrom.text} по ${_periodBy.text}:';
                            }

                            if(_fio.text != ''){
                              title = 'Результат поиска:';
                            }

                            if(_startDayNumber == null && _startMonthNumber == null && _endDayNumber == null && _endMonthNumber == null && _concreteDay == null && _concreteMonth == null && _fio.text == ''){
                              BlocProvider.of<BirthdayBloc>(context).add(ResetFilterBirthdayEvent());
                            } else {
                              BlocProvider.of<BirthdayBloc>(context).add(SetFilterBirthdayEvent(
                                title: title,
                                endDayNumber: endDayNumber,
                                endMonthNumber: endMonthNumber,
                                fio: _fio.text,
                                startDayNumber: startDayNumber,
                                startMonthNumber: startMonthNumber,
                              ));
                            }

                            Navigator.of(context).pop();
                          },
                          color: disable
                              ? Color.fromRGBO(238, 0, 38, 0.48)
                              : Color.fromRGBO(238, 0, 38, 1),
                        ),
                        duration: Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/6,
                ),
              ])
          )
        ],
      ),
    );
  }
}
