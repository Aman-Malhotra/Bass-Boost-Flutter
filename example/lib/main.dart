import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:bass_boost/bass_boost.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MusicFinder audioPlayer = new MusicFinder();
  BassBoost bassBoost;
  bool enabled = false;
  double strength = 0;
  List<Song> songs;

  @override
  void initState() {
    super.initState();


    songs = [];
    MusicFinder.allSongs().then((dynamic s) {
      songs = s;
      audioPlayer.play(songs[0].uri);
      setState((){});
      audioPlayer.getAudioSessionId().then((int i){
        print("Initialized");
        initAudioSessionId(id: i);
        updateBassEnabled();
        updateBassStrength();
      });
    });
  }

  initAudioSessionId({@required int id}) {
    bassBoost = new BassBoost(
      audioSessionId: id,
    );
  }

  updateBassEnabled() {
    bassBoost.getEnabled().then((bool b) {
      enabled = b;
      setState(() {});
    });
  }

  updateBassStrength() {
    bassBoost.getStrength().then((int i) {
      strength = i.toDouble();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal, brightness: Brightness.dark),
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.speaker_phone,
              size: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "ENJOY THE BASS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0),
                ),
                Switch(
                  onChanged: (bool b) {
                    bassBoost.setEnabled(enabled: b);
                    updateBassEnabled();
                  },
                  value: enabled,
                ),
              ],
            ),
            Slider(
              value: strength,
              onChanged: (d) {
                bassBoost.setStrength(strength: d.toInt());
                updateBassStrength();
              },
              min: 0,
              max: 1000,
              divisions: 1000,
              label: strength.toInt().toString(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: OutlineButton(
                onPressed: () {
                  exit(0);
                },
                child: Text("Exit the app"),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
