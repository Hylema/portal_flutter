import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/data/storage/storage.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/widgets/player/video_player_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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







class VideoGalleryItemWidget extends StatelessWidget {
  VideoGalleryItemWidget({
    @required this.videoData,
  }){
    assert(this.videoData != null);
  }
  final VideosGalleryModel videoData;
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final Storage storage = getIt<Storage>();

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
                    headers: {
                      'Accept': 'application/json',
                      'Authorization': 'Bearer ${storage.token}',
                    },
                    appBar: AppBar(
                      automaticallyImplyLeading: true,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                )
            );
//            videoData.fromYoutube() ? Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => VideoPlayerPage(videoData: videoData,)
//                )
//            ) : Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => WebviewScaffold(
//                      url: videoData.videoUrl,
//                      headers: {
//                        'Accept': 'application/json',
//                        'Authorization': 'Bearer ${storage.token}',
//                      },
//                      appBar: AppBar(
//                        automaticallyImplyLeading: true,
//                        backgroundColor: Colors.transparent,
//                      ),
//                    ),
//                )
//            );
          },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
                children: <Widget>[
                  videoData.getPreviewUrl() != null ? Image.network(
                    '${videoData.getPreviewUrl()}',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ) :  Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/metInvestIcon.png',
                      fit: BoxFit.fill,
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
                        Text(
                          videoData.title,
                          overflow: TextOverflow.fade,
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}

