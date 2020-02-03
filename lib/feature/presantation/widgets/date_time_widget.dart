import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {

  DateTimeWidget({
    this.dataTime,
    this.color,
    this.dateTimeSize = 11
  }){
//    assert(dataTime != null);
  }

  final dataTime;
  final Color color;
  final double dateTimeSize;

  @override
  DateTimeWidgetState createState() => DateTimeWidgetState();
}

class DateTimeWidgetState extends State<DateTimeWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          date(widget.dataTime) + '  ',
          style: TextStyle(
            color: widget.color,
            fontSize: widget.dateTimeSize,
          ),
        ),
        Icon(
          Icons.brightness_1,
          color: widget.color,
          size: widget.dateTimeSize / 2,
        ),
        Text(
          '  ' + time(widget.dataTime),
          style: TextStyle(
            color: widget.color,
            fontSize: widget.dateTimeSize,
          ),
        ),
      ],
    );
  }
}

String time(String dateStr){
  String time = dateStr.substring(11, 16);

  return time;
}

String date(String dateStr){
  String date = dateStr.substring(0, 10);

  String dataCreated = DateFormat('dd.MM.yyyy').format(DateTime.parse(date));

  int monthNow = int.parse(
      DateTime.now()
          .toString()
          .substring(5, 7)
  );

  int dayNow = int.parse(DateTime.now()
      .toString()
      .substring(8, 10)
  );

  int yearNow = int.parse(DateTime.now()
      .toString()
      .substring(0, 4)
  );

  int dataCreatedDay = int.parse(dataCreated.substring(0, 2));
  int dataCreatedMonth = int.parse(dataCreated.substring(3, 5));
  int dataCreatedYear = int.parse(dataCreated.substring(6, 10));

//    print('Месяц сейчас - $monthNow');
//    print('День сейчас - $dayNow');
//    print('Год сейчас - $yearNow');
//    print('************************************');
//    print('Месяц cоздания - $dataCreatedMonth');
//    print('День cоздания - $dataCreatedDay');
//    print('Год cоздания - $dataCreatedYear');


  if(dataCreatedYear == yearNow){
    if(dataCreatedMonth == monthNow){
      if(dataCreatedDay == dayNow){
        return 'Сегодня';
      }
    }

    if(dataCreatedMonth == monthNow){
      if((dataCreatedDay + 1) == dayNow){
        return 'Вчера';
      }
    }
  }

  return dataCreated;
}