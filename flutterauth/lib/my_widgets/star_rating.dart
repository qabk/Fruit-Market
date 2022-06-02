import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int star;
  const StarRating({Key? key, required this.star}) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 100,
        child: Row(
          children: [
           for(int i = 0; i < widget.star;i++)
           Icon(
              Icons.star,
              color: Colors.yellow,
              size: 12,
            ),
          ],
        ));
  }
}