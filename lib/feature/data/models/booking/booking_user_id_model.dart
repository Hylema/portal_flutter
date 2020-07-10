import 'package:meta/meta.dart';

class BookingUserIdModel {
  final int id;

  BookingUserIdModel({
    @required this.id
  });

  static BookingUserIdModel fromJson(raw){
    return BookingUserIdModel(
      id: raw[0],
    );
  }
}

