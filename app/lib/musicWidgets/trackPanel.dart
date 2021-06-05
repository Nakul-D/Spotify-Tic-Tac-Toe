import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:app/logic/spotifyBloc.dart';
import 'package:spotify_sdk/models/player_state.dart';

class TrackPanel extends StatefulWidget {
  final double width;
  final double height;
  final SpotifyController spotifyController;
  const TrackPanel({
    required this.width,
    required this.height,
    required this.spotifyController,
    Key? key,
  }) : super(key: key);

  @override
  _TrackPanelState createState() => _TrackPanelState();
}

class _TrackPanelState extends State<TrackPanel> {

  String track = "Unknown";
  String artist = "Unknown";
  String imageUri = "Undefined";

  // This function will display an album
  Widget album(String uri) {
    return FutureBuilder(
      future: getImage(uri),
      builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.data != null) {
          return Image.memory(snapshot.data!, fit: BoxFit.cover);
        }
        return Text("");
      },
    );
  }

  // This function trim strings above 20 characters in length
  String trimmedText(String rawText) {
    if (rawText.length > 16) {
      return "${rawText.substring(0, 16)}...";
    } else {
      return rawText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.9,
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: widget.width * 0.1),
      child: StreamBuilder(
        stream: widget.spotifyController.playerState,
        builder: (context, AsyncSnapshot<PlayerState> snapshot) {
          if (snapshot.data != null) {
            PlayerState playerState = snapshot.data!;
            if (playerState.track != null) {
              track = playerState.track!.name;
              artist = playerState.track!.artist.name;
              imageUri = playerState.track!.imageUri.raw;
            }
          }
          return Row(
            children: [
              Container(
                width: widget.width * 0.17,
                height: widget.width * 0.17,
                color: Colors.green[600],
                child: album(imageUri),
              ),
              SizedBox(width: widget.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trimmedText(track),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.width * 0.05,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: widget.width * 0.03),
                  Text(
                    trimmedText(artist),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.width * 0.05,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}
