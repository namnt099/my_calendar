import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/login/ui/register.dart';
import 'package:my_calendar/ultis/extension/extension.dart';
import 'package:my_calendar/ultis/firebase/auth_service.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/message_dialog/message_config.dart';
import 'package:my_calendar/widgets/textfield/custom_textfield.dart';
import 'package:my_calendar/widgets/textfield/form_group.dart';
import 'package:my_calendar/widgets/views/hide_keyboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _groupKey = GlobalKey<FormGroupState>();
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    MessageConfig.init(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetectorOnTapHideKeyBoard(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            BaseAppBar(
              title: S.current.login,
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
                          hintText: S.current.email,
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
                          hintText: S.current.password,
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
                        S.current.login,
                        () {
                          if (_groupKey.currentState!.validator()) {
                            FirebaseAuthService.signInWithEmail(email, password)
                                .then(
                              (value) {
                                if (value) {
                                  Get.back(result: value);
                                  if (!Get.isSnackbarOpen) {
                                    Get.snackbar(
                                      S.current.success,
                                      '${S.current.login} ${S.current.success.toLowerCase()}',
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                }
                              },
                            );
                          }
                        },
                        btnMargin: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      spaceH20,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: S.current.no_account,
                              style: textNormalCustom(
                                color: AppTheme.getInstance().hintTextColor(),
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: S.current.register,
                              style: textNormalCustom(
                                color: AppTheme.getInstance().darkRed(),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(
                                      () => const RegisterScreen(),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      spaceH20,
                      Text(
                        S.current.or,
                        style: textNormalCustom(
                          color: AppTheme.getInstance().getBlackText(),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      spaceH20,
                      GestureDetector(
                        onTap: () {
                          FirebaseAuthService.signInWithGoogle().then(
                            (value) => Get.back(
                              result: true,
                            ),
                          );
                        },
                        child: ImageAssets.svgAssets(
                          ImageAssets.icGoogle,
                        ),
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
