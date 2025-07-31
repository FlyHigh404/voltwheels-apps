import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String? image;
  const BackgroundImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image ?? ''),
          ),
        ),
      ),
    );
  }
}
