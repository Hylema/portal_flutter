import 'package:meta/meta.dart';

class PhoneBookModel {
  final int childrenCount;
  final bool childrenExists;
  final String code;
  final int employeesCount;
  final int id;
  final String managerFullName;
  final int managerId;
  final String managerLogin;
  final String managerPosition;
  final String managerReason;
  final String name;
  final String parentCode;
  final int parentId;
  final String parentName;
  final String unitTypeName;

  PhoneBookModel({
    @required this.childrenCount,
    @required this.childrenExists,
    @required this.code,
    @required this.employeesCount,
    @required this.id,
    @required this.managerFullName,
    @required this.managerId,
    @required this.managerLogin,
    @required this.managerPosition,
    @required this.managerReason,
    @required this.name,
    @required this.parentCode,
    @required this.parentId,
    @required this.parentName,
    @required this.unitTypeName,
  });

  static PhoneBookModel fromJson(raw){
    return PhoneBookModel(
      childrenCount: raw['childrenCount'],
      childrenExists: raw['childrenExists'],
      code: raw['code'],
      employeesCount: raw['employeesCount'],
      id: raw['id'],
      managerFullName: raw['managerFullName'],
      managerId: raw['managerId'],
      managerLogin: raw['managerLogin'],
      managerPosition: raw['managerPosition'],
      managerReason: raw['managerReason'],
      name: raw['name'],
      parentCode: raw['parentCode'],
      parentId: raw['parentId'],
      parentName: raw['parentName'],
      unitTypeName: raw['unitTypeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'childrenCount': childrenCount,
      'childrenExists': childrenExists,
      'code': code,
      'employeesCount': employeesCount,
      'id': id,
      'managerFullName': managerFullName,
      'managerId': managerId,
      'managerLogin': managerLogin,
      'managerPosition': managerPosition,
      'managerReason': managerReason,
      'name': name,
      'parentCode': parentCode,
      'parentId': parentId,
      'parentName': parentName,
      'unitTypeName': unitTypeName,
    };
  }
}