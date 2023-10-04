import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/domain/model/devine.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/account/ui/account_info.dart';
import 'package:my_calendar/presentation/login/ui/login.dart';
import 'package:my_calendar/presentation/setting/ui/setting.dart';
import 'package:my_calendar/ultis/extension/theme_extension.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/item_row.dart';

final list = [
  Divine(
    'Ngày này năm xưa',
    ImageAssets.icThis,
  ),
  Divine(
    'Danh ngôn',
    ImageAssets.icDoc,
  ),
  Divine(
    'Video hay',
    ImageAssets.icPlay,
  ),
  Divine(
    'Gửi thiệp',
    ImageAssets.icInvite,
  ),
  Divine(
    'Góc thư giãn',
    ImageAssets.icJoke,
  ),
  Divine(
    'Đếm xuôi đếm ngược',
    ImageAssets.icHourGlass,
  ),
  Divine(
    'Đồng dao',
    ImageAssets.icMoon,
  ),
  Divine(
    'Phóng sự',
    ImageAssets.icCamera,
  ),
  Divine(
    'Trò chơi',
    ImageAssets.icKite,
  ),
];

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final double maxSlide = 300;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  void open() => _animationController.forward();

  void close() => _animationController.reverse();

  void toggle() => _animationController.isDismissed ? open() : close();

  void _onDragStart(DragStartDetails details) {
    final bool isDragOpenFromLeft = _animationController.isDismissed;
    final bool isDragCloseFromRight = _animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      final double delta = (details.primaryDelta ?? 0) / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    const double kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      final double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().backgroundPrimary(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                Transform.translate(
                  offset:
                      Offset(maxSlide * (_animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-pi / 2 * (1 - _animationController.value)),
                    alignment: Alignment.centerRight,
                    child: myDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * _animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.01)
                      ..rotateY(-pi * _animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: myChild(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget myDrawer() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getInstance().primaryColor(),
      ),
      width: maxSlide,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    appBarUrlIcon(),
                  ),
                ),
              ),
              child: (HiveLocal.getDataUser() == null)
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              ).then(
                                (value) => {
                                  if (value) {close(), setState(() {})}
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.getInstance().darkRed(),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                S.current.login,
                                style: textNormalCustom(
                                  color: AppTheme.getInstance()
                                      .getTextWhiteColor(),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          spaceW16,
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                const AccountInfoScreen(),
                              )?.then((value) {
                                if (value) {
                                  setState(() {});
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: (HiveLocal.getDataUser()
                                              ?.networkImage ??
                                          false)
                                      ? Image.network(
                                          HiveLocal.getDataUser()?.photoUrl ??
                                              '',
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) {
                                            return Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppTheme.getInstance()
                                                    .darkRed(),
                                                border: Border.all(
                                                  color: AppTheme.getInstance()
                                                      .getTextWhiteColor(),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  ((HiveLocal.getDataUser()
                                                                  ?.displayName
                                                                  .isEmpty ??
                                                              true)
                                                          ? 'unknow'
                                                          : HiveLocal
                                                                  .getDataUser()
                                                              ?.displayName)!
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
                                          File(
                                            HiveLocal.getDataUser()?.photoUrl ??
                                                '',
                                          ),
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) {
                                            return Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppTheme.getInstance()
                                                    .darkRed(),
                                                border: Border.all(
                                                  color: AppTheme.getInstance()
                                                      .getTextWhiteColor(),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  ((HiveLocal.getDataUser()
                                                                  ?.displayName
                                                                  .isEmpty ??
                                                              true)
                                                          ? 'unknow'
                                                          : HiveLocal
                                                                  .getDataUser()
                                                              ?.displayName)!
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
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      border: Border.all(
                                        color: AppTheme.getInstance()
                                            .getBlackText(),
                                      ),
                                    ),
                                    child: ImageAssets.svgAssets(
                                      ImageAssets.icEdit,
                                      fit: BoxFit.cover,
                                      height: 12,
                                      width: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          spaceW16,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  PrefsService.getEmail(),
                                  style: textNormalCustom(
                                    color:
                                        AppTheme.getInstance().whiteTextColor(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                spaceH12,
                                Text(
                                  S.current.member,
                                  style: textNormalCustom(
                                    color:
                                        AppTheme.getInstance().whiteTextColor(),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          spaceW16,
                        ],
                      ),
                    ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemRow(
                  image: ImageAssets.icSetup,
                  text: S.current.setting,
                  onTap: () {
                    Get.to(const SettingScreen())?.then((value) {
                      if (value) {
                        setState(() {});
                      }
                    });
                  },
                ),
                ItemRow(
                  image: ImageAssets.icFriend,
                  text: S.current.friend,
                  onTap: () {},
                ),
                ItemRow(
                  image: ImageAssets.icQr,
                  text: S.current.qr,
                  onTap: () {},
                ),
                ItemRow(
                  image: ImageAssets.icShare,
                  text: S.current.share,
                  onTap: () {},
                ),
                spaceH16,
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text.rich(
                    TextSpan(
                      text: S.current.term,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().dfTxtColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                spaceH16,
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text.rich(
                    TextSpan(
                      text: S.current.privacy,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().dfTxtColor(),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myChild() {
    return ColoredBox(
      color: AppTheme.getInstance().backgroundPrimary(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH16,
          BaseAppBar(
            title: S.current.explore,
            leading: GestureDetector(
              onTap: () {
                toggle();
              },
              child: ImageAssets.svgAssets(
                ImageAssets.icDrawer,
                color: AppTheme.getInstance().getBlackText(),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH16,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      S.current.content_library,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  spaceH16,
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final type = list[index];
                      return GestureDetector(
                        onTap: () {},
                        child: iconTool(type),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconTool(Divine item) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: ImageAssets.svgAssets(
            item.image,
            fit: BoxFit.cover,
          ),
        ),
        spaceH10,
        Expanded(
          child: SizedBox(
            width: 70,
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: textNormalCustom(
                fontSize: 14,
                color: AppTheme.getInstance().getBlackText(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
