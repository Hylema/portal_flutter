import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/searchUsers/models/booking_search_model.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/search_widget.dart';
import 'package:stacked/stacked.dart';

class BookingRemoteSearchUsers extends StatelessWidget {
  final UsersBookingBloc bloc;
  BookingRemoteSearchUsers({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BookingSearchModel>(
        initialData: BookingSearchModel(),
        stream: bloc.modelStream,
        builder: (context, AsyncSnapshot<BookingSearchModel> snapshot) {
          final BookingSearchModel model = snapshot.data;

          return SearchWidget(
              textEditingController: model.textEditingController,
              focusNode: model.focusNode,
              onChanged: bloc.onChanged,
              clearSearch: bloc.clearSearch
          );
        }
    );
  }
}