import 'package:flutter/material.dart';
import 'albumsPanel.dart';
import 'package:app/logic/spotifyBloc.dart';
import 'package:app/logic/spotifyEvents.dart';
import 'package:spotify_sdk/models/player_state.dart';

class MusicController extends StatefulWidget {
  
  final double width;
  final double height;
  final SpotifyController spotifyController;

  const MusicController({
    required this.width,
    required this.height,
    required this.spotifyController,
    Key? key,
  }) : super(key: key);

  @override
  _MusicControllerState createState() => _MusicControllerState();
}

class _MusicControllerState extends State<MusicController> {

  bool isPaused = false;

  // This function will shuffle the tracks
  void toggleShuffle() {
    ToggleShuffle event = ToggleShuffle();
    widget.spotifyController.add(event);
  }

  // This function will play the previous track
  void previousTrack() {
    SkipPrevious event = SkipPrevious();
    widget.spotifyController.add(event);
  }

  // This function will play/pause the current track
  void playPause() {
    if (isPaused) {
      SpotifyEvents event = Resume();
      widget.spotifyController.add(event);
      setState(() {
        isPaused = false;
      });
    } else {
      SpotifyEvents event = Pause();
      widget.spotifyController.add(event);
      setState(() {
        isPaused = true;
      });
    }
  }

  // This function will play the next track
  void nextTrack() {
    SkipNext event = SkipNext();
    widget.spotifyController.add(event);
  }

  // This function will show a list of recommended albums
  void showAlbums(BuildContext context, double width, double height) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          children: [
            AlbumsPanel(
              width: width,
              height: height,
              spotifyController: widget.spotifyController,
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      width: widget.width * 0.9,
      child: StreamBuilder(
        stream: widget.spotifyController.playerState,
        builder: (context, AsyncSnapshot<PlayerState> snapshot) {
          if (snapshot.data != null) {
            PlayerState playerState = snapshot.data!;
            isPaused = playerState.isPaused;
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.shuffle_rounded,
                  color: Colors.green[600],
                  size: widget.width * 0.1,
                ),
                onTap: () => toggleShuffle(),
              ),
              GestureDetector(
                child: Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.green[600],
                  size: widget.width * 0.1,
                ),
                onTap: () => previousTrack(),
              ),
              GestureDetector(
                child: Icon(
                  isPaused ? Icons.play_arrow_rounded : Icons.pause,
                  color: Colors.green[600],
                  size: widget.width * 0.1,
                ),
                onTap: () => playPause(),
              ),
              GestureDetector(
                child: Icon(
                  Icons.skip_next_rounded,
                  color: Colors.green[600],
                  size: widget.width * 0.1,
                ),
                onTap: () => nextTrack(),
              ),
              GestureDetector(
                child: Icon(
                  Icons.library_music_rounded,
                  color: Colors.green[600],
                  size: widget.width * 0.1,
                ),
                onTap: () => showAlbums(context, widget.width, widget.height),
              ),
            ],
          );
        }
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100.0)
      ),
    );
  }
}
