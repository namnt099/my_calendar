import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tibetan_calendar/tibetan_calendar.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/ultis/extension/theme_extension.dart';
import 'package:my_calendar/widgets/calendar_view/bloc/lichh_am_duong_cubit.dart';
import 'package:my_calendar/widgets/table_calendar/table_calendar_widget.dart';
import 'package:my_calendar/widgets/tibe_calendar/table_calendar_tibetan_widget.dart';

class TibeScreen extends StatefulWidget {
  const TibeScreen({Key? key}) : super(key: key);

  @override
  State<TibeScreen> createState() => _TibeScreenState();
}

class _TibeScreenState extends State<TibeScreen> {
  late final LichAmDuongCubit _cubit;

  @override
  void initState() {
    // TODO: implement initState
    _cubit = LichAmDuongCubit();
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
              onTap: () {},
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
                  child: StreamBuilder<DateTime>(
                      stream: _cubit.changeDateTimeSubject.stream,
                      builder: (context, snapshot) {
                        final julian = snapshot.data ?? DateTime.now();
                        final tibe = TibetanCalendar.getTibetanDate(julian);
                        return Text(
                          '${DateFormat('EEEE').format(julian)} ${tibe.day}-${tibe.month}-${tibe.year}',
                          textAlign: TextAlign.center,
                          style: textNormalCustom(
                            color: AppTheme.getInstance().getBlackText(),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      })),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<DateTime>(
                    stream: _cubit.changeDateTimeSubject.stream,
                    builder: (context, snapshot) {
                      return TableCalendarWidget(
                        isLunar: false,
                        isCheckLunar: true,
                        radius: 0,
                        onChange: (DateTime start, DateTime end, selectDay) {
                          _cubit.startDate = start.formatApiDDMMYYYY;
                          _cubit.selectTime = selectDay;
                        },
                        onChangeRange: (
                          DateTime? start,
                          DateTime? end,
                          DateTime? focusedDay,
                        ) {

                        },
                        onPageChange: (DateTime focusedDay) {
                          _cubit.changeDateTimeSubject.sink.add(focusedDay);
                        },
                        initDateTime: snapshot.data ?? DateTime.now(),
                        selectDay: (day) => _cubit.selectDay(day),
                        cubit: _cubit,
                      );
                    }
                  ),
                  spaceH8,
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        color: AppTheme.getInstance().primaryColor(),
                        child: Image.asset(
                          appBarUrlIcon(),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd')
                                  .format(DateTime.now())
                                  .toUpperCase(),
                              style: textNormalCustom(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 48,
                                shadows: [
                                  const BoxShadow(
                                    offset: Offset(-3, 10),
                                    spreadRadius: 31,
                                    blurRadius: 48,
                                  )
                                ],
                              ),
                            ),
                            Text(
                              DateFormat('EEEE').format(DateTime.now()),
                              style: textNormalCustom(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                shadows: [
                                  const BoxShadow(
                                    offset: Offset(-3, 10),
                                    spreadRadius: 31,
                                    blurRadius: 48,
                                  )
                                ],
                              ),
                            ),
                            spaceH4,
                            Text(
                              DateFormat('MMMM yyyy')
                                  .format(DateTime.now())
                                  .toUpperCase(),
                              style: textNormalCustom(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                shadows: [
                                  const BoxShadow(
                                    offset: Offset(-3, 10),
                                    spreadRadius: 31,
                                    blurRadius: 48,
                                  )
                                ],
                              ),
                            ),
                          ],
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
