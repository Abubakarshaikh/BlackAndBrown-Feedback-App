import 'package:admin/filter/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConditionRadioButton extends StatelessWidget {
  final Condition condition;
  const ConditionRadioButton({Key? key, required this.condition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          groupValue: condition,
          value: Condition.all,
          onChanged: (Condition? newValue) {
            context
                .read<FilterBloc>()
                .add(FilterUpadateCondition(updateCondition: newValue!));
          },
        ),
        Text("All", style: Theme.of(context).textTheme.bodyText1),
        Radio(
          groupValue: condition,
          value: Condition.major,
          onChanged: (Condition? newValue) {
            context
                .read<FilterBloc>()
                .add(FilterUpadateCondition(updateCondition: newValue!));
          },
        ),
        Text("Major", style: Theme.of(context).textTheme.bodyText1),
        Radio(
          groupValue: condition,
          value: Condition.critical,
          onChanged: (Condition? newValue) {
            context
                .read<FilterBloc>()
                .add(FilterUpadateCondition(updateCondition: newValue!));
          },
        ),
        Text("Critical", style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
