import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/presentation/login/ui/login.dart';
import 'package:my_calendar/presentation/setting/ui/setting.dart';

class AppBarProfile extends StatefulWidget {
  const AppBarProfile({Key? key}) : super(key: key);

  @override
  State<AppBarProfile> createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.getInstance().backgroundPrimary(),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (PrefsService.getEmail() == '')
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().primaryColor(),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Đăng nhập',
                    style: textNormalCustom(
                      color: AppTheme.getInstance().getTextWhiteColor(),
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        PrefsService.getPhoto(),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.getInstance().primaryColor(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  spaceH4,
                  SizedBox(
                    width: 100,
                    child: Text(
                      PrefsService.getFullName(),
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  spaceH12,
                ],
              ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                ).then((value) => value ? setState(() {}) : null);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageAssets.svgAssets(
                    ImageAssets.icSetting,
                    color: AppTheme.getInstance().primaryColor(),
                    fit: BoxFit.cover,
                  ),
                  spaceH8,
                  Text(
                    'Thiết lập',
                    style: textNormalCustom(
                      color: AppTheme.getInstance().getBlackText(),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  spaceH12,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
