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

class SearchPhoneBookUserEvent extends PhoneBookEvent {
  final String searchString;
  final String parentCode;

  SearchPhoneBookUserEvent({this.searchString, this.parentCode});
}
class UpdateFoundPhoneBookUserEvent extends PhoneBookEvent{}
class FetchFoundPhoneBookUserEvent extends PhoneBookEvent {}

class UpdatePhoneBookUserEvent extends PhoneBookEvent{}
class ClearPhoneBookUserEvent extends PhoneBookEvent{}

class FirstFetchPhoneBookEvent extends PhoneBookEvent {}
class LocalPhoneBookSearchEvent extends PhoneBookEvent {
  final String value;

  LocalPhoneBookSearchEvent({@required this.value});
}

class LocalPhoneBookUserSearchEvent extends PhoneBookEvent {
  final String value;

  LocalPhoneBookUserSearchEvent({@required this.value});
}


