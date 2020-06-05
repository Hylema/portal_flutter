import 'package:meta/meta.dart';

@immutable
abstract class PhoneBookEvent {}

class FetchPhoneBookEvent extends PhoneBookEvent {
  final String parentCode;

  FetchPhoneBookEvent({this.parentCode});
}
