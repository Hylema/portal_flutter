import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';

class VideoGalleryItemsWidget extends StatefulWidget {
  VideoGalleryItemsWidget({
    this.videoData,
  }){
    assert(this.videoData != null);
  }
  final videoData;

  @override
  VideoGalleryItemsWidgetState createState() => VideoGalleryItemsWidgetState();
}

class VideoGalleryItemsWidgetState extends State<VideoGalleryItemsWidget> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  var videoData;

  @override
  void initState() {
    videoData = widget.videoData;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
//          onTap: (){
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => NewsPortalCardInformationPage(
//                      index: _index,
//                      news: _news,
//                    )
//                )
//            );
//          },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 1,
                  offset: Offset(
                    1.0, // horizontal, move right 10
                    1.0, // vertical, move down 10
                  ),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                      children: <Widget>[
                        Image.network(
                            'https://img3.goodfon.ru/original/1920x1080/e/66/planety-kolca-tumannost.jpg',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width
                        ),
                        Center(
                          child: Icon(
                              Icons.play_arrow,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0x00000000),
                                const Color(0xC0000000),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: DateTimeWidget(
                                  dataTime: videoData['created'],
                                  color: Colors.white,
                                ),
                              ),
                              TitleWidget(
                                title: videoData['title'],
                                titleSize: 16,
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
