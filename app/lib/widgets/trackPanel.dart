import 'package:flutter/material.dart';

class TrackPanel extends StatelessWidget {
  final double width;
  final double height;
  const TrackPanel({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: width * 0.1),
      child: Row(
        children: [
          Container(
            width: width * 0.17,
            height: width * 0.17,
            color: Colors.green[600],
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Faded",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: width * 0.03),
              Text(
                "Alan Walker",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}
