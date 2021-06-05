import 'package:flutter/material.dart';

class Connecting extends StatelessWidget {

  final double width;
  final double height;
  const Connecting({
    required this.width,
    required this.height,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
