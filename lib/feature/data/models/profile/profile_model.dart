import 'package:flutter_architecture_project/feature/domain/entities/profile/profile.dart';
import 'package:meta/meta.dart';

class ProfileModel extends Profile {
  ProfileModel({
    @required profile,
  }) : super(
    profile: profile,
  );

  factory ProfileModel.fromJson(profileData) {
    return ProfileModel(
      profile: profileData['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile,
    };
  }
}