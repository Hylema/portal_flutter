import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}







class VideoGalleryItemsWidget extends StatelessWidget {
  VideoGalleryItemsWidget({
    @required this.videoData,
  }){
    assert(this.videoData != null);
  }
  final VideosGalleryModel videoData;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebviewScaffold(
                      url: videoData.videoUrl,
                      appBar: AppBar(
                        automaticallyImplyLeading: true,
                        backgroundColor: Colors.red[800],
                      ),
                    ),
                )
            );
          },
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
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
                      Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
//                        Center(
//                          child: IconButton(
//                            icon: Icon(
//                              Icons.play_arrow,
//                              size: 50,
//                              color: Colors.white,
//                            ),
//                            onPressed: (){},
//                          ),
//                        ),
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
                                dataTime: videoData.created,
                                color: Colors.white,
                              ),
                            ),
                            TitleWidget(
                              title: videoData.title,
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

