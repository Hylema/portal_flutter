import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/models/reservation_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/reservation/reservation_view_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/booking/views/usersBooking/internal_external_participants_view.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/fields_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class ReservationView extends StatelessWidget {
  final getIt = GetIt.instance;

  ReservationRoomBloc bloc;
  ReservationView(){
    bloc = getIt<ReservationRoomBloc>();
    bloc.data.reservationRoomBloc = bloc;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ReservationModel>(
      initialData: ReservationModel(),
      stream: bloc.modelStream,
      builder: (context, AsyncSnapshot<ReservationModel> snapshot) {
        final ReservationModel model = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            title: Text('Резервирование', style: TextStyle(color: Colors.black),),
            centerTitle: true,
          ),
          body: FieldsLayout(
            widgets: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15, right:  15),
                child: Column(
                  children: <Widget>[
                    TextField(
                      enabled: false,
                      controller: model.date,
                      decoration: InputDecoration(
                        labelText: "Дата",
                      ),
                    ),
                    TextField(
                      enabled: false,
                      controller: model.meetingRoom,
                      decoration: InputDecoration(
                        labelText: "Переговорная",
                      ),
                    ),
                    TextField(
                      enabled: false,
                      controller: model.equipment,
                      decoration: InputDecoration(
                        labelText: "Оборудование",
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      controller: model.responsible,
                      decoration: InputDecoration(
                          labelText: "Ответственный",
                          suffixIcon: model.responsible.text.length > 0
                              ? Icon(
                            Icons.cancel,
                            size: 14,
                            color: Colors.grey[400],
                          ) : null
                      ),
                      onTap: () => bloc.showModal(context),
                    ),
                    TextField(
                      controller: model.meetingTopic,
                      onChanged: bloc.onChangedMeetingTitle,
                      decoration: InputDecoration(
                          labelText: "Тема встречи",
                          errorText: !model.meetingTitleValidation ? 'Слишком короткое название' : null,
                          suffixIcon: model.meetingTopic.text.length > 0
                              ? IconButton(
                            onPressed: bloc.throwMeetingTopic,
                            icon: Icon(
                              Icons.cancel,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                          ) : null
                      ),
                    ),
                    TextField(
                      readOnly: true,
                      controller: model.meetingType,
                      decoration: InputDecoration(
                          labelText: "Тип встречи",
                          suffixIcon: model.meetingType.text.length > 0
                              ? IconButton(
                            onPressed: bloc.throwMeetingType,
                            icon: Icon(
                              Icons.cancel,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                          ) : null
                      ),
                      onTap: () => bloc.meetingTypePicker(context),

                    ),
                    TextField(
                      readOnly: true,
                      controller: model.timeStart,
                      decoration: InputDecoration(
                          labelText: "Время начала",
                          suffixIcon: model.timeStart.text.length > 0
                              ? IconButton(
                            onPressed: bloc.throwTimeStart,
                            icon: Icon(
                              Icons.cancel,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                          ) : null
                      ),
                      onTap: () => bloc.startTimePicker(context),
                    ),
                    TextField(
                      readOnly: true,
                      controller: model.timeEnd,
                      decoration: InputDecoration(
                          labelText: "Время завершения",
                          suffixIcon: model.timeEnd.text.length > 0
                              ? IconButton(
                            onPressed: bloc.throwTimeEnd,
                            icon: Icon(
                              Icons.cancel,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                          ) : null
                      ),
                      onTap: () => bloc.endTimePicker(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text('УЧАСТНИКИ ВСТРЕЧИ', style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                ),
              ),
              ListTile(
                title: Text('Внутренние участники'),
                subtitle: Text('${model.internalParticipants.length}'),
                dense: true,
                trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InternalExternalParticipantsView(
                        bloc: bloc,
                        internal: true,
                        title: 'Внутренние участники'
                    )
                )
            ),
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
              ListTile(
                title: Text('Внешние участники'),
                subtitle: Text('${model.externalParticipants.length}'),
                dense: true,
                trailing: Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InternalExternalParticipantsView(
                        bloc: bloc,
                        internal: false,
                        title: 'Внешние участники'
                    )
                )
            ),
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
            onPressed: model.disable ? null : bloc.onPressed,
            buttonTitle: 'Бронирование',
          ),
        );
      }
    );
  }
}