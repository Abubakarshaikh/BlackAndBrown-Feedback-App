import 'package:feedo_ui/feedo_ui.dart';
import 'package:flutter/material.dart';

class QuestionTitle extends StatelessWidget {
  final String questionTitle;
  const QuestionTitle({
    required this.questionTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      questionTitle,
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(color: FeedoColors.white, fontWeight: FeedoFontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
