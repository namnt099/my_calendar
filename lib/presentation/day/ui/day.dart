import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:my_calendar/config/resources/images.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/presentation/day/bloc/day_cubit.dart';
import 'package:my_calendar/ultis/utils.dart';
import 'package:my_calendar/widgets/bottom_sheet/show_bottom_sheet.dart';
import 'package:my_calendar/widgets/button/button_bottom.dart';
import 'package:my_calendar/widgets/calendar_view/extension/lich/date_picker_widget.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({Key? key}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  var date = DateTime.now();
  late var cubit;
  var random = Random();
  var seed = 1;
  var uri = PrefsService.getImage();

  @override
  void initState() {
    // TODO: implement initState
    cubit = DayCubit();
    super.initState();
  }

  int next(int max, int min) => min + random.nextInt(max - min);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        // leading: GestureDetector(
        //   onTap: () async {
        //     ModelAnh model;
        //     model = await pickAvatar();
        //     await PrefsService.saveImage(model.path);
        //     setState(() {});
        //   },
        //   child: Icon(
        //     Icons.image,
        //     color: AppTheme.getInstance().getBlackText(),
        //   ),
        // ),
        title: GestureDetector(
          onTap: () {
            showBottomSheetCustom(
              context,
              title: 'Hôm nay',
              colorTitle: AppTheme.getInstance().primaryColor(),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: StreamBuilder<DateTime>(
                      stream: cubit.changeDateTimeSubject.stream,
                      builder: (context, snapshot) {
                        return FlutterRoundedCupertinoDatePickerWidgetAmDuong(
                          minimumYear: 1900,
                          maximumYear: 2099,
                          onDateTimeChanged: (value) {
                            //cubit.time = value;
                          },
                          onChangeSolar: (date, flag) {
                            final solar = LunarSolarConverter.lunarToSolar(
                              Lunar(
                                lunarDay: date.day,
                                lunarMonth: date.month,
                                lunarYear: date.year,
                              ),
                            );
                            cubit.time = flag
                                ? DateTime(
                                    solar.solarYear ?? 1900,
                                    solar.solarMonth ?? 1,
                                    solar.solarDay ?? 1,
                                  )
                                : date;
                          },
                          textStyleDate: textNormalCustom(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.getInstance().getBlackText(),
                          ),
                          initialDateTime: date,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 32,
                    ),
                    child: ButtonBottom(
                      onPressed: () async {
                        final nav = Navigator.of(context);
                        cubit.selectTime = cubit.time;
                        cubit.changeDateTimeSubject.sink.add(cubit.time);
                        nav.pop();
                      },
                      text: 'Chọn ngày',
                    ),
                  )
                ],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: AppTheme.getInstance().backgroundPrimary(),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('MMMM').format(
                    date,
                  ),
                  textAlign: TextAlign.center,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().getBlackText(),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppTheme.getInstance().getBlackText(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: SwipeTo(
              onRightSwipe: () {
                setState(() {
                  seed = next(5, 1);
                  date = date.subtract(const Duration(days: 1));
                });
              },
              iconSize: 0,
              onLeftSwipe: () {
                setState(() {
                  seed = next(5, 1);
                  date = date.add(const Duration(days: 1));
                });
                // Swiping in left direction.
              },
              child: Container(
                decoration: BoxDecoration(
                  image: PrefsService.getImage().isNotEmpty
                      ? DecorationImage(
                          image: FileImage(File(uri)),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage('$baseImg/day_image$seed.png'),
                          fit: BoxFit.cover,
                        ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    spaceH24,
                    Text(
                      DateFormat('dd').format(date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                            offset: Offset(-3, 10),
                            spreadRadius: 31,
                            blurRadius: 48,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          )
                        ],
                      ),
                    ),
                    Text(
                      DateFormat('EEEE').format(date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          BoxShadow(
                            offset: Offset(-3, 10),
                            spreadRadius: 31,
                            blurRadius: 48,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              color: AppTheme.getInstance().backgroundPrimary(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'GIỜ',
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(DateTime.now()),
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        CanChi.canChiGio(
                          DateTime.now().hour,
                          DateTime.now().day,
                          DateTime.now().month,
                          DateTime.now().year,
                        ),
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NGÀY',
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${LunarSolarConverter.solarToLunar(
                          Solar(
                            solarYear: date.year,
                            solarMonth: date.month,
                            solarDay: date.day,
                          ),
                        ).lunarDay}',
                        style: TextStyle(
                          color: AppTheme.getInstance().primaryColor(),
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        CanChi.canChiNgay(date.day, date.month, date.year),
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'THÁNG',
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '${LunarSolarConverter.solarToLunar(
                          Solar(
                            solarYear: date.year,
                            solarMonth: date.month,
                            solarDay: date.day,
                          ),
                        ).lunarMonth}',
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        CanChi.layCanChiThang(
                          LunarSolarConverter.solarToLunar(
                                Solar(
                                  solarYear: DateTime.now().year,
                                  solarMonth: DateTime.now().month,
                                  solarDay: DateTime.now().day,
                                ),
                              ).lunarMonth ??
                              -1,
                          DateTime.now().year,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppTheme.getInstance().getBlackText(),
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
