import 'package:flutter/material.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/setting/bloc/setting_cubit.dart';

import 'package:my_calendar/presentation/setting/ui/widgets/select_mua_widget.dart';

import 'package:my_calendar/ultis/constants/app_constant.dart';
import 'package:my_calendar/widgets/app_bar.dart';

List<AppBackground> cacMuaList = [
  AppBackground.XUAN,
  AppBackground.HA,
  AppBackground.THU,
  AppBackground.DONG,
];
List<AppBackground> cacNgayLe = [
  AppBackground.TET_NGUYEN_DAN,
  AppBackground.LE_TINH_NHAN,
  AppBackground.NGAY_QUOC_TE_PHU_NU,
  AppBackground.GIO_TO_HUNG_VUONG,
  AppBackground.NGAY_QUOC_TE_LAO_DONG,
  AppBackground.NGAY_QUOC_TE_THIEU_NHI,
  AppBackground.NGAY_QUOC_KHANH,
  AppBackground.TET_TRUNG_THU,
  AppBackground.NGAY_PHU_NU_VIET_NAM,
  AppBackground.NGAY_HALLOWEEN,
  AppBackground.NGAY_NHA_GIAO_VIET_NAM,
  AppBackground.NGAY_LE_GIANG_SINH
];

class SettingTheme extends StatefulWidget {
  const SettingTheme({Key? key}) : super(key: key);

  @override
  _SettingThemeState createState() => _SettingThemeState();
}

class _SettingThemeState extends State<SettingTheme> {
  late SettingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SettingCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().whiteTextColor(),
      body: Column(
        children: [
          BaseAppBar(
            title: S.current.setting,
            leading: const BackLeading(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                 // const SettingColorWidget(),
                  const SizedBox(
                    height: 6,
                  ),
                  // SelectMuaWidget(
                  //   title: S.current.cac_mua,
                  //   list: cacMuaList,
                  // ),
                  const SizedBox(
                    height: 6,
                  ),
                  // SelectMuaWidget(
                  //   title: S.current.ngay_le,
                  //   list: cacNgayLe,
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
