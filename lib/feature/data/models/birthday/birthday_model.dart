import 'package:meta/meta.dart';

class BirthdayModel {
  final isFavorite;
  final phoneInternal;
  final id;
  final tabNumber;
  final managerId;
  final departmentCode;
  final officeNumber;
  final rootDepartmentCode;
  final birthdayMonth;
  final birthdayDay;
  final rootDepartmentName;
  final startWorkDate;
  final address;
  final city;
  final departmentName;
  final departmentsChain;
  final email;
  final login;
  final managerFullName;
  final mobile;
  final fatherName;
  final lastName;
  final firstName;
  final positionName;
  final photoUrl;
  final isManager;

  BirthdayModel({
    @required this.isFavorite,
    @required this.phoneInternal,
    @required this.id,
    @required this.tabNumber,
    @required this.managerId,
    @required this.departmentCode,
    @required this.officeNumber,
    @required this.rootDepartmentCode,
    @required this.birthdayMonth,
    @required this.birthdayDay,
    @required this.rootDepartmentName,
    @required this.startWorkDate,
    @required this.address,
    @required this.city,
    @required this.departmentName,
    @required this.departmentsChain,
    @required this.email,
    @required this.login,
    @required this.managerFullName,
    @required this.mobile,
    @required this.fatherName,
    @required this.lastName,
    @required this.firstName,
    @required this.positionName,
    @required this.photoUrl,
    @required this.isManager,
  });

  static BirthdayModel fromJson(raw){
    return BirthdayModel(
      isFavorite: raw['isFavorite'],
      phoneInternal: raw['phoneInternal'],
      id: raw['id'],
      tabNumber: raw['tabNumber'],
      managerId: raw['managerId'],
      departmentCode: raw['departmentCode'],
      officeNumber: raw['officeNumber'],
      rootDepartmentCode: raw['rootDepartmentCode'],
      birthdayMonth: raw['birthdayMonth'],
      birthdayDay: raw['birthdayDay'],
      rootDepartmentName: raw['rootDepartmentName'],
      startWorkDate: raw['startWorkDate'],
      address: raw['address'],
      city: raw['city'],
      departmentName: raw['departmentName'],
      departmentsChain: raw['departmentsChain'],
      email: raw['email'],
      login: raw['login'],
      managerFullName: raw['managerFullName'],
      mobile: raw['mobile'],
      fatherName: raw['fatherName'],
      lastName: raw['lastName'],
      firstName: raw['firstName'],
      positionName: raw['positionName'],
      photoUrl: raw['photoUrl'],
      isManager: raw['isManager'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isFavorite': isFavorite,
      'phoneInternal': phoneInternal,
      'id': id,
      'tabNumber': tabNumber,
      'managerId': managerId,
      'departmentCode': departmentCode,
      'officeNumber': officeNumber,
      'rootDepartmentCode': rootDepartmentCode,
      'birthdayMonth': birthdayMonth,
      'birthdayDay': birthdayDay,
      'rootDepartmentName': rootDepartmentName,
      'startWorkDate': startWorkDate,
      'address': address,
      'city': city,
      'departmentName': departmentName,
      'departmentsChain': departmentsChain,
      'email': email,
      'login': login,
      'managerFullName': managerFullName,
      'mobile': mobile,
      'fatherName': fatherName,
      'lastName': lastName,
      'firstName': firstName,
      'positionName': positionName,
      'photoUrl': photoUrl,
      'isManager': isManager,
    };
  }
}