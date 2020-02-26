import 'dart:async';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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

class BirthdayPageParametersState extends State<BirthdayPageParameters> {

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
    'Апрель','Май','Июнь',
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
        String monthNumber = formatData.substring(3, 5);
        String monthDay = formatData.substring(0, 2);
        String monthYear = formatData.substring(6, 10);
        date.text = '$monthDay ${month[int.parse(monthNumber) - 1]} $monthYear';
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
  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();

  bool disable = true;
  TextEditingController fio = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.black,),
            ),
            backgroundColor: Colors.white,
            title: Text('Параметры', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    _check(throwData: true);
                  });
                },
                child: Text('Сбросить', style: TextStyle(color: Colors.lightBlue, fontSize: 16),)
              ),
//              GestureDetector(
//                onTap: (){
//                  print('Сбросить');
//                },
//                child: Padding(
//                  padding: EdgeInsets.only(right: 15),
//                  child: Icon(Icons.close),
//                )
//              ),
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
                            children: <Widget>[
                              TextField(
                                controller: fio,
                                decoration: InputDecoration(
                                    labelText: "ФИО",
                                    suffixIcon: fio.text.length > 0
                                        ? IconButton(
                                      onPressed: () {
                                        fio.clear();
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
                                onChanged: (value) {
                                  _check();
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
                            ],
                          ),
                        ),
                        RoundedLoadingButton(
                          child: Text('Показать', style: TextStyle(color: Colors.white)),
                          controller: _btnController,
                          onPressed: () async {
                            await Future.delayed(Duration(seconds: 3), () async {
                              _btnController.success();
                            });
                            await Future.delayed(Duration(milliseconds: 1000), () {});
                            Navigator.of(context).pop();
                          },
                          color: disable
                              ? Color.fromRGBO(238, 0, 38, 0.48)
                              : Color.fromRGBO(238, 0, 38, 1),
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/6,
                  ),
                ])
            )
          ],
        ),
      ),
    );
  }
}