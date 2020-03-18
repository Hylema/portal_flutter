import 'package:meta/meta.dart';

class ProfileModel {
  final profile;

  ProfileModel({
    @required this.profile,
  });

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