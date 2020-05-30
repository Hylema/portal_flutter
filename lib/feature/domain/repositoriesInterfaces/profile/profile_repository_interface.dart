import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';

abstract class IProfileRepository {
  Future<ProfileModel> fetchProfile();
  ProfileModel getProfileFromCache();
  Future<void> saveProfileToCache({@required ProfileModel model});
}