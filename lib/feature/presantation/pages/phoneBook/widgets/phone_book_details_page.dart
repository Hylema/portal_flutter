import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/phoneBook/phone_book_user_model.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';

class PhoneBookDetailsPage extends StatelessWidget {
  final PhoneBookUserModel phoneBookUserModel;
  const PhoneBookDetailsPage({
    @required this.phoneBookUserModel
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        title: '${phoneBookUserModel.managerFullName}',
        backButtonColor: Colors.black,
        automaticallyImplyLeading: true,
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
                  'Телефон: ${phoneBookUserModel.phoneInternal != null && phoneBookUserModel.phoneInternal != '' ? phoneBookUserModel.phoneInternal : '-'}',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Телефон менеджера: ${phoneBookUserModel.mobile != null && phoneBookUserModel.mobile != '' ? phoneBookUserModel.mobile : '-'}',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Email: ${phoneBookUserModel.email != null && phoneBookUserModel.email != '' ? phoneBookUserModel.email : '-'}',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Город: ${phoneBookUserModel.city != null && phoneBookUserModel.city != '' ? phoneBookUserModel.city : '-'}',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${phoneBookUserModel.departmentName}',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 50),
                JsonViewerWidget(phoneBookUserModel.toJson()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}