import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/bloc/bloc.dart';

class SingletonBlocs {
  final AuthBloc authBloc;
  final BirthdayBloc birthdayBloc;
  final NewsPortalBloc newsPortalBloc;
  final MainBloc mainBloc;
  final VideoGalleryBloc videoGalleryBloc;
  final ProfileBloc profileBloc;
  final PhoneBookBloc phoneBookBloc;
  final PollsBloc pollsBloc;

  SingletonBlocs({
    @required this.authBloc,
    @required this.birthdayBloc,
    @required this.newsPortalBloc,
    @required this.mainBloc,
    @required this.videoGalleryBloc,
    @required this.profileBloc,
    @required this.phoneBookBloc,
    @required this.pollsBloc,
  });
}