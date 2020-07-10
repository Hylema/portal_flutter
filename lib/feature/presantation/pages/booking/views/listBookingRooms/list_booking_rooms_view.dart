import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/singleton_blocs.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/shimmers/booking_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/listBookingRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/listBookingRooms/widgets/list_booking_rooms_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/shimmers/list_tile_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ListBookingRoomsView extends StatelessWidget {
  final getIt = GetIt.instance;
  BookingRoomsBloc bloc;

  ListBookingRoomsView(){
    final SingletonBlocs singletonBlocs = getIt<SingletonBlocs>();

    bloc = singletonBlocs.bookingBloc;
    bloc.data.bookingRoomsBloc = bloc;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: HeaderAppBar(
          titleWidget: StreamBuilder(
            stream: bloc.organisationName,
            builder: (context, AsyncSnapshot<String> snapshot) => Text('${snapshot.data}', style: TextStyle(color: Colors.black),),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)
                        )
                    ),
                    builder: (builder) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.remove,
                          size: 40,
                        ),
                        ListTile(
                          title: Text(METALLOINVEST, style: TextStyle(color: bloc.organisationName.value == METALLOINVEST ? Colors.red : Colors.black)),
                          onTap: () {
                            if(bloc.organisationName.value != METALLOINVEST) {
                              Navigator.of(context).pop();
                              return bloc.add(GetListRoomsEvent(organization: METALLOINVEST));
                            }
                          },
                          dense: true,
                        ),
                        ListTile(
                          title: Text(JSA, style: TextStyle(color: bloc.organisationName.value == JSA ? Colors.red : Colors.black)),
                          onTap: () {
                            if(bloc.organisationName.value != JSA) {
                              Navigator.of(context).pop();
                              return bloc.add(GetListRoomsEvent(organization: JSA));
                            }
                          },
                          dense: true,
                        ),
                        ListTile(
                          title: Text(OSKOL, style: TextStyle(color: bloc.organisationName.value == OSKOL ? Colors.red : Colors.black)),
                          onTap: () {
                            if(bloc.organisationName.value != OSKOL) {
                              Navigator.of(context).pop();
                              return bloc.add(GetListRoomsEvent(organization: OSKOL));
                            }
                          },
                          dense: true,
                        ),
                      ],
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icons/change.png',
                  )
              ),
            ),
          ],
        ),
        body: BlocConsumer<BookingRoomsBloc, BookingRoomsState>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            Widget currentViewOnPage = Container();

            if (state is LoadedBookingRoomsState) {
              currentViewOnPage = ListBookingRoomsWidget(
                  bookingRooms: state.bookingRooms,
                  organisation: bloc.organisationName.value
              );
            }

            if(state is LoadingBookingRoomsState) {
              currentViewOnPage = Container();
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: currentViewOnPage,
            );
          },
        )
    );
  }
}