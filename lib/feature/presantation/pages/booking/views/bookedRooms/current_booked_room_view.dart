import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/params/booking/current_booking_params.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/shimmers/booking_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/widgets/booking_time_table.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/reservation_view.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pickersModels/date_picker_birthday_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CurrentBookedRoomView extends StatelessWidget {
  final CurrentBookedRoomBloc bloc;
  final String title;
  CurrentBookedRoomView({
    @required this.bloc,
    @required this.title,
  }){
    bloc.data.currentBookedRoomBloc = bloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderAppBar(
          title: title,
          automaticallyImplyLeading: true,
          backButtonColor: Colors.black,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationView())),
                  icon: Icon(Icons.calendar_today)
              ),
            ),
          ],
        ),
        body: BlocConsumer<CurrentBookedRoomBloc, CurrentBookedRoomState>(
          bloc: bloc,
          builder: (context, state) {
            Widget currentViewOnPage = BirthdayPageShimmer();
            if (state is LoadedCurrentBookedRoomState) {
              currentViewOnPage = BookingTimetable(
                  models: state.currentBookingModel,
                  bloc: bloc,
                  params: bloc.data.currentBookingParams
              );
            }

            if(state is LoadingCurrentBookedRoomState) {
              currentViewOnPage = BirthdayPageShimmer();
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: currentViewOnPage,
            );
          },
          listener: (context, state) {},
        )
    );
  }
}
