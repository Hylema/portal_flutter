import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class CurrentBookingParams extends Params{
  String organization;
  String date;
  String roomTitle;
  int roomId;

  CurrentBookingParams({
    this.organization,
    this.date,
    this.roomId,
    this.roomTitle,
  });

  @override
  List get props => [
    organization, date, roomId, roomTitle
  ];

  Map get urlProps => {
    'organization': organization,
    'date': date,
  };
}