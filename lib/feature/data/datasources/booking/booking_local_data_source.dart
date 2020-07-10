import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBookingLocalDataSource {
  List<CurrentBookingModel> getLastCurrentBookingRooms();
  Future<void> saveCurrentBookingRoomsToCache({@required List<CurrentBookingModel> models});
}

class BookingLocalDataSource implements IBookingLocalDataSource {
  final SharedPreferences sharedPreferences;
  final cachedName;

  BookingLocalDataSource({
    @required this.cachedName,
    @required this.sharedPreferences
  });

  @override
  List<CurrentBookingModel> getLastCurrentBookingRooms() {
    final jsonString = sharedPreferences.getString(cachedName);
    if(jsonString == null) return [];
    final List listRooms = json.decode(jsonString);

    return List<CurrentBookingModel>.from(listRooms.map((raw) => CurrentBookingModel.fromJson(raw)));
  }

  @override
  Future<void> saveCurrentBookingRoomsToCache({@required List<CurrentBookingModel> models}) {
    return sharedPreferences.setString(
      cachedName,
      json.encode(models),
    );
  }
}