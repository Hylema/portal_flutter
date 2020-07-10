import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_rooms_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/models/booking_search_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/models/booking_user_search_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/widgets/userItem/bloc/bloc.dart';

import 'package:flutter_architecture_project/feature/presantation/pages/booking/widgets/BookingUserItem/booking_users_Item_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class BookingUsersItem extends StatelessWidget {
  final getIt = GetIt.instance;
  final BookingUsersModel bookingUsersModel;
  final bool isSolo;
  final bool internal;
  BookingUsersItem({
    @required this.bookingUsersModel,
    this.isSolo,
    this.internal
  }) {
    bloc = getIt<BookingUserItemBloc>();
  }

  BookingUserItemBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc.init(
        user: bookingUsersModel,
        internal: internal
    );

    return StreamBuilder<BookingUserSearchModel>(
        initialData: BookingUserSearchModel(),
        stream: bloc.modelStream,
        builder: (context, AsyncSnapshot<BookingUserSearchModel> snapshot) {
          final BookingUserSearchModel model = snapshot.data;

          return Column(
            children: <Widget>[
              ListTile(
                title: Text(bookingUsersModel.name),
                subtitle: Text(bookingUsersModel.position),
                dense: true,
                selected: model.isSelected,
                onTap: () {
                  if(isSolo){
                    bloc.data.reservationRoomBloc.add(SelectResponsibleUser(model: bookingUsersModel));
                    Navigator.of(context).pop();
                  } else bloc.onSelected();
                },
                trailing: !isSolo ? IconButton(
                  icon: model.isSelected
                      ? Icon(Icons.check_circle, color: Colors.blue)
                      : Icon(Icons.panorama_fish_eye, color: Colors.grey),
                  onPressed: bloc.onSelected,
                ) : null,
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 0.8,
                      color: Colors.grey[400],
                    ))
                ),
              ),
            ],
          );
        }
    );
  }
}
