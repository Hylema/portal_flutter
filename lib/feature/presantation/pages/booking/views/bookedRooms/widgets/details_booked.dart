import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/auth/current_user_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/current_booking_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/bookedRooms/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:timetable/timetable.dart';

class DetailsBooked extends StatelessWidget {
  final BasicEvent event;
  final CurrentBookingModel model;
  final CurrentBookedRoomBloc bloc;
  final getIt = GetIt.instance;

  DetailsBooked({
    this.event,
    this.model,
    this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    Storage storage = getIt<Storage>();
    CurrentUserModel currentUserModel = storage.currentUserModel;

    return Scaffold(
      appBar: HeaderAppBar(
        title: event.title,
        automaticallyImplyLeading: true,
        backgroundColor: event.color,
        actions: <Widget>[
          if (model.authorId == currentUserModel.id)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Удаление'),
                    content: Text('Вы действительно хотите удалить эту бронь?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Да'),
                        onPressed: () {
                          bloc.add(RemoveBookingEvent(id: model.id));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      ),
                      FlatButton(
                        child: Text('Нет'),
                        onPressed: Navigator.of(context).pop,
                      ),
                    ],
                  ),
                );
                //Navigator.pop(context, true);
              },
              tooltip: 'Удалить',
            )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  model.type['title'],
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Создатель встречи: ${model.initiator['title']}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Ответственный за встречу: ${model.responsible['title']}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Список участников: ',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ]),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return ListTile(
                  title: Text(model.participants[index]['title']),
                  dense: true,
                );
              }, childCount: model.participants.length)
          ),
        ],
      ),
    );
  }
}