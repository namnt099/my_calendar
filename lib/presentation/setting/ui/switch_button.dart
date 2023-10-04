import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';

class SwitchCustom extends StatefulWidget {
  const SwitchCustom({Key? key, required this.title, required this.onToggle})
      : super(key: key);
  final String title;
  final Function(bool) onToggle;

  @override
  State<SwitchCustom> createState() => _SwitchCustomState();
}

class _SwitchCustomState extends State<SwitchCustom> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            widget.title,
            style: textNormalCustom(
              color: AppTheme.getInstance().getBlackText(),
              fontSize: 16,
            ),
          ),
        ),
        Switch(
          value: _value,
          activeColor: AppTheme.getInstance().primaryColor(),
          onChanged: (value) {
            setState(() {
              _value = !_value;
            });
          },
        )
      ],
    );
  }
}
