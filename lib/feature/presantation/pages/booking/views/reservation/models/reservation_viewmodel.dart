import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';

class ReservationModel {
  TextEditingController date = TextEditingController();
  TextEditingController meetingRoom = TextEditingController();
  TextEditingController responsible = TextEditingController();
  TextEditingController timeStart = TextEditingController();
  TextEditingController timeEnd = TextEditingController();
  TextEditingController meetingTopic = TextEditingController();
  TextEditingController meetingType = TextEditingController();
  TextEditingController equipment = TextEditingController();
  bool disable;
  bool meetingTitleValidation;
  List<BookingUsersModel> externalParticipants = [];
  List<BookingUsersModel> internalParticipants = [];
  DateTime currentStartTime;
  DateTime currentEndTime;

  ReservationModel({
    this.disable = true,
    this.meetingTitleValidation = true,
  });

}