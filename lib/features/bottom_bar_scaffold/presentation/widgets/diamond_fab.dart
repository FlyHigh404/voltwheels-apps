import 'package:flutter/material.dart';
import 'package:voltwheels_mobile/core/assets/assets.dart';

class DiamondFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const DiamondFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 150,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Transform.rotate(
          angle: 180,
          child: Image.asset(
            Assets.bolt,
            width: 20,
          ),
        ),
      ),
    );
  }
}

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(width / 2, 0);
    path.lineTo(width, height / 2);
    path.lineTo(width / 2, height);
    path.lineTo(0, height / 2);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
