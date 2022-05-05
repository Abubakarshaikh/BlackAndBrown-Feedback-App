import 'package:flutter/material.dart';

class QuestionListTile extends StatelessWidget {
  final String question;
  final bool isChecked;
  final Function(bool?)? onChanged;
  const QuestionListTile({
    Key? key,
    required this.question,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 1.5,
      contentPadding: const EdgeInsets.only(right: 16.0),
      title: Text(
        question,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: const Color(0xff1B1B1B)),
      ),
      leading: Checkbox(
        fillColor: MaterialStateProperty.all(const Color(0xff1B1B1B)),
        side: const BorderSide(
          color: Color(0xff1B1B1B),
          width: 1.5,
        ),
        checkColor: Colors.white,
        value: isChecked,
        onChanged: onChanged,
      ),
    );
  }
}
