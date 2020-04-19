import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/ui_helper.dart';
import 'package:flutter_sound/flauto.dart';
import 'package:flutter_sound/flutter_sound_player.dart';
import 'package:flutter_sound/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;

class FlutterSoundRecoder extends StatefulWidget {
  @override
  _FlutterSoundRecoderState createState() => _FlutterSoundRecoderState();
}

class _FlutterSoundRecoderState extends State<FlutterSoundRecoder> {
  FlutterSoundRecorder recorderModule;
  FlutterSoundPlayer playerModule;
  t_CODEC _codec = t_CODEC.CODEC_AAC;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  String _recorderTxt = "";
  bool _isRecording = false;
  String path;
  double _dbLevel = 32;

  void initData() async {
    recorderModule = await FlutterSoundRecorder().initialize();
    playerModule = await FlutterSoundPlayer().initialize();
  }

  void startRecording() async {
    Directory tempDir = await getTemporaryDirectory();

    path = await recorderModule.startRecorder(
      uri: '${tempDir.path}/${recorderModule.slotNo}',
      codec: _codec,
    );
    this.setState(() {
      this._isRecording = true;
    });

    _recorderSubscription = recorderModule.onRecorderStateChanged.listen((e) {
      if (e != null && e.currentPosition != null) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt(), isUtc: true);
        String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      }
    });

    _dbPeakSubscription = recorderModule.onRecorderDbPeakChanged.listen((value) {
      print("got update -> $value");
      setState(() {
        this._dbLevel = value;
      });
    });
  }

  void stopRecording() async {
    String result = await recorderModule.stopRecorder();
    print('stopRecorder: $result');

    this.setState(() {
      this._isRecording = true;
    });
  }

  void playSound() {
    if (path != null) {
      playerModule.startPlayer(path);
    }
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }
    if (_dbPeakSubscription != null) {
      _dbPeakSubscription.cancel();
      _dbPeakSubscription = null;
    }
  }

  Future<void> releaseFlauto() async {
    try {
      await playerModule.release();
      await recorderModule.release();
    } catch (e) {
      print('Released unsuccessful');
      print(e);
    }
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    cancelRecorderSubscriptions();
    releaseFlauto();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Sound Recorder"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_dbLevel != null)
              ClipOval(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 50),
                  color: Colors.red,
                  width: _dbLevel,
                  height: _dbLevel,
                  alignment: Alignment.center,
                  child: Text(_dbLevel.toStringAsFixed(2)),
                ),
              ),
            UIHelper.verticalSpace(24),
            Text(_recorderTxt),
            UIHelper.verticalSpace(24),
            RaisedButton(
              onPressed: () async {
                if (_isRecording) {
                  stopRecording();
                } else {
                  startRecording();
                }
              },
              child: Text(_isRecording ? "Stop Recording" : "Start Recording"),
            ),
            RaisedButton(
              onPressed: playSound,
              child: Text("Play Sound"),
            ),
          ],
        ),
      ),
    );
  }
}
