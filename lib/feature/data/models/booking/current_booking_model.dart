import 'package:meta/meta.dart';

class CurrentBookingModel {
  final int id;
  final int authorId;
  final int duration;
  final int count;
  final String startDate;
  final String eventType;
  final String endDate;
  final String endTodayDate;
  final String eventDate;
  final String title;
  final String projector;
  final String videoStaff;
  final Map initiator;
  final Map type;
  final List participants;
  final Map responsible;
  final Map room;


  CurrentBookingModel({
    @required this.id,
    @required this.authorId,
    @required this.duration,
    @required this.count,
    @required this.startDate,
    @required this.eventType,
    @required this.endDate,
    @required this.endTodayDate,
    @required this.eventDate,
    @required this.title,
    @required this.projector,
    @required this.videoStaff,
    @required this.initiator,
    @required this.type,
    @required this.participants,
    @required this.responsible,
    @required this.room,

  });

  static CurrentBookingModel fromJson(raw){
    return CurrentBookingModel(
      id: raw['id'],
      authorId: raw['authorId'],
      duration: raw['duration'],
      count: raw['count'],
      startDate: raw['startDate'],
      eventType: raw['eventType'],
      endDate: raw['endDate'],
      endTodayDate: raw['endTodayDate'],
      eventDate: raw['eventDate'],
      title: raw['title'],
      projector: raw['projector'],
      videoStaff: raw['videoStaff'],
      initiator: raw['initiator'],
      type: raw['type'],
      participants: raw['participants'],
      responsible: raw['responsible'],
      room: raw['room'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'duration': duration,
      'count': count,
      'startDate': startDate,
      'eventType': eventType,
      'endDate': endDate,
      'endTodayDate': endTodayDate,
      'eventDate': eventDate,
      'title': title,
      'projector': projector,
      'videoStaff': videoStaff,
      'initiator': initiator,
      'type': type,
      'participants': participants,
      'responsible': responsible,
      'room': room,
    };
  }
}

