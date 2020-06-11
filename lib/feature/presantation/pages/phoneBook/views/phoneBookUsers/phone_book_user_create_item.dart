import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_search_bold_text.dart';

class PhoneBookUserCreateItem extends StatelessWidget {
  final PhoneBookUserModel phoneBookUserModel;
  PhoneBookUserCreateItem({@required this.phoneBookUserModel});

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) => _DetailsPage (),
      tappable: true,
      closedBuilder: (BuildContext context, VoidCallback _) => Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ListTile(
                title: PhoneBookSearchBoldText(searchString: phoneBookUserModel.searchStringName, text: phoneBookUserModel.managerFullName),
                subtitle: PhoneBookSearchBoldText(searchString: phoneBookUserModel.searchStringDepartment, text: phoneBookUserModel.departmentName),
                leading: CircleAvatar(
                    foregroundColor: Colors.red,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/noPhoto.png')
                ),
                dense: true,
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 0.8,
                      color: Colors.grey[400],
                    ))
                ),
              ),
            ],
          )
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage({this.includeMarkAsDoneButton = true});

  final bool includeMarkAsDoneButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Информация о пользователе'),
        actions: <Widget>[
          if (includeMarkAsDoneButton)
            IconButton(
              icon: const Icon(Icons.done),
              onPressed: () => Navigator.pop(context, true),
              tooltip: 'Mark as done',
            )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black38,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(70.0),
//              child: Image.asset(
//                'assets/placeholder_image.png',
//              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Инфо',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Как появится макет, тут будет отображаться информация о пользователе',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
