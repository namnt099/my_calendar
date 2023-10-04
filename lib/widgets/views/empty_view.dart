import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';

class EmptyView extends StatelessWidget {
  final String? _message;

  const EmptyView(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _message ?? '',
        style: textNormal(AppTheme.getInstance().dfTxtColor(), 16),
      ),
    );
  }
}
