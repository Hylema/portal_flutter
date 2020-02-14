import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/domain/entities/news/news_portal.dart';

import 'package:meta/meta.dart';

@immutable
abstract class AppState extends Equatable{
  AppState([List props = const <dynamic>[]]) : super(props);
}

class Start extends AppState {}
class Waiting extends AppState {}
class NeedAuth extends AppState {}
class Finish extends AppState {}
class Error extends AppState {}
