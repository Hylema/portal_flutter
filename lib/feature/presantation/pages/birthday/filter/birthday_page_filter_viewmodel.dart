import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pickersModels/date_picker_birthday_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

BirthdayParams params;
BirthdayParams oldParams;

class BirthdayPageFilterViewModel extends BaseViewModel {
  BirthdayPageFilterViewModel({@required this.birthdayBloc, @required this.navigation}) {

    if(params == null) {
      params = new BirthdayParams(
          dayNumber: null,
          monthNumber: null,
          endDayNumber: null,
          endMonthNumber: null,
          searchString: '',
          startDayNumber: null,
          startMonthNumber: null,
          pageIndex: 1,
          pageSize: BIRTHDAY_PAGE_SIZE
      );

      _firstChange = true;
    } else {
      if(params.dayNumber != null && params.monthNumber != null)
        concreteDate.text = '${params.dayNumber} ${_month[params.monthNumber - 1]}';

      if(params.startDayNumber != null && params.startMonthNumber != null)
        periodFrom.text = '${params.startDayNumber} ${_month[params.startMonthNumber - 1]}';

      if(params.endDayNumber != null && params.endMonthNumber != null)
        periodBy.text = '${params.endDayNumber} ${_month[params.endMonthNumber - 1]}';

      if(params.searchString != null)
        fio.text = '${params.searchString}';

      oldParams = new BirthdayParams(
          dayNumber: params.dayNumber,
          monthNumber: params.monthNumber,
          endDayNumber: params.endDayNumber,
          endMonthNumber: params.endMonthNumber,
          searchString: params.searchString,
          startDayNumber: params.startDayNumber,
          startMonthNumber: params.startMonthNumber,
          pageIndex: 1,
          pageSize: BIRTHDAY_PAGE_SIZE
      );
    }
  }

  final BirthdayBloc birthdayBloc;
  final NavigatorState navigation;

  TextEditingController fio = TextEditingController();
  TextEditingController concreteDate = TextEditingController();
  TextEditingController periodFrom = TextEditingController();
  TextEditingController periodBy = TextEditingController();

  bool _firstChange = false;
  bool disable = true;
  bool disableConcreteData = false;
  bool disablePeriodFromBy = false;

  final _month = [
    'Января','Ферваля','Марта',
    'Апреля','Мая','Июня',
    'Июля','Августа','Сентября',
    'Октября','Ноября','Декабря'
  ];

  void concreteDatePicker(context) =>
      DatePicker.showPicker(
        context,
        showTitleActions: true,
//      minTime: DateTime(DateTime.now().year, 1, 1),
//      maxTime: DateTime(DateTime.now().year, 12, 31),
        onChanged: (date) {},
        onConfirm: (result) {
          print('Дата в итоге $result');
          String formatData = DateFormat('dd MM yyyy').format(result);
          params.monthNumber = int.parse(formatData.substring(3, 5));
          params.dayNumber = int.parse(formatData.substring(0, 2));
          //String year = formatData.substring(6, 10);

          concreteDate.text = '${params.dayNumber} ${_month[params.monthNumber - 1]}';
          updateFields();
        },
//      currentTime: DateTime.now(),
        locale: LocaleType.ru,
        pickerModel: DatePickerBirthdayModel(),
      );

  void fromDatePicker(context) =>
      DatePicker.showPicker(
        context,
        showTitleActions: true,
        onChanged: (date) {},
        onConfirm: (result) {
          print('Дата в итоге $result');
          String formatData = DateFormat('dd MM yyyy').format(result);
          params.startMonthNumber = int.parse(formatData.substring(3, 5));
          params.startDayNumber = int.parse(formatData.substring(0, 2));

          periodFrom.text = '${params.startDayNumber} ${_month[params.startMonthNumber - 1]}';
          updateFields();
        },
        locale: LocaleType.ru,
        pickerModel: DatePickerBirthdayModel(),
      );

  void byDatePicker(context) =>
      DatePicker.showPicker(
        context,
        showTitleActions: true,
        onChanged: (date) {},
        onConfirm: (result) {
          print('Дата в итоге $result');
          String formatData = DateFormat('dd MM yyyy').format(result);
          params.endMonthNumber = int.parse(formatData.substring(3, 5));
          params.endDayNumber = int.parse(formatData.substring(0, 2));

          periodBy.text = '${params.endDayNumber} ${_month[params.endMonthNumber - 1]}';
          updateFields();
        },
        locale: LocaleType.ru,
        pickerModel: DatePickerBirthdayModel(),
      );

  void updateFields(){
    if(_firstChange){
      if(fio.text != '' || concreteDate.text != '' || periodFrom.text != '' || periodBy.text != '')
        disable = false;
      else disable = true;
    } else {
      if(params == oldParams) disable = true;
      else disable = false;
    }

    if(concreteDate.text != ''){
      disablePeriodFromBy = true;
    }

    if(periodFrom.text != '' || periodBy.text != ''){
      disableConcreteData = true;
    }

    if(concreteDate.text == ''){
      disablePeriodFromBy = false;
    }

    if(periodFrom.text == '' && periodBy.text == ''){
      disableConcreteData = false;
    }

    notifyListeners();
  }

  void throwFilters() {
    fio.clear();
    concreteDate.clear();
    periodFrom.clear();
    periodBy.clear();
    params.clear();

    updateFields();
  }

  void throwFioFilter() {
    fio.clear();
    updateFields();
  }

  void throwConcreteDateFilter() {
    concreteDate.clear();
    params.dayNumber = null;
    params.monthNumber = null;
    updateFields();
  }

  void throwFromDateFilter() {
    periodFrom.clear();
    params.startDayNumber = null;
    params.startMonthNumber = null;
    updateFields();
  }

  void throwByDateFilter() {
    periodBy.clear();
    params.endDayNumber = null;
    params.endMonthNumber = null;
    updateFields();
  }

  void goBack() {
    params = oldParams;

    navigation.pop();
  }

  void applyFilter() {
    if(params.dataIsEmpty()){
      params.monthNumber = DateTime.now().month;
      params.dayNumber = DateTime.now().day;

      birthdayBloc.add(SetNewBirthdayFilter(
          params: params
      ));

      params = null;
    } else {
      birthdayBloc.add(SetNewBirthdayFilter(
          params: params
      ));
    }

    navigation.pop();
  }
}