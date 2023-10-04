import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/routes/router.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/main_screen/ui/main_screen.dart';
import 'package:my_calendar/presentation/setting/ui/setting_theme.dart';
import 'package:my_calendar/ultis/firebase/auth_service.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/webview/menu_item.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().whiteTextColor(),
      bottomNavigationBar: PrefsService.getEmail().isNotEmpty
          ? AppButton(
              Text(
                S.current.logout,
                style: textNormalCustom(
                  color: AppTheme.getInstance().whiteTextColor(),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              () {
                FirebaseAuthService.signOut().then(
                  (_) => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainTabBarView(),
                      ),
                      ModalRoute.withName(AppRouter.main),
                    ),
                  },
                );
              },
              btnMargin: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 34,
              ),
            )
          : const SizedBox(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            elevation: 0.5,
            backgroundColor: AppTheme.getInstance().primaryColor(),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  PrefsService.getFullName().isEmpty ? false : true,
                );
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.getInstance().getBlackText(),
              ),
            ),
            title: Text(
              S.current.setting,
              style: textNormalCustom(
                color: AppTheme.getInstance().getBlackText(),
                fontSize: 18,
              ),
            ),
          ),
          spaceH16,
          MenuItemCustom(
            onTap: () {
              Get.to(const SettingTheme());
            },
            image: ImageAssets.icSettingTheme,
            title: S.current.setting_theme,
          ),
          spaceH16,
        ],
      ),
    );
  }
}
