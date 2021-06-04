import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:app/logic/spotifyEvents.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/connection_status.dart';

const String clientId = '';
const String redirectUrl = '';

class SpotifyController extends Bloc<SpotifyEvents, dynamic> {

  SpotifyController() : super(null);

  Stream<ConnectionStatus> connectionStatus = SpotifySdk.subscribeConnectionStatus();
  Stream<PlayerState> playerState = SpotifySdk.subscribePlayerState();

  @override
  Stream<dynamic> mapEventToState(SpotifyEvents event) async* {

    if (event is ConnectToSpotify) {
      yield _connectToSpotifyRemote();
    }

    if (event is PlayAlbum) {
      _play(event.uri);
    }

    if (event is Resume) {
      _resume();
    }

    if (event is Pause) {
      _pause();
    }

    if (event is SkipNext) {
      _skipNext();
    }

    if (event is SkipPrevious) {
      _skipPrevious();
    }

    if (event is ToggleShuffle) {
      _toggleShuffle();
    }

  }
}

// Connect to spotify
Future<bool> _connectToSpotifyRemote() async {
  try {
    bool result = await SpotifySdk.connectToSpotifyRemote(
      clientId: clientId,
      redirectUrl: redirectUrl,
    );
    return result;
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
    return false;
  } on MissingPluginException {
    return false;
  }
}

// Play a new track
Future<void> _play(String uri) async {
  try {
    await SpotifySdk.play(spotifyUri: uri);
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
  } on MissingPluginException {
    print('Error');
  }
}

// Resume playing track
Future<void> _resume() async {
  try {
    await SpotifySdk.resume();
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
  } on MissingPluginException {
    print('Error');
  }
}

// Pause playing track
Future<void> _pause() async {
  try {
    await SpotifySdk.pause();
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
  } on MissingPluginException {
    print('Error');
  }
}

// Shuffle the tracks
Future<void> _toggleShuffle() async {
  try {
    await SpotifySdk.toggleShuffle();
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
  } on MissingPluginException {
    print('Error');
  }
}

// Skip to previous track
Future<void> _skipPrevious() async {
  try {
    await SpotifySdk.skipPrevious();
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
  } on MissingPluginException {
    print('Error');
  }
}

// Skip to next track
Future<void> _skipNext() async {
  try {
    await SpotifySdk.skipNext();
  } on PlatformException catch (e) {
    print('${e.code} :${ e.message}');
  } on MissingPluginException {
    print('Error');
  }
}

// Get image of the current track
Future<Uint8List?> getImage(String imageUri) async {
  Uint8List? image = await SpotifySdk.getImage(imageUri: ImageUri(imageUri), dimension: ImageDimension.large);
  return image;
}
