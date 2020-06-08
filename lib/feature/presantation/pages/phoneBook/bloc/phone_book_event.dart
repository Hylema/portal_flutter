import 'package:meta/meta.dart';

@immutable
abstract class PhoneBookEvent {}

class FetchPhoneBookEvent extends PhoneBookEvent {
  final String parentCode;
  final bool update;

  FetchPhoneBookEvent({this.parentCode, this.update = false});
}

class FetchPhoneBookUserEvent extends PhoneBookEvent {
  final String parentCode;

  FetchPhoneBookUserEvent({this.parentCode});
}

class FirstFetchPhoneBookEvent extends PhoneBookEvent {}
