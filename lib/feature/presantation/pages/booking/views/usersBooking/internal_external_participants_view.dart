import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/models/reservation_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/booking_add_user_model_sheet.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/usersBooking/widgets/booking_participant_item.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/shimmers/list_tile_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class InternalExternalParticipantsView extends StatelessWidget with BookingAddUserModelSheet{
  final String title;
  final ReservationRoomBloc bloc;
  final bool internal;
  InternalExternalParticipantsView({
    @required this.title,
    @required this.bloc,
    @required this.internal
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: HeaderAppBar(
          automaticallyImplyLeading: true,
          title: title,
          backButtonColor: Colors.black,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: () => showModalSheet(
                      context: context,
                      title: 'Добавить Участника',
                      internal: internal
                  ),
                  icon: Icon(Icons.add)
              ),
            ),
          ],
        ),
      body: StreamBuilder<ReservationModel>(
          initialData: ReservationModel(),
          stream: bloc.modelStream,
          builder: (context, AsyncSnapshot<ReservationModel> snapshot) {
            final ReservationModel model = snapshot.data;
            List<BookingUsersModel> participantsNames;
            if(internal) participantsNames = bloc.data.reservationParams.internalParticipantsNames;
            else participantsNames = bloc.data.reservationParams.externalParticipantsNames;

            return CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                    return BookingParticipantItem(
                      model: participantsNames[index],
                      bloc: bloc,
                      internal: internal,
                    );
                  },
                      childCount: participantsNames.length
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
