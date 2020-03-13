import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/blocsResponses/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/fields/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/bloc.dart';

class Blocs {
  final AppBloc _appBloc;
  final ProfileBloc _profileBloc;
  final NewsPortalBloc _newsBloc;
  final MainBloc _mainBloc;
  final VideoGalleryBloc _videoGalleryBloc;
  final BirthdayBloc _birthdayBloc;
  final ResponsesBloc _responsesBloc;
  final FieldsBloc _fieldsBloc;

  Blocs({
    @required appBloc,
    @required profileBloc,
    @required newsBloc,
    @required mainBloc,
    @required videoGalleryBloc,
    @required birthdayBloc,
    @required responsesBloc,
    @required fieldsBloc,
  }) : assert(appBloc != null),
        assert(profileBloc != null),
        assert(newsBloc != null),
        assert(mainBloc != null),
        assert(videoGalleryBloc != null),
        assert(birthdayBloc != null),
        assert(responsesBloc != null),
        assert(fieldsBloc != null),
        _appBloc = appBloc,
        _profileBloc = profileBloc,
        _newsBloc = newsBloc,
        _mainBloc = mainBloc,
        _videoGalleryBloc = videoGalleryBloc,
        _birthdayBloc = birthdayBloc,
        _fieldsBloc = fieldsBloc,
        _responsesBloc = responsesBloc;

  get appBloc => _appBloc;
  get profileBloc => _profileBloc;
  get newsBloc => _newsBloc;
  get mainBloc => _mainBloc;
  get videoGalleryBloc => _videoGalleryBloc;
  get birthdayBloc => _birthdayBloc;
  get responsesBloc => _responsesBloc;
  get fieldsBloc => _fieldsBloc;
}