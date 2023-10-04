import 'package:flutter/material.dart';
import 'package:my_calendar/config/themes/app_theme.dart';

class ButtonBottom extends StatelessWidget {
  final Function onPressed;
  final String text;

  const ButtonBottom({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: AppTheme.getInstance().primaryColor(),
        child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
