import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/profile/profile_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is InitialProfileState) {
          return ProfilePageShimmer();
        } else if (state is LoadingProfileState) {
          return ProfilePageShimmer();
        } else if (state is LoadedProfileState) {
          return ProfilePageBody(data: state.model,);
        } else if (state is ErrorProfileState) {
          return ProfilePageShimmer();
        } else if(state is LoadedProfileFromCacheState) {
          if(state.data != null) return ProfilePageBody(data: state.data, fromCache: true);
          else return Center(child: Text('Нет ранее сохраненных данных'));
        }
        return Container();
      },
      listener: (context, state) {},
    );
  }
}

class ProfilePageBody extends StatelessWidget {
  final ProfileModel data;
  final bool fromCache;
  ProfilePageBody({@required this.data, this.fromCache = false});

  @override
  Widget build(BuildContext context) {
    final List listData = [
      {
        'key': 'Прямая структура подчинения',
        'value': '${data.department}',
      },
      {
        'key': 'Дата начала работы в организации',
        'value': '${data.startWork}',
      },
      {
        'key': 'Внутренний телефон',
        'value': '${data.workPhone}',
      },
      {
        'key': 'День рождения',
        'value': '${data.birthday}',
      },
      {
        'key': 'Электронная почта',
        'value': '${data.email}',
      },
    ];

    return SmartRefresherWidget(
      enableControlLoad: false,
      enableControlRefresh: true,
      hasReachedMax: true,
      onRefresh: () => BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent()),
      child: CustomScrollView(
        controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              DataFromCacheMessageWidget(fromCache: fromCache),
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
                      data.name,
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
                    data.position,
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
              return _buildLine(key: listData[index]['key'], value: listData[index]['value']);
            },
                childCount: listData.length
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLine({@required String key, @required String value}) {
    if(value == ''){
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(
                color: Color.fromRGBO(119, 134, 147, 1),
                fontSize: 14
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              value,
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
