import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/ultis/animate/custom_rect_tween.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/textfield/custom_textfield.dart';

class NotePopup extends StatelessWidget {
  const NotePopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var text = '';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ghi chú',
                    style: textNormalCustom(
                      color: AppTheme.getInstance().getBlackText(),
                      fontSize: 20,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Nhập ghi chú',
                    textChange: (value) {
                      text = value;
                    },
                    maxLine: 5,
                    borderColor: AppTheme.getInstance().getBlackText(),
                    focusColor: AppTheme.getInstance().getBlackText(),
                    color: AppTheme.getInstance().getBlackText(),
                    textInputType: TextInputType.text,
                    isShowClearText: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppButton(
                        'Đóng',
                        () {
                          Navigator.pop(context);
                        },
                        width: width / 3.5,
                        textColor: AppTheme.getInstance().getBlackText(),
                        backgroundColor:
                            AppTheme.getInstance().whiteTextColor(),
                      ),
                      AppButton(
                        'Lưu',
                        () {
                          Navigator.pop(context, text);
                        },
                        width: width / 3.5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
