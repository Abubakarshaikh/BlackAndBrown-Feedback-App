import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color textColor;
  final Color? buttonColor;
  final String textValue;
  final ThemeData theme;
  final VoidCallback? onEvent;
  const CustomPrimaryButton({
    Key? key,
    this.buttonColor,
    this.textColor = const Color(0xff1B1B1B),
    required this.textValue,
    required this.theme,
    required this.onEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      elevation: 0,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: buttonColor ?? const Color(0xffFFD800),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onEvent,
            borderRadius: BorderRadius.circular(14.0),
            child: Center(
              child: Text(
                textValue,
                style: theme.textTheme.button!.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
