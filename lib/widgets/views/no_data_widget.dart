import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/generated/l10n.dart';

class NodataWidget extends StatelessWidget {
  const NodataWidget({Key? key, this.height}) : super(key: key);
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Colors.transparent,
      child: Center(
        child: Text(
          S.current.no_data,
          style: textNormal(
            AppTheme.getInstance().getBlackText(),
            14,
          ),
        ),
      ),
    );
  }
}
