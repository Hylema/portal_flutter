import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/convert_name.dart';

@immutable
class BookingParticipantItem extends StatelessWidget {
  final ReservationRoomBloc bloc;
  final bool internal;
  final BookingUsersModel model;
  BookingParticipantItem({
    @required this.bloc,
    @required this.internal,
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            dense: true,
            title: ConvertName(name: model.name),
            trailing: IconButton(
              icon: Icon(
                Icons.cancel,
                size: 14,
                color: Colors.grey[400],
              ),
              onPressed: () => internal
                  ? bloc.add(RemoveByNameInternalParticipant(model: model))
                  : bloc.add(RemoveByNameExternalParticipant(model: model)),
            )
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
}