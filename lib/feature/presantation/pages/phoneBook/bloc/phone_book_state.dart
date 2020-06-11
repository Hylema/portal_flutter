import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_model.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PhoneBookState extends Equatable{
    @override
  List<Object> get props => [];
}

class InitialPhoneBookState extends PhoneBookState {}
class LoadingPhoneBookState extends PhoneBookState {}
class LoadedPhoneBookState extends PhoneBookState {
  final List<PhoneBookModel> phoneBooks;

  LoadedPhoneBookState({@required this.phoneBooks});

  @override
  List<Object> get props => [phoneBooks];
}

class LoadedPhoneBookUserState extends PhoneBookState {
  final List<PhoneBookUserModel> phoneBooksUser;
  final bool hasReachedMax;

  LoadedPhoneBookUserState({@required this.phoneBooksUser, this.hasReachedMax = false});

  LoadedPhoneBookUserState copyWith({
    List<PhoneBookUserModel> phoneBooksUser,
    bool hasReachedMax,
  }) {
    return LoadedPhoneBookUserState(
      phoneBooksUser: phoneBooksUser ?? this.phoneBooksUser,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [phoneBooksUser, hasReachedMax];
}
