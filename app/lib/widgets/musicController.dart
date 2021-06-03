import 'package:flutter/material.dart';
import 'albumsPanel.dart';

class MusicController extends StatefulWidget {
  final double width;
  final double height;
  const MusicController({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  _MusicControllerState createState() => _MusicControllerState();
}

class _MusicControllerState extends State<MusicController> {

  bool isLiked = false;
  bool isPlaying = false;

  // This function will like/dislike the current track
  void like() {
    if (isLiked) {
      setState(() {
        isLiked = false;
      });
    } else {
      setState(() {
        isLiked = true;
      });
    }
  }

  // This function will play the previous track
  void previousTrack() {}

  // This function will play/pause the current track
  void playPause() {
    if (isPlaying) {
      setState(() {
        isPlaying = false;
      });
    } else {
      setState(() {
        isPlaying = true;
      });
    }
  }

  // This function will play the next track
  void nextTrack() {}

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
              height: height
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Icon(
              isLiked ? Icons.favorite : Icons.favorite_outline_rounded,
              color: Colors.green[600],
              size: widget.width * 0.07,
            ),
            onTap: () => like(),
          ),
          GestureDetector(
            child: Icon(
              Icons.skip_previous_rounded,
              color: Colors.green[600],
              size: widget.width * 0.07,
            ),
            onTap: () => previousTrack(),
          ),
          GestureDetector(
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow_rounded,
              color: Colors.green[600],
              size: widget.width * 0.07,
            ),
            onTap: () => playPause(),
          ),
          GestureDetector(
            child: Icon(
              Icons.skip_next_rounded,
              color: Colors.green[600],
              size: widget.width * 0.07,
            ),
            onTap: () => nextTrack(),
          ),
          GestureDetector(
            child: Icon(
              Icons.library_music_rounded,
              color: Colors.green[600],
              size: widget.width * 0.07,
            ),
            onTap: () => showAlbums(context, widget.width, widget.height),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100.0)
      ),
    );
  }
}
