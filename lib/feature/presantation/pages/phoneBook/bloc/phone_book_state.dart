import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneBookState {}

class InitialPhoneBookState extends PhoneBookState {}
class LoadedPhoneBookState extends PhoneBookState {
  final List<PhoneBookModel> phoneBooks;

  LoadedPhoneBookState({@required this.phoneBooks});
}
