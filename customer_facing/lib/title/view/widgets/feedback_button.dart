import 'package:flutter/material.dart';

class FeedbackButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPushed;
  const FeedbackButton(
      {Key? key,
      required this.title,
      required this.onPushed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(60, 60),
        primary: color,
        shadowColor: const Color(0xff1B1B1B),
        shape: const CircleBorder(),
      ),
      onPressed: onPushed,
      child: Text(
        title,
      ),
    );
  }
}
