//import 'package:flutter/cupertino.dart';
//import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
//import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
//import 'package:stacked/stacked.dart';
//
//class BookingUsersItemViewModel extends BaseViewModel {
//  final BookingUsersModel bookingUsersModel;
//  final BookingBloc bloc;
//  final bool internal;
//  BookingUsersItemViewModel({@required this.bookingUsersModel, @required this.bloc, this.internal}){
//    if(internal != null){
//      BookingState currentState = bloc.state;
//      if(currentState is LoadedCurrentBookingsState){
////        if(internal) participantsNames = currentState.reservationParams.internalParticipantsNames;
////        else participantsNames = currentState.reservationParams.externalParticipantsNames;
//      }
//
//      participantsNames.forEach((BookingUsersModel model) {
//        if(model.key == bookingUsersModel.key){
//          isSelected = true;
//        }
//      });
//    }
//  }
//  List<BookingUsersModel> participantsNames = [];
//  bool isSelected = false;
//
//  void selected() {
//    if(isSelected){
//      if(internal) bloc.add(RemoveByNameInternalParticipant(model: bookingUsersModel));
//      else bloc.add(RemoveByNameExternalParticipant(model: bookingUsersModel));
//    } else {
//      if(internal) bloc.add(AddInternalParticipant(model: bookingUsersModel));
//      else bloc.add(AddExternalParticipant(model: bookingUsersModel));
//    }
//  }
//
//  void checkUserIsSelected({@required BookingUsersModel user, @required List<BookingUsersModel> models}) {
//    bool has = false;
//
//    models.forEach((BookingUsersModel _model) {
//      if(user.key == _model.key){
//        has = true;
//        return;
//      }
//    });
//
//    if(has) isSelected = true;
//    else isSelected = false;
//
//    notifyListeners();
//  }
//}