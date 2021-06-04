import 'package:app/widgets/trackPanel.dart';
import 'package:flutter/material.dart';
import 'package:app/logic/spotifyBloc.dart';
import 'package:app/logic/spotifyEvents.dart';
import 'package:app/widgets/connecting.dart';
import 'package:app/widgets/musicController.dart';
import 'package:spotify_sdk/models/connection_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late SpotifyController spotifyController;
  bool connected = false;

  void initState() {
    spotifyController = SpotifyController();
    super.initState();
    SpotifyEvents event = ConnectToSpotify();
    spotifyController.add(event);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: StreamBuilder(
          stream:spotifyController.connectionStatus,
          builder: (context, AsyncSnapshot<ConnectionStatus> snapshot) {
            if (snapshot.data != null) {
              ConnectionStatus status = snapshot.data!;
              if (status.connected) {
                connected = true;
              }
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // If connected display track panel else display connecting
                  connected ? TrackPanel(
                    width: width,
                    height: height,
                    spotifyController: spotifyController,
                  ) : Connecting(width: width, height: height),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
                      width: width * 0.4,
                      child: Text(
                        "Play",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    onTap: () {
                      print("PlayScreen");
                    },
                  ),
                  // If connected display music controller else display connecting
                  connected ? MusicController(
                    width: width,
                    height: height,
                    spotifyController: spotifyController,
                  ) : Connecting(width: width, height: height)
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
