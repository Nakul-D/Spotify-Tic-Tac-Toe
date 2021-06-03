import 'package:flutter/material.dart';
import 'package:app/widgets/musicController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
              MusicController(width: width, height: height)
            ],
          ),
        ),
      ),
    );
  }
}
