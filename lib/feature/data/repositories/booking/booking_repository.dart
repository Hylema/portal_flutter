import 'package:flutter_architecture_project/feature/data/datasources/booking/booking_local_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/booking/booking_remote_data_source.dart';
import 'package:flutter_architecture_project/feature/data/datasources/main/main_params_json_data_source.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_user_id_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/booking_rooms_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/remove_booking_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/reservation_params.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/search_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/main/main_params_repository_interface.dart';

import 'package:meta/meta.dart';

class BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final BookingLocalDataSource localDataSource;

  BookingRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  Future<List<BookingRoomsModel>> fetchBookingRooms({
    @required BookingRoomsParams params,
  }) async => await remoteDataSource.getBookingRooms(bookingRoomsParams: params);

  Future<List<BookingUsersModel>> searchUsers({
    @required SearchParams params,
  }) async => await remoteDataSource.searchUsers(searchParams: params);

  Future<BookingUserIdModel> getUserByLogonName({
    @required String logonName,
  }) async => await remoteDataSource.getUserByLogonName(logonName: logonName);

  Future<bool> createBooking({
    @required ReservationParams reservationParams,
  }) async => await remoteDataSource.createBooking(reservationParams: reservationParams);

  Future<bool> removeBooking({
    @required RemoveBookingParams removeBookingParams,
  }) async => await remoteDataSource.removeBooking(removeBookingParams: removeBookingParams);

  Future<List<MeetingTypeModel>> getMeetingTypes({
    @required String organisation,
  }) async => await remoteDataSource.getMeetingTypes(organisation: organisation);

  Future<List<CurrentBookingModel>> fetchCurrentBookings({
    @required CurrentBookingParams currentBookingParams,
  }) async {
    List<CurrentBookingModel> repositoryResult = await remoteDataSource.getCurrentBooking(currentBookingParams: currentBookingParams);
    List<CurrentBookingModel> sortedBookingsModel = [];

    repositoryResult.forEach((CurrentBookingModel model) {
      if(model.room['id'] == currentBookingParams.roomId) sortedBookingsModel.add(model);
    });

    localDataSource.saveCurrentBookingRoomsToCache(models: sortedBookingsModel);

    return sortedBookingsModel;
  }

  List<CurrentBookingModel> getLastCurrentBookingRooms() => localDataSource.getLastCurrentBookingRooms();
}