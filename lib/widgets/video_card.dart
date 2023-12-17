import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double thumbnailWidth = MediaQuery.of(context).size.width * 0.30;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://cdn.britannica.com/26/84526-050-45452C37/Gateway-monument-India-entrance-Mumbai-Harbour-coast.jpg",
                width: thumbnailWidth,
              ),
            ),
            const Positioned(
              bottom: 5,
              right: 8,
              child: Icon(Icons.play_circle),
            )
          ])
        ],
      ),
    );
  }
}
