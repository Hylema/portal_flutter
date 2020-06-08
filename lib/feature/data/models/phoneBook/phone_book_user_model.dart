import 'package:meta/meta.dart';

class PhoneBookUserModel {
  final int id;
  final address;
  final int birthdayDay;
  final int birthdayMonth;
  final String city;
  final String departmentCode;
  final String departmentName;
  final String departmentsChain;
  final String email;
  final String fatherName;
  final String firstName;
  final isFavorite;
  final bool isManager;
  final String lastName;
  final login;
  final String managerFullName;
  final int managerId;
  final mobile;
  final String officeNumber;
  final String phoneInternal;
  final String positionName;
  final String rootDepartmentCode;
  final String rootDepartmentName;
  final String startWorkDate;
  final tabNumber;

  PhoneBookUserModel({
    @required this.id,
    @required this.address,
    @required this.birthdayDay,
    @required this.birthdayMonth,
    @required this.city,
    @required this.departmentCode,
    @required this.departmentName,
    @required this.departmentsChain,
    @required this.email,
    @required this.fatherName,
    @required this.firstName,
    @required this.isFavorite,
    @required this.isManager,
    @required this.lastName,
    @required this.login,
    @required this.managerFullName,
    @required this.managerId,
    @required this.mobile,
    @required this.officeNumber,
    @required this.phoneInternal,
    @required this.positionName,
    @required this.rootDepartmentCode,
    @required this.rootDepartmentName,
    @required this.startWorkDate,
    @required this.tabNumber,
  });

  static PhoneBookUserModel fromJson(raw){
    return PhoneBookUserModel(
      id: raw['id'],
      address: raw['address'],
      birthdayDay: raw['birthdayDay'],
      birthdayMonth: raw['birthdayMonth'],
      city: raw['city'],
      departmentCode: raw['departmentCode'],
      departmentName: raw['departmentName'],
      departmentsChain: raw['departmentsChain'],
      email: raw['email'],
      fatherName: raw['fatherName'],
      firstName: raw['firstName'],
      isFavorite: raw['isFavorite'],
      isManager: raw['isManager'],
      lastName: raw['lastName'],
      login: raw['login'],
      managerFullName: raw['managerFullName'],
      managerId: raw['managerId'],
      mobile: raw['mobile'],
      officeNumber: raw['officeNumber'],
      phoneInternal: raw['phoneInternal'],
      positionName: raw['positionName'],
      rootDepartmentCode: raw['rootDepartmentCode'],
      rootDepartmentName: raw['rootDepartmentName'],
      startWorkDate: raw['startWorkDate'],
      tabNumber: raw['tabNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'birthdayDay': birthdayDay,
      'birthdayMonth': birthdayMonth,
      'city': city,
      'departmentCode': departmentCode,
      'departmentName': departmentName,
      'departmentsChain': departmentsChain,
      'email': email,
      'fatherName': fatherName,
      'firstName': firstName,
      'isFavorite': isFavorite,
      'isManager': isManager,
      'lastName': lastName,
      'login': login,
      'managerFullName': managerFullName,
      'managerId': managerId,
      'mobile': mobile,
      'officeNumber': officeNumber,
      'phoneInternal': phoneInternal,
      'positionName': positionName,
      'rootDepartmentCode': rootDepartmentCode,
      'rootDepartmentName': rootDepartmentName,
      'startWorkDate': startWorkDate,
      'tabNumber': tabNumber,
    };
  }
}