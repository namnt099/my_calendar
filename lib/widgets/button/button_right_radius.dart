import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';

class ButtonRight extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final Function onPressed;
  final Color? titleColor;

  const ButtonRight({
    Key? key,
    required this.title,
    required this.gradient,
    required this.onPressed,
    this.titleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Text(
              title,
              style: textNormalCustom(
                color: titleColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
