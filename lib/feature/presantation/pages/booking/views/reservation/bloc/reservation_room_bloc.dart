import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_user_id_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:flutter_architecture_project/feature/data/repositories/booking/booking_repository.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/booking_bloc_data.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/models/reservation_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/booking_add_user_model_sheet.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:async/async.dart';

class ReservationRoomBloc extends Bloc<ReservationRoomEvent, ReservationRoomState> with BookingAddUserModelSheet {
  final BookingRepository repository;
  final Storage storage;
  final BookingBlocsData data;
  final ReservationModel model;
  ReservationRoomBloc({
    @required this.repository,
    @required this.storage,
    @required this.data,
    @required this.model,
  }){
    reservationParams = data.reservationParams;
    currentBookingParams = data.currentBookingParams;

    final CurrentUserModel currentUser = storage.currentUserModel;
    reservationParams.initiatorId = currentUser.id;
    reservationParams.responsibleId = currentUser.id;

    _modelController = new BehaviorSubject<ReservationModel>.seeded(model);

    model.externalParticipants = reservationParams.externalParticipants.length > 0
        ? reservationParams.externalParticipants : [];
    model.internalParticipants = reservationParams.internalParticipants.length > 0
        ? reservationParams.internalParticipants : [];

    model.equipment.text = (
        (reservationParams.projector == true ? 'Проектор': '') +
            (
                reservationParams.projector == true
                    ? reservationParams.videoStaff == true
                    ? ', Конференц-связь' : ''
                    :  reservationParams.videoStaff == true
                    ? 'Конференц-связь'
                    : ''
            )
    );

    DateTime time = DateTime.parse(currentBookingParams.date);
    model.date.text = DateFormat('dd MMMM yyyy г.').format(time);

    model.meetingRoom.text = reservationParams.roomTitle;
    model.responsible.text = reservationParams.responsibleName ?? currentUser.name;
    model.timeStart.text = reservationParams.startDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(reservationParams.startDate)) : '';
    model.timeEnd.text = reservationParams.endDate != null
        ? DateFormat('HH:mm').format(DateTime.parse(reservationParams.endDate)) : '';
    model.meetingTopic.text = reservationParams.title ?? '';
    model.meetingType.text = reservationParams.meetingTypeText ?? '';

    model.currentStartTime = reservationParams.startDate != null
        ? DateTime.parse(reservationParams.startDate) : DateTime.now();
    model.currentEndTime = reservationParams.endDate != null
        ? DateTime.parse(reservationParams.endDate) : DateTime.now();

    check();
  }

  BehaviorSubject<ReservationModel> _modelController;
  ValueStream<ReservationModel> get modelStream => _modelController.stream;

  ReservationParams reservationParams;
  CurrentBookingParams currentBookingParams;

  void onPressed() {
    add(CreateBookingEvent());
//    navigator.pop();
  }

  void checkParticipants(){
    model.externalParticipants = reservationParams.externalParticipantsNames.length > 0
        ? reservationParams.externalParticipantsNames : [];
    model.internalParticipants = reservationParams.internalParticipantsNames.length > 0
        ? reservationParams.internalParticipantsNames : [];

    check();
  }

  void check() {
    if(reservationParams.isReady()) model.disable = false;
    else model.disable = true;

    _modelController.add(model);
  }

  void onChangedMeetingTitle(String value) {
    if(value.length >= 6) {
      reservationParams.title = value;
      model.meetingTitleValidation = true;
    }
    else if(value.length == 0 ) model.meetingTitleValidation = true;
    else model.meetingTitleValidation = false;

    check();
  }
  void throwMeetingTopic() {
    model.meetingTopic.text = '';
    reservationParams.meetingType = null;
    model.meetingTitleValidation = true;

    check();
  }

  void throwTimeStart() {
    model.timeStart.text = '';
    reservationParams.startDate = null;
    model.currentStartTime = DateTime.now();

    check();
  }

  void throwTimeEnd() {
    model.timeEnd.text = '';
    reservationParams.endDate = null;
    model.currentEndTime = DateTime.now();

    check();
  }

  void throwResponsible() {
    model.responsible.text = '';
    reservationParams.responsibleId = null;

    check();
  }

  void throwMeetingType() {
    model.meetingType.text = '';
    reservationParams.meetingTypeId = null;

    check();
  }

  void startTimePicker(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      showSecondsColumn: false,
      onChanged: (date) {},
      currentTime: model.currentStartTime,
      onConfirm: (result) {
        model.currentStartTime = result;
        model.timeStart.text = DateFormat('HH:mm').format(result);
        reservationParams.startDate =
            currentBookingParams.date + 'T' + DateFormat('HH:mm:').format(result) + '00Z';

        check();
      },
      locale: LocaleType.ru,
    );
  }

  void showModal(BuildContext context){
    showModalSheet(context: context, isSolo: true, title: 'Выбрать ответственного');
  }

  void endTimePicker(BuildContext context) {
//    return await Navigator.push(
//        context,
//        new DatePickerRoute(
//            showTitleActions: showTitleActions,
//            onChanged: onChanged,
//            onConfirm: onConfirm,
//            onCancel: onCancel,
//            locale: locale,
//            theme: theme,
//            barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//            pickerModel: TimePickerModel(
//                currentTime: currentTime, locale: locale, showSecondsColumn: showSecondsColumn)));

    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      showSecondsColumn: false,
      onChanged: (date) {},
      currentTime: model.currentEndTime,
      onConfirm: (DateTime result) {
        model.currentEndTime = result;
        model.timeEnd.text = DateFormat('HH:mm').format(result);
        reservationParams.endDate =
            currentBookingParams.date + 'T' + DateFormat('HH:mm:').format(result) + '00Z';

        check();
      },
      locale: LocaleType.ru,
    );
  }

  void meetingTypePicker(BuildContext context) =>
      Picker(
          adapter: PickerDataAdapter<String>(pickerdata: reservationParams.meetingType.map((MeetingTypeModel meetingTypeModel) => meetingTypeModel.title).toList()),
          cancelText: 'Отмена',
          cancelTextStyle: TextStyle(color: Colors.grey, fontSize: 16),
          confirmText: 'Готово',
          confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
          magnification: 1.0,
          diameterRatio: 1.6,
          squeeze: 1.0,
          itemExtent: 30.0,
          headerDecoration: BoxDecoration(
              color: Colors.white
          ),
          changeToFirst: true,
          textAlign: TextAlign.left,
          columnPadding: const EdgeInsets.all(8.0),
          onConfirm: (Picker picker, List<int> value) {
            model.meetingType.text = picker.getSelectedValues()[0].toString();
            reservationParams.meetingTypeText = model.meetingType.text;
            reservationParams.meetingTypeId = (value[0] + 1).toString();
            check();
          }
      ).showModal(context);

  @override
  ReservationRoomState get initialState => InitialReservationRoomState();

