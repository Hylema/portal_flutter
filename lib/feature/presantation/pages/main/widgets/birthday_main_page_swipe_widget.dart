import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/birthday/birthday_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BirthdayMainPageSwipeWidget extends StatelessWidget {
  final BirthdayBloc bloc;
  BirthdayMainPageSwipeWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<BirthdayBloc, BirthdayState>(
      bloc: bloc,
      builder: (context, state) {
        if(state is LoadedBirthdayState){
          return BirthdayMainPageSwipeWidgetStateBuild(listModel: state.birthdays,);
        } else {
          return Container();
        }
      },
      listener: (context, state) {},
    );
  }
}

class BirthdayMainPageSwipeWidgetStateBuild extends StatelessWidget {

  final List<BirthdayModel> listModel;
  BirthdayMainPageSwipeWidgetStateBuild({
    @required this.listModel
  }) : assert(listModel != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Swiper(
          autoplay: true,
          autoplayDelay: 4000,
          itemBuilder: (BuildContext context, int index) {
            return BirthdayMainPageSwipeListWidget(birthdayModel: listModel[index]);
          },
          itemCount: listModel.length,
          viewportFraction: 0.34
      ),
      height: 220,
    );
  }
}

class BirthdayMainPageSwipeListWidget extends StatelessWidget{

  final BirthdayModel birthdayModel;
  BirthdayMainPageSwipeListWidget({@required this.birthdayModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              spreadRadius: 0.5,
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: 80, maxHeight: 80),
              child: Center(
                child: Image.asset('assets/images/noPhoto.png', width: 50,),
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
                        5.0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    )
                  ],
                  border: Border.all(
                      color: Colors.white,
                      width: 6.0
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Text(
                '${birthdayModel.lastName} ${birthdayModel.firstName} ${birthdayModel.fatherName}',
                overflow: TextOverflow.fade,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              'Сегодня',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 10
              ),
            ),
          ],
        )
    );
  }
}