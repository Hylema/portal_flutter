import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/widgets/search/remote/booking_remote_search_users.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/widgets/userItem/booking_users_Item.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/search_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/shimmers/list_tile_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

mixin BookingAddUserModelSheet {
  void showModalSheet({
    @required BuildContext context,
    bool isSolo = false,
    @required String title,
    bool internal,
  }) {
    final getIt = GetIt.instance;
    UsersBookingBloc bloc = getIt<UsersBookingBloc>();
    bloc.data.usersBookingBloc = bloc;

    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0)
            ),
        ),
        builder: (builder) => Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 100
          ),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: Colors.grey[300]))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      iconSize: 18,
                      onPressed: Navigator.of(context).pop,
                    ),
                    Center(
                      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Container()
                  ],
                ),
              ),
              BookingRemoteSearchUsers(bloc: bloc),
              Expanded(
                child: BlocConsumer<UsersBookingBloc, UsersBookingState>(
                  bloc: bloc,
                  builder: (context, state) {
                    Widget currentViewOnPage = Container();

                    if(state is LoadingUsersBookingState) currentViewOnPage = ListTileShimmer(
                      trailing: Icon(Icons.panorama_fish_eye),
                    );
                    if(state is LoadedUsersBookingState) currentViewOnPage = CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate((BuildContext context, index){
                            return BookingUsersItem(
                              bookingUsersModel: state.models[index],
                              isSolo: isSolo,
                              internal: internal,
                            );
                          },
                              childCount: state.models.length
                          ),
                        ),
                      ],
                    );

                    return AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: currentViewOnPage,
                    );
                  },
                  listener: (context, state) {},
                ),
              )
            ],
          ),
        )
    );
  }
}