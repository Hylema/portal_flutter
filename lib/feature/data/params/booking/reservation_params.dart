import 'package:flutter_architecture_project/feature/data/models/booking/booking_users_model.dart';
import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class ReservationParams extends Params{
  String title;
  String roomTitle;
  String description = 'Описание встречи';
  String organization;
  int get count => [...internalParticipants, ...externalParticipants, responsibleId].length;
  String startDate;
  String endDate;
  int initiatorId;
  int responsibleId;
  String responsibleName;
  List<int> get participantsIds => [...internalParticipants, ...externalParticipants, responsibleId];
  List<int> internalParticipants = [];
  List<BookingUsersModel> internalParticipantsNames = [];
  List<int> externalParticipants = [];
  List<BookingUsersModel> externalParticipantsNames = [];
  String meetingTypeId;
  String meetingTypeText;
  int officeId;
  int roomId;
  bool videoStaff;
  bool projector;
  List<MeetingTypeModel> meetingType;

  ReservationParams({
    this.title,
    this.organization,
    this.roomTitle,
    this.startDate,
    this.endDate,
    this.initiatorId,
    this.responsibleId,
    this.responsibleName,
    this.meetingTypeId,
    this.meetingTypeText,
    this.officeId,
    this.roomId,
    this.videoStaff,
    this.projector,
    this.meetingType
  });

  @override
  List get props => [
    title, count, startDate, endDate, initiatorId, responsibleId,
    participantsIds, meetingTypeId, officeId, roomId, videoStaff,
    projector, organization
  ];

  @override
  Map get bodyProps => {
    'count': count,
    'description': description,
    'endDate': endDate,
    'initiatorId': initiatorId,
    'meetingTypeId': meetingTypeId,
    'officeId': officeId,
    'participantsIds': participantsIds,
    'responsibleId': responsibleId,
    'roomId': roomId,
    'startDate': startDate,
    'title': title,
    'videoStaff': videoStaff,
    'projector': projector,
  };

  @override
  Map get urlProps => {
    'organization': organization,
  };

  bool isReady() {
    if(
    title != null && count != null && startDate != null && endDate != null &&
        initiatorId != null && responsibleId != null && participantsIds != null &&
        meetingTypeId != null && officeId != null && roomId != null && videoStaff != null && projector != null
    ) return true;
    else return false;
  }
}