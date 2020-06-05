import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/widgets/player/video_player_page_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatelessWidget {
  final VideosGalleryModel videoData;
  VideoPlayerPage({@required this.videoData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoPlayerPageViewModel>.reactive(
      builder: (context, model, child) => OrientationBuilder(
          builder: (context, orientation) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: Orientation.portrait == orientation ? AppBar(
                title: Text(videoData.title, style: TextStyle(color: Colors.white),),
                automaticallyImplyLeading: true,
                backgroundColor: Colors.black,
              ) : null,
              //body: MyHomePage(),
              //body: MyHomePage(),
              body: Center(
                child: YoutubePlayer(
                  controlsTimeOut: Duration(seconds: 60),
                  onReady: () => model.playerReady = true,
                  controller: model.controller,
                  showVideoProgressIndicator: true,
                  thumbnailUrl: videoData.previewUrl,
                  topActions: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container()
                    ),
                    Icon(Icons.volume_mute, color: Colors.white, size: 25),
                    Expanded(
                      flex: 6,
                      child: Slider(
                        inactiveColor: Colors.grey,
                        activeColor: Colors.white,
                        value: model.volume,
                        min: 0.0,
                        max: 100.0,
                        onChanged: (newValue) => model.changeVolume(newValue),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container()
                    ),
                  ],
//                bottomActions: <Widget>[
//                  Expanded(
//                    flex: 1,
//                    child: IconButton(
//                      icon: Icon(Icons.volume_mute, color: Colors.white, size: 30),
//                    ),
//                  ),
//                  Expanded(
//                    flex: 2,
//                    child: Container(
//                      color: Colors.grey,
//                      child: Slider(
//                        inactiveColor: Colors.grey,
//                        activeColor: Colors.white,
//                        value: model.volume,
//                        min: 0.0,
//                        max: 100.0,
//                        divisions: 10,
//                        label: '${(model.volume).round()}',
//                        onChanged: (newValue) => model.changeVolume(newValue),
//                      ),
//                    )
//                  ),
//                  Expanded(
//                    flex: 4,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(Icons.skip_previous, color: Colors.white, size: 30,),
////                      onPressed: _isPlayerReady
////                          ? () => _controller.load(_ids[
////                      (_ids.indexOf(_controller.metadata.videoId) - 1) %
////                          _ids.length])
////                          : null,
//                        ),
//
//                        IconButton(
//                          icon: Icon(
//                            model.controller.value.isPlaying
//                                ? Icons.pause
//                                : Icons.play_arrow,
//                            color: Colors.white,
//                            size: 40,
//                          ),
//                          onPressed: () => model.playOrPause(),
//                        ),
//
//                        IconButton(
//                          icon: Icon(Icons.skip_next, color: Colors.white, size: 30,),
////                      onPressed: _isPlayerReady
////                          ? () => _controller.load(_ids[
////                      (_ids.indexOf(_controller.metadata.videoId) + 1) %
////                          _ids.length])
////                          : null,
//                        ),
//                      ],
//                    ),
//                  ),
//                  Expanded(
//                    flex: 2,
//                    child: Container(
////                      margin: EdgeInsets.only(left: 60),
////                      child: IconButton(
////                        icon: Icon(Icons.fullscreen, color: Colors.white, size: 30,),
////                        onPressed: () {
////                          SystemChrome.setPreferredOrientations([
//////                            DeviceOrientation.landscapeRight,
////                            DeviceOrientation.portraitUp,
////                          ]);
////                        },
////                      ),
//                    )
//                  ),
//                  Expanded(
//                      flex: 1,
//                      child: IconButton(
//                        icon: Icon(Icons.fullscreen, color: Colors.white, size: 30,),
//                        onPressed: () {
////                          SystemChrome.setPreferredOrientations([
//////                            DeviceOrientation.landscapeRight,
////                            DeviceOrientation.portraitUp,
////                          ]);
//                        },
//                      ),
//                  ),
//                ],
                ),
              )
            );
          }
      ),
      viewModelBuilder: () => VideoPlayerPageViewModel(videoData: videoData),
    );
  }
}

/// Homepage
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [
    'nPt8bK2gbaU',
    'qiYKD1FZ5YM',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/ypf.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        title: Text(
          'Youtube Player Flutter',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.video_library),
//            onPressed: () => Navigator.push(
//              context,
//              CupertinoPageRoute(
//                builder: (context) => VideoList(),
//              ),
//            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            topActions: <Widget>[
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 25.0,
                ),
                onPressed: () {
                  _showSnackBar('Settings Tapped!');
                },
              ),
            ],
            onReady: () {
              _isPlayerReady = true;
            },
            onEnded: (data) {
              _controller
                  .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
              _showSnackBar('Next Video Started!');
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _space,
                _text('Title', _videoMetaData.title),
                _space,
                _text('Channel', _videoMetaData.author),
                _space,
                _text('Video Id', _videoMetaData.videoId),
                _space,
                Row(
                  children: [
                    _text(
                      'Playback Quality',
                      _controller.value.playbackQuality,
                    ),
                    Spacer(),
                    _text(
                      'Playback Rate',
                      '${_controller.value.playbackRate}x  ',
                    ),
                  ],
                ),
                _space,
                TextField(
                  enabled: _isPlayerReady,
                  controller: _idController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter youtube \<video id\> or \<link\>',
                    fillColor: Colors.blueAccent.withAlpha(20),
                    filled: true,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.blueAccent,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _idController.clear(),
                    ),
                  ),
                ),
                _space,
                Row(
                  children: [
                    _loadCueButton('LOAD'),
                    SizedBox(width: 10.0),
                    _loadCueButton('CUE'),
                  ],
                ),
                _space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: _isPlayerReady
                          ? () => _controller.load(_ids[
                      (_ids.indexOf(_controller.metadata.videoId) - 1) %
                          _ids.length])
                          : null,
                    ),
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      onPressed: _isPlayerReady
                          ? () {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                        setState(() {});
                      }
                          : null,
                    ),
                    IconButton(
                      icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                      onPressed: _isPlayerReady
                          ? () {
                        _muted
                            ? _controller.unMute()
                            : _controller.mute();
                        setState(() {
                          _muted = !_muted;
                        });
                      }
                          : null,
                    ),
                    FullScreenButton(
                      controller: _controller,
                      color: Colors.blueAccent,
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: _isPlayerReady
                          ? () => _controller.load(_ids[
                      (_ids.indexOf(_controller.metadata.videoId) + 1) %
                          _ids.length])
                          : null,
                    ),
                  ],
                ),
                _space,
                Row(
                  children: <Widget>[
                    Text(
                      "Volume",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Expanded(
                      child: Slider(
                        inactiveColor: Colors.transparent,
                        value: _volume,
                        min: 0.0,
                        max: 100.0,
                        divisions: 10,
                        label: '${(_volume).round()}',
                        onChanged: _isPlayerReady
                            ? (value) {
                          setState(() {
                            _volume = value;
                          });
                          _controller.setVolume(_volume.round());
                        }
                            : null,
                      ),
                    ),
                  ],
                ),
                _space,
                AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: _getStateColor(_playerState),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    _playerState.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
          if (_idController.text.isNotEmpty) {
            var id = YoutubePlayer.convertUrlToId(
              _idController.text,
            );
            if (action == 'LOAD') _controller.load(id);
            if (action == 'CUE') _controller.cue(id);
            FocusScope.of(context).requestFocus(FocusNode());
          } else {
            _showSnackBar('Source can\'t be empty!');
          }
        }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}