//  @override
//  void onError(Object error, StackTrace stacktrace){
//    print('data.reservationParams.internalParticipants ===============fffffffffffff=========== ${error}');
//    data.currentBookedRoomBloc.add(GetCurrentBookingsEvent());
//  }

  @override
  Stream<ReservationRoomState> mapEventToState(ReservationRoomEvent event) async* {
    if(event is CreateBookingEvent) yield* _createBooking(event);
    if(event is RemoveByNameInternalParticipant) yield* _removeByNameInternalParticipant(event);
    if(event is RemoveByNameExternalParticipant) yield* _removeByNameExternalParticipant(event);
    if(event is AddInternalParticipant) yield* _addInternalParticipant(event);
    if(event is AddExternalParticipant) yield* _addExternalParticipant(event);
    if(event is SelectResponsibleUser) yield* _getSelectResponsibleUser(event);
  }

  Stream<ReservationRoomState> _getSelectResponsibleUser(SelectResponsibleUser event) async* {
    BookingUserIdModel repositoryResult = await repository.getUserByLogonName(logonName: event.model.key);
    data.reservationParams.responsibleId = repositoryResult.id;
    data.reservationParams.responsibleName = event.model.name;

    model.responsible.text = event.model.name;

    check();
  }

  Stream<ReservationRoomState> _createBooking(CreateBookingEvent event) async* {
    final currentState = state;
    yield LoadingReservationRoomState();

    reservationParams.organization = currentBookingParams.organization;

    if(await repository.createBooking(
      reservationParams: reservationParams,
    )){
      data.currentBookedRoomBloc.add(GetCurrentBookingsEvent());
    } else yield currentState;
  }

  Stream<ReservationRoomState> _addInternalParticipant(AddInternalParticipant event) async* {
    if(!data.reservationParams.internalParticipantsNames.contains(event.model)) {
      data.reservationParams.internalParticipantsNames.add(event.model);
      BookingUserIdModel repositoryResult = await repository.getUserByLogonName(logonName: event.model.key);
      data.reservationParams.internalParticipants.add(repositoryResult.id);
    }

    checkParticipants();
  }

  Stream<ReservationRoomState> _addExternalParticipant(AddExternalParticipant event) async* {
    if(!data.reservationParams.externalParticipantsNames.contains(event.model)) {
      data.reservationParams.externalParticipantsNames.add(event.model);
      BookingUserIdModel repositoryResult = await repository.getUserByLogonName(logonName: event.model.key);

      data.reservationParams.externalParticipants.add(repositoryResult.id);
    }

    checkParticipants();
  }

  Stream<ReservationRoomState> _removeByNameInternalParticipant(RemoveByNameInternalParticipant event) async* {
    data.reservationParams.internalParticipantsNames.asMap().forEach((int _index, BookingUsersModel _model) {
      if(_model.key == event.model.key) data.reservationParams.internalParticipants.removeAt(_index);
    });
    data.reservationParams.internalParticipantsNames.removeWhere((BookingUsersModel _model) => _model.key == event.model.key);

    checkParticipants();
  }

  Stream<ReservationRoomState> _removeByNameExternalParticipant(RemoveByNameExternalParticipant event) async* {
    data.reservationParams.externalParticipantsNames.asMap().forEach((int _index, BookingUsersModel _model) {
      if(_model.key == event.model.key) data.reservationParams.externalParticipants.removeAt(_index);
    });
    data.reservationParams.externalParticipantsNames.removeWhere((BookingUsersModel _model) => _model.key == event.model.key);

    checkParticipants();
  }

}
