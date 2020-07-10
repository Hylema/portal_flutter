import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';

class BookingUserSearchModel {
  bool isSelected;
  bool internal;
  BookingUsersModel user;

  BookingUserSearchModel({this.isSelected = false, this.internal = false, this.user});
}