import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/mixins/blocs_dispatches_events.dart';
import 'package:flutter_architecture_project/core/mixins/blocs.dart';
import 'package:flutter_architecture_project/core/mixins/singleton.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/newsPopularity/news_popularity_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => di.sl<ProfileBloc>(),
          ),
          BlocProvider<NewsPortalBloc>(
            create: (BuildContext context) => di.sl<NewsPortalBloc>(),
          ),
          BlocProvider<MainBloc>(
            create: (BuildContext context) => di.sl<MainBloc>(),
          ),
          BlocProvider<VideoGalleryBloc>(
            create: (BuildContext context) => di.sl<VideoGalleryBloc>(),
          ),
          BlocProvider<NewsPopularityBloc>(
            create: (BuildContext context) => di.sl<NewsPopularityBloc>(),
          ),
          BlocProvider<BirthdayBloc>(
            create: (BuildContext context) => di.sl<BirthdayBloc>(),
          ),
          BlocProvider<SelectedIndexBloc>(
            create: (BuildContext context) => di.sl<SelectedIndexBloc>(),
          ),

          ///Bloc для загрузки первичныз данных. Если все данные загрузятся успешно,
          ///то пустит на главную или отправит на авторизацию
          BlocProvider<AppBloc>(
            create: (BuildContext context) => di.sl<AppBloc>(),
          ),
          ///Bloc для возврата ответа все остальных Blocs
        ],
      child: WidgetsApp(
        color: Colors.red,
        builder: (context, d) {
          return Scaffold(
            body: MakeBlocs(),
          );
        },
      )
    );
  }
}

class MakeBlocs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Singleton.blocsClass = new Blocs(
      appBloc: context.bloc<AppBloc>(),
      profileBloc: context.bloc<ProfileBloc>(),
      newsBloc: context.bloc<NewsPortalBloc>(),
      mainBloc: context.bloc<MainBloc>(),
      videoGalleryBloc: context.bloc<VideoGalleryBloc>(),
      birthdayBloc: context.bloc<BirthdayBloc>(),
    );

    return MakeBlocsListener();
  }
}

class MakeBlocsListener extends StatelessWidget with Dispatch {

  int stateCount = 0;
  int countPagesNeedAuthorization = 4;
  bool authDoNotNeed = true;

  void _processIsOver({
    @required state
  }){
    ++stateCount;

    print('MAIN STATE = $state');

    switch(state){
      case NeedAuthProfile: authDoNotNeed = false; break;
      case NeedAuthNewsPortal: authDoNotNeed = false; break;
      case NeedAuthBirthday: authDoNotNeed = false; break;
      case NeedAuthVideoGalleryState: authDoNotNeed = false; break;
    }


    if(authDoNotNeed && stateCount == countPagesNeedAuthorization){
      dispatchAllPageLoaded();
    }
  }

  void _showSnackBar({@required context, @required message}){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (BuildContext context, ProfileState state) {
            if(state is NeedAuthProfile) dispatchNeedAuth();
            else if (state is ErrorProfile) {
              _showSnackBar(context: context, message: state.message);
              dispatchGetProfileDataFromCache();
            }

            _processIsOver(state: state.runtimeType);
          },
        ),
        BlocListener<NewsPortalBloc, NewsPortalState>(
          listener: (BuildContext context, NewsPortalState state) {
            if(state is NeedAuthNewsPortal) dispatchNeedAuth();
            else if (state is ErrorNewsPortal) {
              _showSnackBar(context: context, message: state.message);
              dispatchGetNewsDataFromCache();
            }

            _processIsOver(state: state.runtimeType);
          },
        ),
        BlocListener<VideoGalleryBloc, VideoGalleryState>(
          listener: (BuildContext context, VideoGalleryState state) {
            if(state is NeedAuthVideoGalleryState) dispatchNeedAuth();
            else if (state is ErrorVideoGalleryState) _showSnackBar(context: context, message: state.message);

            _processIsOver(state: state.runtimeType);
          },
        ),
        BlocListener<BirthdayBloc, BirthdayState>(
          listener: (BuildContext context, BirthdayState state) {
            if(state is NeedAuthBirthday) dispatchNeedAuth();
            else if (state is ErrorBirthdayState) _showSnackBar(context: context, message: state.message);

            _processIsOver(state: state.runtimeType);
          },
        ),


        BlocListener<AppBloc, AppState>(
          listener: (BuildContext context, AppState state) {
            if(state is NeedAuth) {}
            else if (state is Finish){}
          },
        ),
        BlocListener<MainBloc, MainState>(
          listener: (BuildContext context, MainState state) {
            if (state is ErrorMainParams) _showSnackBar(context: context, message: state.message);
          },
        ),
      ],
        child: MaterialApp(
//        theme: ThemeData(highlightColor: Color.fromRGBO(238, 0, 38, 0.1)),
          home: WelcomePage(),
          debugShowCheckedModeBanner: false,
        ),
    );
  }
}
