import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/generated/l10n.dart';

import '../app_button.dart';

class StateErrorView extends StatelessWidget {
  final String? _message;
  final Function() _retry;
  final String? title;

  const StateErrorView(this._message, this._retry, {Key? key, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _message ?? S.current.something_went_wrong,
              style: textNormal(null, 14),
            ),
            spaceH15,
            AppButton(
              S.of(context).retry,
              _retry,
              borderRadius: 8,
              width: 90,
            ),
          ],
        ),
      ),
    );
  }
}
