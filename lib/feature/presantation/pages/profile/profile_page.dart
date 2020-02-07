import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_shimmer.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<ProfileBloc>(),
          child: ProfilePageProvider()
      ),
    );
  }
}

class ProfilePageProvider extends StatefulWidget {
  _ProfilePageProviderState createState() => _ProfilePageProviderState();
}

class _ProfilePageProviderState extends State<ProfilePageProvider> {

  var _profile;
  bool noData = false;

  @override
  void initState(){
    super.initState();
  }

  void dispatchGetProfileDataFromCache(context){
    context.bloc<ProfileBloc>().add(GetProfileFromCacheBlocEvent());
  }
  void dispatchGetProfileDataFromNetwork(context){
    context.bloc<ProfileBloc>().add(GetProfileFromNetworkBlocEvent());
  }


  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is Empty) {
          _profile = GlobalData.profile;
          if(_profile == null){
            dispatchGetProfileDataFromCache(context);
            return ProfileShimmer();
          } else {
            print('_profile из кэша === $_profile');
            return ProfilePageBody(data: _profile,);
          }
        } else if (state is Loading) {
          return ProfileShimmer();
        } else if (state is Loaded) {
          _profile = state.model.profile;
          print('_profile из стейта === $_profile');
          return ProfilePageBody(data: _profile,);
        } else if (state is Error) {
          return Container(
            child: Center(
              child: Text(state.message),
            ),
          );
        }

        return Container();
      },
      listener: (context, state) {
        if(state is Auth){
          Navigator.push(context, ScaleRoute(page: AuthPage()));
        }
      },
    );
  }
}

class ProfilePageBody extends StatelessWidget {
  final data;
  ProfilePageBody({this.data});

  final List listData = [
    {
      'value': 'Прямая структура подчинения',
      'key': 'department',
    },
    {
      'value': 'Дата начала работы в организации',
      'key': 'startWork',
    },
    {
      'value': 'Внутренний телефон',
      'key': 'workPhone',
    },
    {
      'value': 'День рождения',
      'key': 'birthday',
    },
    {
      'value': 'Электронная почта',
      'key': 'email',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 230.0,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(
                                    10.0, // horizontal, move right 10
                                    10.0, // vertical, move down 10
                                  ),
                                )
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage('https://avatars.mds.yandex.net/get-pdb/1356811/4c2cf9f4-389b-46b2-aec8-ee02a92815a5/s1200')
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 150.0,
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: Center(
                        child: Image.asset('assets/images/noPhoto.png', width: 70,),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                10.0, // horizontal, move right 10
                                10.0, // vertical, move down 10
                              ),
                            )
                          ],
//                                    image: DecorationImage(
//                                      fit: BoxFit.cover,
//                                      image: apiWidgets.imageNetworkProfile(data['pictureUrl']),
//                                    ),
                          border: Border.all(
                              color: Colors.white,
                              width: 6.0
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0,),
            Container(
                alignment: Alignment.center,
                child: Text(
                  data['position'],
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromRGBO(119, 134, 147, 1)
                  ),
                )
            ),
            SizedBox(height: 22.0),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((BuildContext context, index){
            return _buildLine(listData[index]['value'], data[listData[index]['key']]);
          },
              childCount: listData.length
          ),
        ),
      ],
    );
  }

  Widget _buildLine(String title, body) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Color.fromRGBO(119, 134, 147, 1),
                fontSize: 14
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              body,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          new Divider(
            color: Color.fromRGBO(119, 134, 147, 1),
          ),
        ],
      ),
    );
  }
}