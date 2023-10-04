import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/ultis/utils.dart';
import 'package:my_calendar/widgets/bottom_sheet/show_bottom_sheet.dart';
import 'package:my_calendar/widgets/button/button_bottom.dart';
import 'package:my_calendar/widgets/calendar_view/bloc/lichh_am_duong_cubit.dart';

import 'package:my_calendar/widgets/table_calendar/table_calendar_widget.dart';

import '../../widgets/calendar_view/extension/lich/date_picker_widget.dart';

class MonthScreen extends StatefulWidget {
  const MonthScreen({Key? key, required this.cubit}) : super(key: key);
  final LichAmDuongCubit cubit;

  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  DateTime dateTime = DateTime.now();
  late Lunar lunar;

  @override
  void initState() {
    lunar = LunarSolarConverter.solarToLunar(
      Solar(
        solarYear: dateTime.year,
        solarDay: dateTime.day,
        solarMonth: dateTime.month,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().backgroundPrimary(),
      body: Column(
        children: [
          AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppTheme.getInstance().backgroundPrimary(),
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
                          stream: widget.cubit.changeDateTimeSubject.stream,
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
                                widget.cubit.time = flag
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
                              initialDateTime: snapshot.data ?? DateTime.now(),
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
                            widget.cubit.selectTime = widget.cubit.time;
                            widget.cubit.changeDateTimeSubject.sink
                                .add(widget.cubit.time);
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
                    color: AppTheme.getInstance().primaryColor(),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<DateTime>(
                      stream: widget.cubit.changeDateTimeSubject.stream,
                      builder: (context, snapshot) {
                        return Text(
                          DateFormat('EEEE, dd-MM-yyyy')
                              .format(snapshot.data ?? DateTime.now()),
                          textAlign: TextAlign.center,
                          style: textNormalCustom(
                            color: AppTheme.getInstance().getBlackText(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppTheme.getInstance().getBlackText(),
                    ),
                  ],
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.getInstance().primaryColor(),
              ),
            ),
            actions: [
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: ImageAssets.svgAssets(
                    ImageAssets.icAddEvent,
                    color: AppTheme.getInstance().primaryColor(),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<DateTime>(
                    stream: widget.cubit.changeDateTimeSubject.stream,
                    builder: (context, snapshot) {
                      return TableCalendarWidget(
                        radius: 0,
                        isFormatMonth: false,
                        onChange: (DateTime start, DateTime end, selectDay) {
                          widget.cubit.startDate = start.formatApiDDMMYYYY;
                          widget.cubit.selectTime = selectDay;
                        },
                        onChangeRange: (
                          DateTime? start,
                          DateTime? end,
                          DateTime? focusedDay,
                        ) {},
                        onPageChange: (DateTime focusedDay) {
                          widget.cubit.changeDateTimeSubject.sink
                              .add(focusedDay);
                        },
                        initDateTime: snapshot.data ?? DateTime.now(),
                        selectDay: (day) => widget.cubit.selectDay(day),
                        cubit: widget.cubit,
                        isCheckLunar: true,

                      );
                    },
                  ),
                  spaceH8,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH16,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: textNormalCustom(
                                color: AppTheme.getInstance()
                                    .getBlackText()
                                    .withOpacity(0.5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Giờ ${CanChi.canChiGio(dateTime.hour, dateTime.day, dateTime.month, dateTime.year)}',
                              style: textNormalCustom(
                                color: AppTheme.getInstance().getBlackText(),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        spaceH12,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('dd MMMM, yyyy')
                                  .format(DateTime.now()),
                              style: textNormalCustom(
                                color: AppTheme.getInstance().getBlackText(),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              CanChi.namCanChi(DateTime.now().year),
                              style: textNormalCustom(
                                color: AppTheme.getInstance()
                                    .getBlackText()
                                    .withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        spaceH12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${lunar.lunarDay} Tháng ${lunar.lunarMonth}, ${CanChi.namCanChi(dateTime.year)}',
                              style: textNormalCustom(
                                color: AppTheme.getInstance()
                                    .getBlackText()
                                    .withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
                              style: textNormalCustom(
                                color: AppTheme.getInstance()
                                    .getBlackText()
                                    .withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        spaceH16,
                      ],
                    ),
                  ),
                  spaceH2,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GIỜ HOÀNG ĐẠO',
                          style: textNormalCustom(
                            color: AppTheme.getInstance()
                                .getBlackText()
                                .withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        spaceH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            item('Tý', '(23-1h)', ImageAssets.icMouse),
                            item('Sửu', '(1-3h)', ImageAssets.icBuffalo),
                          ],
                        ),
                        spaceH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            item('Dần', '(3-5h)', ImageAssets.icTiger),
                            item('Mão', '(5-7h)', ImageAssets.icCat),
                          ],
                        ),
                        spaceH16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            item('Thìn', '(7-9h)', ImageAssets.icDragon),
                            item('Tỵ', '(9-11h)', ImageAssets.icSneak),
                          ],
                        ),
                      ],
                    ),
                  ),
                  spaceH8,
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SỰ KIỆN',
                          style: textNormalCustom(
                            color: AppTheme.getInstance()
                                .getBlackText()
                                .withOpacity(0.5),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        spaceH24,
                        Row(
                          children: [
                            const Icon(Icons.event),
                            spaceW16,
                            Text(
                              'Bạn chưa thêm sự kiện cho ngày này',
                              style: textNormalCustom(
                                color: AppTheme.getInstance().getBlackText(),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        spaceH16,
                        Divider(
                          color: AppTheme.getInstance().backgroundPrimary(),
                        ),
                        spaceH8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageAssets.svgAssets(
                              ImageAssets.icAddEvent,
                              color: AppTheme.getInstance().primaryColor(),
                            ),
                            spaceW8,
                            Text(
                              'Thêm sự kiện',
                              style: textNormalCustom(
                                color: AppTheme.getInstance().primaryColor(),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget item(String name, String hour, String image) {
    return Row(
      children: [
        ImageAssets.svgAssets(
          image,
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
        spaceW8,
        SizedBox(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textNormalCustom(
                  color: AppTheme.getInstance().getBlackText(),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                hour,
                style: textNormalCustom(
                  color: AppTheme.getInstance().getBlackText().withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
