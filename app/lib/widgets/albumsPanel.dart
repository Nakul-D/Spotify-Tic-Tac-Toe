import 'package:flutter/material.dart';

class AlbumsPanel extends StatelessWidget {
  final double width;
  final double height;
  const AlbumsPanel({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  // This function will display album
  // When tapped the album will be played
  Widget album(int index) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width * 0.2,
          height: width * 0.2,
          decoration: BoxDecoration(
            color: Colors.green[600],
          ),
        ),
      ),
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
            "Taylor's collection",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold
            ),
          ),
          Container(
            width: width * 0.5,
            height: width * 0.5,
            child: GridView.builder(
              itemCount: 4,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return album(index);
              }
            ),
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
