import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/login/ui/login.dart';
import 'package:my_calendar/ultis/extension/extension.dart';
import 'package:my_calendar/ultis/firebase/auth_service.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/textfield/custom_textfield.dart';
import 'package:my_calendar/widgets/textfield/form_group.dart';
import 'package:my_calendar/widgets/views/hide_keyboard.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _groupKey = GlobalKey<FormGroupState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetectorOnTapHideKeyBoard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            BaseAppBar(
              title: S.current.register,
              leading: const BackLeading(),
            ),
            FormGroup(
              key: _groupKey,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomTextField(
                          hintText: S.current.enter_email,
                          textChange: (value) {
                            email = value;
                          },
                          validator: (value) {
                            if (value?.isNotEmpty ?? false) {
                              if (!trueEmail(value ?? '')) {
                                return S.current.invalid_email;
                              }
                            } else {
                              return S.current.please_email;
                            }
                          },
                          textInputType: TextInputType.number,
                          isShowClearText: true,
                        ),
                      ),
                      spaceH16,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomTextField(
                          hintText: S.current.enter_pass,
                          textChange: (value) {
                            password = value;
                          },
                          maxLine: 1,
                          hidePass: true,
                          validator: (value) {
                            if (value?.isNotEmpty ?? false) {
                              if (value!.length < 6) {
                                return S.current.invalid_pass;
                              }
                            } else {
                              return S.current.please_pass;
                            }
                          },
                          textInputType: TextInputType.number,
                          isShowClearText: true,
                        ),
                      ),
                      spaceH16,
                      AppButton(
                        S.current.register,
                        () {
                          if (_groupKey.currentState!.validator()) {
                            FirebaseAuthService.signUpWithEmail(
                              email,
                              password,
                            );
                          }
                        },
                        btnMargin: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
