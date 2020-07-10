import 'package:meta/meta.dart';

class BookingRoomsModel {
  final int id;
  final String title;
  final String imageUrl;
  final String hasProjector;
  final String hasVideoStaff;
  final Map floor;


  BookingRoomsModel({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.hasProjector,
    @required this.hasVideoStaff,
    @required this.floor,

  });

  static BookingRoomsModel fromJson(raw){
    return BookingRoomsModel(
      id: raw['id'],
      title: raw['title'],
      imageUrl: raw['imageUrl'],
      hasProjector: raw['hasProjector'],
      hasVideoStaff: raw['hasVideoStaff'],
      floor: raw['floor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'hasProjector': hasProjector,
      'hasVideoStaff': hasVideoStaff,
      'floor': floor,
    };
  }
}

