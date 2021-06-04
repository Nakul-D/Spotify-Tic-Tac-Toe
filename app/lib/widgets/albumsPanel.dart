import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:app/logic/spotifyBloc.dart';
import 'package:app/logic/spotifyEvents.dart';

class AlbumsPanel extends StatelessWidget {
  final double width;
  final double height;
  final SpotifyController spotifyController;
  const AlbumsPanel({
    required this.width,
    required this.height,
    required this.spotifyController,
    Key? key,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.7,
      height: width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Recommended",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            width: width * 0.3,
            height: width * 0.3,
            color: Colors.green[600],
            child: album("spotify:image:ab67616d0000b273b7e976d2b35c767f9012cb72"),
          ),
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
              width: width * 0.3,
              child: Text(
                "Play",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            onTap: () {
              PlayAlbum event = PlayAlbum(uri: "spotify:album:5fy0X0JmZRZnVa2UEicIOl");
              spotifyController.add(event);
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(30.0)
      ),
    );
  }
}
