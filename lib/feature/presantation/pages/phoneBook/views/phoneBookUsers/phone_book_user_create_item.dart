import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_details_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/widgets/phone_book_search_bold_text.dart';

class PhoneBookUserCreateItem extends StatelessWidget {
  final PhoneBookUserModel phoneBookUserModel;
  final bool last;
  PhoneBookUserCreateItem({
    @required this.phoneBookUserModel,
    @required this.last
  });

  @override
  Widget build(BuildContext context) {
    print(last);
    return OpenContainer<bool>(
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) => PhoneBookDetailsPage(phoneBookUserModel: phoneBookUserModel),
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
              !last ? Container(
                margin: EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 0.8,
                      color: Colors.grey[400],
                    ))
                ),
              ) : Container()
            ],
          )
      ),
    );
  }
}
