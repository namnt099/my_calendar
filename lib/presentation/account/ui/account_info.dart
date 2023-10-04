import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/domain/model/account/user.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/ultis/extension/image_extension.dart';
import 'package:my_calendar/ultis/firebase/firebase_database.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/textfield/custom_textfield.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool result = false;
  LoginUser? user = HiveLocal.getDataUser();
  late LoginUser userUpdate;
  String path = '';

  @override
  void initState() {
    super.initState();
    userUpdate = user ?? LoginUser();
    path = PrefsService.getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppButton(
        Text(
          S.current.update,
          style: textNormalCustom(
            color: AppTheme.getInstance().whiteTextColor(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        () {
          HiveLocal.saveDataUser(userUpdate).then((_) {
            Get.snackbar(
              S.current.success,
              S.current.update_profile_success,
              snackPosition: SnackPosition.BOTTOM,
            );
          });
          FirebaseDB.update(userUpdate);
        },
        textColor: AppTheme.getInstance().whiteTextColor(),
        btnMargin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 34,
        ),
      ),
      body: Column(
        children: [
          BaseAppBar(
            title: S.current.update_info,
            leading: BackLeading(
              result: result,
            ),
            backgroundColor: AppTheme.getInstance().primaryColor(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    spaceH24,
                    GestureDetector(
                      onTap: () async {
                        ModelAnh model;
                        model = await pickAvatar();
                        path = model.path;
                        userUpdate.photoUrl = path;
                        userUpdate.networkImage = false;
                        result = true;
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.hardEdge,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.getInstance().shadowColor(),
                                  blurRadius: 8.0,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: (user?.networkImage ?? true)
                                ? Image.network(
                                    user?.photoUrl ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              AppTheme.getInstance().darkRed(),
                                          border: Border.all(
                                            color: AppTheme.getInstance()
                                                .getTextWhiteColor(),
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            ((user?.displayName.isEmpty ?? true)
                                                    ? 'unknow'
                                                    : user?.displayName)!
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: textNormalCustom(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Image.file(
                                    File(path),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) {
                                      return Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              AppTheme.getInstance().darkRed(),
                                          border: Border.all(
                                            color: AppTheme.getInstance()
                                                .getTextWhiteColor(),
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            ((user?.displayName.isEmpty ?? true)
                                                    ? 'unknow'
                                                    : user?.displayName)!
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: textNormalCustom(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                                border: Border.all(
                                  color: AppTheme.getInstance().getBlackText(),
                                ),
                              ),
                              child: ImageAssets.svgAssets(
                                ImageAssets.icCamera,
                                fit: BoxFit.cover,
                                height: 16,
                                width: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH16,
                    CustomTextField(
                      hintText: S.current.user_name,
                      textChange: (value) {
                        if (value.isNotEmpty) {
                          userUpdate.displayName = value;
                        }
                      },
                      textInputType: TextInputType.text,
                      isShowClearText: false,
                      initText: user?.displayName,
                      prefixIcon: ImageAssets.svgAssets(
                        ImageAssets.icUser,
                        color: AppTheme.getInstance().primaryColor(),
                      ),
                    ),
                    spaceH16,
                    CustomTextField(
                      hintText: S.current.birthday,
                      textChange: (value) {
                        if (value.isNotEmpty) {
                          userUpdate.birthday = value;
                        }
                      },
                      textInputType: TextInputType.text,
                      isShowClearText: false,
                      initText: user?.birthday,
                      prefixIcon: ImageAssets.svgAssets(
                        ImageAssets.icBirthDay,
                        color: AppTheme.getInstance().primaryColor(),
                      ),
                    ),
                    spaceH16,
                    CustomTextField(
                      hintText: S.current.birthday,
                      textChange: (value) {
                        if (value.isNotEmpty) {
                          userUpdate.hour = value;
                        }
                      },
                      textInputType: TextInputType.text,
                      isShowClearText: false,
                      initText: user?.hour,
                      prefixIcon: ImageAssets.svgAssets(
                        ImageAssets.icClock,
                        color: AppTheme.getInstance().primaryColor(),
                      ),
                    ),
                    spaceH16,
                    CustomTextField(
                      hintText: S.current.phone,
                      textChange: (value) {
                        if (value.isNotEmpty) {
                          userUpdate.phone = value;
                        }
                      },
                      textInputType: TextInputType.number,
                      isShowClearText: false,
                      initText: user?.phone,
                      prefixIcon: ImageAssets.svgAssets(
                        ImageAssets.icPhone,
                        color: AppTheme.getInstance().primaryColor(),
                      ),
                    ),
                    spaceH16,
                    CustomTextField(
                      hintText: S.current.address,
                      textChange: (value) {
                        if (value.isNotEmpty) {
                          userUpdate.address = value;
                        }
                      },
                      textInputType: TextInputType.text,
                      isShowClearText: false,
                      initText: user?.address,
                      prefixIcon: ImageAssets.svgAssets(
                        ImageAssets.icAddress,
                        color: AppTheme.getInstance().primaryColor(),
                      ),
                    ),
                    spaceH16,
                    CustomTextField(
                      hintText: S.current.email,
                      textChange: (value) {
                        if (value.isNotEmpty) {
                          userUpdate.email = value;
                        }
                      },
                      textInputType: TextInputType.text,
                      isShowClearText: false,
                      initText: user?.email,
                      prefixIcon: ImageAssets.svgAssets(
                        ImageAssets.icMail,
                        color: AppTheme.getInstance().primaryColor(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
