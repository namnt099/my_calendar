import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/ultis/animate/custom_rect_tween.dart';

class ShowNotePopup extends StatelessWidget {
  const ShowNotePopup({
    Key? key,
    required this.value,
  }) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Hero(
        tag: '',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
          child: Material(
            color: AppTheme.getInstance().getTextWhiteColor(),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            child: Container(
              height: height / 3,
              width: width / 1.5,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                  color: AppTheme.getInstance().backgroundPrimary(),
                  border: Border.all(
                    color: AppTheme.getInstance().leafPrimaryColor(),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                children: [
                  Text(
                    'Ghi chú',
                    style: textNormalCustom(
                      color: AppTheme.getInstance().getBlackText(),
                      fontSize: 20,
                    ),
                  ),
                  spaceH24,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().primaryColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
