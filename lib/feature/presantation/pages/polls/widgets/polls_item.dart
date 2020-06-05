import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/polls/polls_model.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PollsItem extends StatelessWidget {
  final PollsModel currentPoll;
  PollsItem({@required this.currentPoll});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebviewScaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: true,
                      backgroundColor: Colors.red[800],
                    ),
                    url: currentPoll.link
                ),
              )
          ),
      dense: true,
      title: Text(
          '${currentPoll.title}',
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
              color: Color.fromRGBO(69, 69, 69, 1),
              fontWeight: FontWeight.bold,
              fontSize: 14
          )
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${currentPoll.type}'),
          Text('16 декабря 2019')
        ],
      ),
    );
  }
}
