import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
import './bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
//    await Firestore.instance.collection('news').document('124152342')
//        .setData({ 'likes': 123, 'seen': 65 });
//    Firestore.instance.collection('books').snapshots();
//    await Firestore.instance.collection('news').document('124152342').get().then((DocumentSnapshot ds) {
//      print('FIREBASE ====================================== ${ds.data}');
//    });

    if(event is WaitingEvent) yield Waiting();
    if(event is NeedAuthEvent) yield NeedAuth();
    if(event is LoadedEvent) yield Finish();
  }
}
