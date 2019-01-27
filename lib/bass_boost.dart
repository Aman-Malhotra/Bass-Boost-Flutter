import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

/// You can increase the Bass in any playing audio using this class.
/// This plugin uses the android BassBoost class inside the AudioEffects package.
///
/// Initialize the object for this class by passing the audio session id for the playing
/// song as a parameter to the constructor of the class.
///
/// `BassBoost bassBoost = new BassBoost(audioSessionId: id);`
///
/// id = audioSessionId for the playingSong
///
/// The named parameter audioSessionId is a compulsory parameter,
/// without passing any value to this parameter the plugin wont work.
class BassBoost {
  static const MethodChannel _channel = const MethodChannel('bass_boost');


  /// pass the `audioSessionId` of the playing song to this constructor
  /// while initializing the object for this class.
  /// Use the same object to call all other methods.
  BassBoost({@required int audioSessionId}) {
    _initAudioSessionId(audioSessionId);
  }
  _initAudioSessionId(int i) async {
    Map<String, int> map = <String, int>{};
    map.putIfAbsent("audioSessionId", () => i);
    await _channel.invokeMethod('initAudioSessionId', map);
  }

  /// pass a `boolean` value to enable the bass or to diable it.
  ///
  /// setEnabled(enabled: b); will turn on the bass but
  /// the initial setrength will be set to zero
  setEnabled({@required bool enabled}) async {
    Map<String, bool> map = <String, bool>{};
    map.putIfAbsent("enable", () => enabled);
    await _channel.invokeMethod('setEnabled', map);
  }

  /// this will `return a boolean` value indicating whether
  /// the bassBoost is turned on or not.
  Future<bool> getEnabled() async {
    return await _channel.invokeMethod('getEnabled');
  }

  /// pass an `integer` value ranging `[0,1000]` to change the strenght of the bass.
  /// Values less then 0 and greater than 1000 wil be neglected.
  setStrength({@required int strength}) async {
    if (strength >= 0 && strength <= 1000) {
      Map<String, int> map = <String, int>{};
      map.putIfAbsent("strength", () => strength);
      await _channel.invokeMethod('setStrength', map);
    }
  }

  /// this will `return an integer` value indicating
  ///  the current value of the strength of the bass.
  /// the output will range b/w `[0,1000]`.
  Future<int> getStrength() async {
    return await _channel.invokeMethod('getStrength');
  }
}
