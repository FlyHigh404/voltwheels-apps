import 'package:flutter/material.dart';
import 'package:voltwheels_mobile/core/theme/app_pallete.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLength = 100,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textToShow = _isExpanded
        ? widget.text
        : '${widget.text.substring(0, widget.trimLength)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Text(
            textToShow,
            style: const TextStyle(
              fontSize: 13,
              color: AppPallete.blackGrayColor,
            ),
          ),
        ),
        GestureDetector(
          onTap: _toggleExpanded,
          child: Text(
            _isExpanded ? 'Tutup' : 'Selengkapnya',
            style: const TextStyle(
              fontSize: 12,
              color: AppPallete.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
