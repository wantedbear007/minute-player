import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final double thumbnailWidth = MediaQuery.of(context).size.width * 0.30;

    return InkWell(
      onTap: () {
        print("helloo");
      },
      child: Container(
        padding: const EdgeInsets.only(top: 6,bottom: 6, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://cdn.britannica.com/26/84526-050-45452C37/Gateway-monument-India-entrance-Mumbai-Harbour-coast.jpg",
                      width: thumbnailWidth,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  right: 8,
                  child: Icon(Icons.play_circle, color: Colors.white,),
                ),
              ],
            ),
            Flexible(
              child: Column(
                children: [
                  Text(
                    "1. Harry Potter and the Sorcerer's Stone 2001 Extended 1080p 10Bit",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text("2:38:50 • 1080P • 756 MB", style: TextStyle(color: Theme.of(context).disabledColor),),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
