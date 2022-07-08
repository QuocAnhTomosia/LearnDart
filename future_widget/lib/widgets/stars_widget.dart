import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  int star = 0;
  RatingStar({Key? key, required int star}) : super(key: key) {
    this.star = star;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          i < star
              ? Icon(
                  Icons.star,
                  color: Colors.yellow,
                )
              : Icon(
                  Icons.star_outline,
                  color: Colors.yellow,
                ),
      ],
    );
  }
}