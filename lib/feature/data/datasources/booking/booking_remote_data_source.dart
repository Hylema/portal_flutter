import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/api/api.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/data/datasources/response_handler.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_user_id_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/booking_rooms_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/remove_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/search_params.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:http/http.dart' as http;

abstract class IBookingRemoteDataSource {

  Future<List<BookingRoomsModel>> getBookingRooms({
    @required BookingRoomsParams bookingRoomsParams
  });

  Future<List<CurrentBookingModel>> getCurrentBooking({
    @required CurrentBookingParams currentBookingParams,
  });

  Future<List<MeetingTypeModel>> getMeetingTypes({
    @required String organisation,
  });

  Future<List<BookingUsersModel>> searchUsers({
    @required SearchParams searchParams,
  });

  Future<BookingUserIdModel> getUserByLogonName({
    @required String logonName,
  });

  Future<bool> createBooking({
    @required ReservationParams reservationParams,
  });

  Future<bool> removeBooking({
    @required RemoveBookingParams removeBookingParams,
  });
}

class BookingRemoteDataSource with ResponseHandler implements IBookingRemoteDataSource {
  Storage storage;
  final http.Client client;

  BookingRemoteDataSource({
    @required this.storage,
    @required this.client,
  });

  @override
  Future<List<BookingRoomsModel>> getBookingRooms({
    @required BookingRoomsParams bookingRoomsParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/reservations/rooms', bookingRoomsParams.toUrlParams()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<BookingRoomsModel>(response: response, model: BookingRoomsModel.fromJson, key: 'data');
  }

  @override
  Future<List<CurrentBookingModel>> getCurrentBooking({
    @required CurrentBookingParams currentBookingParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/reservations', currentBookingParams.toUrlParams()).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<CurrentBookingModel>(response: response, model: CurrentBookingModel.fromJson, key: 'data');
  }

  @override
  Future<List<MeetingTypeModel>> getMeetingTypes({
    @required String organisation,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/reservations/types', {
      'organisation': organisation
    }).toString();

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
    );

    return listModels<MeetingTypeModel>(response: response, model: MeetingTypeModel.fromJson, key: 'data');
  }

  @override
  Future<List<BookingUsersModel>> searchUsers({
    @required SearchParams searchParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/users').toString();

    final response = await http.post(
      uri,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
        'Authorization': 'Bearer ${storage.token}',
      },
      body: searchParams.toBodyParams()
    );

    return listModels<BookingUsersModel>(response: response, model: BookingUsersModel.fromJson, key: 'data');
  }


  @override
  Future<BookingUserIdModel> getUserByLogonName({
    @required String logonName,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/users/ensure').toString();

    final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': 'Bearer ${storage.token}',
        },
        body: jsonEncode({'logonName': logonName})
    );

    return model<BookingUserIdModel>(response: response, model: BookingUserIdModel.fromJson, key: 'data');
  }

  @override
  Future<bool> createBooking({
    @required ReservationParams reservationParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/reservations', reservationParams.toUrlParams()).toString();

    final response = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': 'Bearer ${storage.token}',
        },
        body: reservationParams.toBodyParams()
    );

    if(response.statusCode == 201) return true;
    else throw Exception('Не удалось создать бронь');
  }

  @override
  Future<bool> removeBooking({
    @required RemoveBookingParams removeBookingParams,
  }) async {
    String uri = Uri.http('${Api.HOST_URL}', '/api/reservations/${removeBookingParams.id}', removeBookingParams.toUrlParams()).toString();

    final response = await http.delete(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${storage.token}',
        },
    );

    if(response.statusCode == 204) return true;
    else throw Exception('Не удалось удалить бронь');
  }
}
