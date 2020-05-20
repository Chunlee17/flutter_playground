// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class AudioPlayerDemo extends StatefulWidget {
//   @override
//   _AudioPlayerDemoState createState() => _AudioPlayerDemoState();
// }

// class _AudioPlayerDemoState extends State<AudioPlayerDemo>
//     with SingleTickerProviderStateMixin {
//   final String url = "https://www.chunleethong.com/vannda.mp3";
//   AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
//   AudioPlayerState playerState = AudioPlayerState.STOPPED;
//   double value = 0;
//   Duration maxDuration = Duration.zero;
//   Duration currentDuration = Duration.zero;
//   AnimationController animationController;

//   void playAudio() async {
//     try {
//       int result = await audioPlayer.play(
//         url,
//         stayAwake: true,
//       );
//       if (result == 1) {
//         animationController.repeat();
//         print("Audio playing");
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void pauseAudio() async {
//     try {
//       animationController.stop();
//       int result = await audioPlayer.pause();
//       if (result == 1) {
//         print("Audio pause");
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   String formatDuration(Duration duration) {
//     String twoDigits(int n) {
//       if (n >= 10) return "$n";
//       return "0$n";
//     }

//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//   }

//   @override
//   void initState() {
//     audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
//       print('Current player state: $state');
//       if (state == AudioPlayerState.COMPLETED) animationController.stop();
//       setState(() => playerState = state);
//     });
//     audioPlayer.onAudioPositionChanged.listen((Duration p) {
//       setState(() {
//         this.value = p.inSeconds.toDouble();
//         currentDuration = p;
//       });
//     });
//     audioPlayer.onDurationChanged.listen((Duration d) {
//       setState(() {
//         maxDuration = d;
//       });
//     });
//     animationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 4));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Audio Player"),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 32),
//               child: Text("Vannda - J+O",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             ),
//             RotationTransition(
//               alignment: Alignment.center,
//               turns: animationController,
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                   border: Border.all(width: 5.0, color: Colors.pink),
//                   image: DecorationImage(
//                       image: AssetImage("assets/vannda.jpg"),
//                       fit: BoxFit.cover),
//                 ),
//               ),
//             ),
//             SizedBox(height: 32),
//             Row(
//               children: <Widget>[
//                 Text(formatDuration(currentDuration)),
//                 Expanded(
//                   child: Slider(
//                     min: 0.0,
//                     max: maxDuration.inSeconds.toDouble(),
//                     value: value,
//                     onChanged: (duration) {
//                       Duration seekDuration =
//                           Duration(seconds: duration.floor());
//                       audioPlayer.seek(seekDuration);
//                     },
//                   ),
//                 ),
//                 Text(formatDuration(maxDuration)),
//               ],
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: buildIcon(),
//     );
//   }

//   Widget buildIcon() {
//     if (playerState == AudioPlayerState.COMPLETED ||
//         playerState == AudioPlayerState.PAUSED ||
//         playerState == AudioPlayerState.STOPPED) {
//       return FloatingActionButton(
//         onPressed: playAudio,
//         child: Icon(Icons.play_arrow),
//       );
//     } else
//       return FloatingActionButton(
//         onPressed: pauseAudio,
//         child: Icon(Icons.pause),
//       );
//   }
// }
