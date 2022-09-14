import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:better_player_example/constant.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   BetterPlayerController? _betterPlayerController;
   BetterPlayerDataSource? _betterPlayerDataSource;
  BetterPlayerTheme? playerTheme;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  final GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
  bool isLoading = true;
  String speedControllerName = '1.0x';
  bool isMusicOn = true;
  Duration? videoProgress = Duration.zero, videoTotalTime = Duration.zero;
  bool isTouched = false;
  bool useSensor = false;
  bool videoNotInitilize = false;
  StreamController<bool> _placeholderStreamController =
      StreamController.broadcast();
  bool _showPlaceholder = true;
   GlobalKey _betterPlayerKey = GlobalKey();
   bool _isPictureInPicture = false;
   String? twoDigitMinutes ;
   String? twoDigitSeconds ;
   String? twoDigitHour;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    playerTheme = BetterPlayerTheme.material;
    betterPlayerConfiguration = BetterPlayerConfiguration(
     /*  aspectRatio: 16 / 9,
       fit: BoxFit.fill,*/
      autoPlay: true,
      looping: false,
      placeholder: _buildVideoPlaceholder(),
      showPlaceholderUntilPlay: true,
     // fullScreenByDefault: true,

      controlsConfiguration: BetterPlayerControlsConfiguration(
        playerTheme: playerTheme!,
        enableSubtitles: false,
        showControls: false,
      ),
    );

    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.forBiggerBlazesUrl,
    );
    _betterPlayerController =
        BetterPlayerController(betterPlayerConfiguration!);
    _betterPlayerController!.setupDataSource(_betterPlayerDataSource!);


    _betterPlayerController!.addEventsListener((element) {
      print(
          'betterPlayerController event calling=>${element.betterPlayerEventType}');
      _onPlayerEvent(element);
      if (element.betterPlayerEventType == BetterPlayerEventType.play) {
        _setPlaceholderVisibleState(false);
      }
    });

  }

    _printDuration(Duration duration) {
      twoDigits(int n) => n.toString().padLeft(2, "0");
      twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      twoDigitHour = twoDigits(duration.inHours.remainder(60));
   //  print("time aaya"+twoDigitSeconds);
   }

  void _setPlaceholderVisibleState(bool hidden) {
    _placeholderStreamController.add(hidden);
    _showPlaceholder = hidden;
  }

  controllerDespose() {
    _betterPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      key: _drawerkey,
      drawer: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, bottom: 5),
              child: Text(
                'playback Speed',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _betterPlayerController!.setSpeed(0.5);
                          setState(() {
                            speedControllerName = '0.5x';
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            '0.5x',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _betterPlayerController!.setSpeed(1.0);
                          setState(() {
                            speedControllerName = '1.0x';
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Normal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _betterPlayerController!.setSpeed(1.5);
                          setState(() {
                            speedControllerName = '1.5x';
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '1.5x',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _betterPlayerController!.setSpeed(1.75);
                          setState(() {
                            speedControllerName = '1.7x';
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '1.75x',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _betterPlayerController!.setSpeed(2.0);
                          setState(() {
                            speedControllerName = '2.0x';
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '2.0x',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                    isTouched = !isTouched;
                  },
                  child: BetterPlayer(controller: _betterPlayerController!, key: _betterPlayerKey,),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: _betterPlayerController!.isBuffering()!? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ): Visibility(
                    visible: _betterPlayerController!.isBuffering()!
                        ? isTouched
                        : !isTouched,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            print("backward clicked");
                            Duration? videoDuration =
                                await _betterPlayerController
                                    !.videoPlayerController!.position;
                            setState(() {
                              if (_betterPlayerController!.isPlaying()!) {
                                Duration rewindDuration = Duration(
                                    seconds: (videoDuration!.inSeconds - 10));
                                if (rewindDuration <
                                    _betterPlayerController
                                        !.videoPlayerController!
                                        .value
                                        .duration!) {
                                  _betterPlayerController
                                      !.seekTo(Duration(seconds: rewindDuration.inSeconds));
                                } else {
                                  _betterPlayerController
                                      !.seekTo(rewindDuration);
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Center(
                                child: Image.asset(
                                  Constants.backward,
                                  color: Colors.white,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("play clicked");
                            setState(() {
                              if (_betterPlayerController!.isPlaying()!){
                                print("play isPlaying");
                                _betterPlayerController!.pause();
                              }
                              else{
                                print("play play");
                                _betterPlayerController!.play();
                              }

                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: Colors.black26,
                              border: Border.all(
                                  width: 1,
                                  style: BorderStyle.none,
                                  color: Colors.black26),
                            ),
                            alignment: Alignment.center,
                            child: (_betterPlayerController!.isBuffering()!
                                   || videoProgress == Duration.zero)
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  )
                                : Icon(
                                    _betterPlayerController!.isPlaying()!
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            print("forward clicked");
                            Duration? videoDuration =
                                await _betterPlayerController
                                    !.videoPlayerController!.position;
                            setState(() {
                              if (_betterPlayerController!.isPlaying()!) {
                                Duration forwardDuration = Duration(
                                    seconds: (videoDuration!.inSeconds + 10));
                                if (forwardDuration >
                                    _betterPlayerController
                                        !.videoPlayerController!
                                        .value
                                        .duration!) {
                                  _betterPlayerController
                                      !.seekTo(Duration(seconds: 0));
                                  _betterPlayerController!.pause();
                                } else {
                                  _betterPlayerController
                                      !.seekTo(forwardDuration);
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            /*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20),),
                    color:Colors.black26,
                    border: Border.all(width: 1,style: BorderStyle.none,color: Colors.black26),
                ),*/
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Center(
                                child: Image.asset(
                                  Constants.forward,
                                  color: Colors.white,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50,right: 10),
                alignment: Alignment.topRight,
                child: _showPlaceholder?SizedBox():counterTimer(),
              ),
              Visibility(
                visible: !isTouched,
                child: Container(
                  // height: 40,
                  color: Colors.black26,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            controllerDespose();
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Dynamic Elevated Pose',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _drawerkey.currentState!.openDrawer();
                            print("its clicked");
                            // _betterPlayerController.setSpeed(0.5);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text(
                              speedControllerName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 2.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            soundToggle();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              isMusicOn == true
                                  ? Icons.music_note
                                  : Icons.music_off,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if(_isPictureInPicture){
                              _betterPlayerController!.enablePictureInPicture(_betterPlayerKey);
                              _isPictureInPicture = !_isPictureInPicture;
                            }else
                              {
                                _betterPlayerController!.disablePictureInPicture();
                              }

                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              !_isPictureInPicture
                                  ? Icons.picture_in_picture_alt_rounded
                                  : Icons.width_normal,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget counterTimer() {
    return CircularPercentIndicator(
      circularStrokeCap: CircularStrokeCap.round,
      percent: videoProgress!.inSeconds / videoTotalTime!.inSeconds,
      animation: false,
      radius: 65,
      lineWidth: 5.0,
      progressColor:Colors.purple.withOpacity(0.4),
      center: Text(
        '$twoDigitHour'+' : '+'$twoDigitMinutes'+' : '+'$twoDigitSeconds',
        style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
      ),
    );
  }

  void soundToggle() {
    setState(() {
      isMusicOn
          ? _betterPlayerController!.setVolume(0.0)
          : _betterPlayerController!.setVolume(1.0);
      isMusicOn = !isMusicOn;
    });
  }

  void _onPlayerEvent(BetterPlayerEvent event) {
    setState(() {
      if(_betterPlayerController!.isPlaying()!){
        if (_checkIfCanProcessPlayerEvent(event)) {
          if (event.parameters!['progress'] != null &&
              event.parameters!['duration'] != null) {
            _printDuration(videoProgress!);
            videoProgress = event.parameters!['progress'];
            videoTotalTime = event.parameters!['duration'];
          } else if (event.parameters!['progress'] != null &&
              event.parameters!['duration'] == null) {
            _printDuration(videoProgress!);
            videoProgress = event.parameters!['progress'];
            videoTotalTime = Duration.zero;
          } else if (event.parameters!['duration'] != null &&
              event.parameters!['progress'] == null) {
            _printDuration(videoProgress!);
            videoTotalTime = event.parameters!['duration'];
            videoProgress = Duration.zero;
          } else {
            _printDuration(videoProgress!);
            videoProgress = Duration.zero;
            videoTotalTime = Duration.zero;
          }
          print('rogress of the video=>${videoProgress}');
          print('duration of the video=>${videoTotalTime}');
        }
      }
    });
  }

  bool _checkIfCanProcessPlayerEvent(BetterPlayerEvent event) {
    return event.betterPlayerEventType == BetterPlayerEventType.progress &&
        event.parameters != null &&
        event.parameters!['progress'] != null &&
        event.parameters!['duration'] != null;
  }

  Widget _buildVideoPlaceholder() {
    return StreamBuilder<bool>(
      stream: _placeholderStreamController.stream,
      builder: (context, snapshot) {
        return _showPlaceholder
            ? Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      child: Image.network(
                        Constants.placeholderUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                ],
              )
            : const SizedBox();
      },
    );
  }
  Widget _circularProgressBar(){
    return CircularProgressIndicator();
  }

   @override
   void dispose() {
     _placeholderStreamController.close();
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.landscapeRight,
       DeviceOrientation.landscapeLeft,
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
     ]);
     super.dispose();
   }
}
