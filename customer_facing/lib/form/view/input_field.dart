import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.counterText,
    this.icon,
    required this.textHint,
    this.changeOn,
    required this.textInputType,
    this.validator,
    this.txtController,
  }) : super(key: key);
  final TextEditingController? txtController;
  final String? counterText;
  final String textHint;
  final Function(String)? changeOn;
  final TextInputType textInputType;
  final IconData? icon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: txtController,
      validator: validator,
      keyboardType: textInputType,
      style: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: const Color(0xff1B1B1B)),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffED1846),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffED1846),
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        counterStyle: const TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
        counterText: counterText,
        prefixIcon: Icon(icon, color: const Color(0xff1B1B1B)),
        helperMaxLines: 2,
        hintText: textHint,
        hintStyle: Theme.of(context).textTheme.overline,
        errorMaxLines: 2,
      ),
      onChanged: changeOn,
      // textInputAction: TextInputAction.,
    );
  }
}
