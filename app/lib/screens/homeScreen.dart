import 'package:flutter/material.dart';
import 'package:app/logic/spotifyBloc.dart';
import 'package:app/logic/spotifyEvents.dart';
import 'package:app/widgets/musicController.dart';
import 'package:spotify_sdk/models/connection_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late SpotifyController spotifyController;

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Tic Tac Toe",
                    style: TextStyle(
                      color: Colors.green[600],
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "- Nakul Dighe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(),
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
              SizedBox(),
              StreamBuilder(
                stream: spotifyController.connectionStatus,
                builder: (context, AsyncSnapshot<ConnectionStatus> snapshot) {
                  if (snapshot.data != null) {
                    ConnectionStatus status = snapshot.data!;
                    if (status.connected) {
                      return MusicController(
                        width: width,
                        height: height,
                        spotifyController: spotifyController,
                      );
                    }
                  }
                  return Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    width: width * 0.9,
                    child: Center(
                      child: Text(
                        "Connecting to spotify...",
                        style: TextStyle(
                          color: Colors.green[600],
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100.0)
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
