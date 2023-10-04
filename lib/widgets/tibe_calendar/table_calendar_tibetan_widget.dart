// ignore_for_file: prefer_null_aware_method_calls, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/model/event.dart';
import 'package:my_calendar/widgets/calendar_view/bloc/lichh_am_duong_cubit.dart';
import 'package:my_calendar/widgets/table_calendar/src/customization/calendar_style_phone.dart';
import 'package:my_calendar/widgets/table_calendar/src/extension/type.dart';
import 'package:my_calendar/widgets/table_calendar/src/shared/utils_phone.dart';
import 'package:my_calendar/widgets/table_calendar/table_calendar_cubit.dart';
import 'package:my_calendar/widgets/tibe_calendar/table_tibetan_calendar.dart';

class TableTibetanCalendarWidget extends StatefulWidget {
  final bool isCalendar;
  late bool? tablet;
  late bool? isFormatMonth;
  final DateTime? initDateTime;
  final LichAmDuongCubit cubit;
  final bool verticalSwipe;
  final Function(DateTime day) selectDay;
  final Function(DateTime day) onPageChange;
  final Function(DateTime? start, DateTime? end, DateTime? focusedDay)
      onChangeRange;
  final Function(DateTime startDate, DateTime end, DateTime selectDay) onChange;
  final Function(String value)? onSearch;
  final CalendarType type;
  final List<DateTime>? eventsLoader;
  final Function(BuildContext context)? onTap;
  final DateTime? dateTimeHeader;
  final double radius;

  TableTibetanCalendarWidget({
    Key? key,
    this.onTap,
    this.isCalendar = true,
    this.tablet = false,
    this.initDateTime,
    this.isFormatMonth = true,
    this.onSearch,
    required this.onChangeRange,
    required this.onChange,
    this.type = CalendarType.DAY,
    this.eventsLoader,
    required this.selectDay,
    required this.cubit,
    this.dateTimeHeader,
    required this.onPageChange,
    this.verticalSwipe = true,
    this.radius = 20,
  }) : super(key: key);

  @override
  _TableTibetanCalendarWidgetState createState() =>
      _TableTibetanCalendarWidgetState();
}

class _TableTibetanCalendarWidgetState
    extends State<TableTibetanCalendarWidget> {
  TableCalendarCubit cubit = TableCalendarCubit();

  @override
  void initState() {
    selectedEvents = {};
    _selectedDay = widget.initDateTime ?? DateTime.now();
    cubit.selectedDay = widget.initDateTime ?? DateTime.now();
    super.initState();
  }

  @override
  @override
  void didUpdateWidget(TableTibetanCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedDay = widget.initDateTime ?? DateTime.now();
    cubit.selectedDay = widget.initDateTime ?? DateTime.now();
    _focusedDay.value = _selectedDay;
    _onDaySelect(_selectedDay, _focusedDay.value);
  }

  bool isSearch = false;
  late DateTime _selectedDay;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat _calendarFormatWeek = CalendarFormat.week;
  CalendarFormat _calendarFormatMonth = CalendarFormat.month;
  final TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      cubit.focusedDay = focusedDay;
      cubit.rangeStart = start;
      cubit.rangeEnd = end;
      widget.onChangeRange(start, end, focusedDay);
      // _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }

  void _onDaySelect(DateTime date, DateTime events) {
    if (!isSameDay(_selectedDay, date)) {
      setState(() {
        _selectedDay = date;
        _focusedDay.value = _selectedDay;
        cubit.rangeStart = null; // Important to clean those
        cubit.rangeEnd = null;
      });
    }
    cubit.selectedDay = date;
    cubit.moveTimeSubject.add(cubit.selectedDay);

    if (widget.type == CalendarType.DAY) {
      widget.onChange(date, date, date);
    } else if (widget.type == CalendarType.WEEK) {
      widget.onChange(
        date.subtract(Duration(days: date.weekday - 1)),
        date.add(
          Duration(
            days: DateTime.daysPerWeek - date.weekday,
          ),
        ),
        date,
      );
    } else {
      widget.onChange(
        DateTime(
          cubit.moveTimeSubject.value.year,
          cubit.moveTimeSubject.value.month,
        ),
        DateTime(
          cubit.moveTimeSubject.value.year,
          cubit.moveTimeSubject.value.month + 1,
          0,
        ),
        date,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: widget.isCalendar
              ? BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.getInstance()
                          .shadowColor()
                          .withOpacity(0.14),
                      blurRadius: 8.0,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius),
                  ),
                )
              : const BoxDecoration(
                  color: Colors.white,
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xffECEEF7),
                    ),
                  ),
                ),
                child: TableTibetanCalendarPhone(
                  verticalSwipe: widget.verticalSwipe,
                  eventLoader: (day) =>
                      widget.eventsLoader
                          ?.where((element) => isSameDay(element, day))
                          .toList() ??
                      [],
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: _onDaySelect,
                  rangeStartDay: cubit.rangeStart,
                  rangeEndDay: cubit.rangeEnd,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (CalendarFormat format) {
                    setState(() {
                      widget.isFormatMonth == true
                          ? _calendarFormatWeek = format
                          : _calendarFormatMonth = format;
                    });
                  },
                  onPageChanged: (DateTime focusedDay) {
                    widget.onPageChange(focusedDay);
                  },
                  selectedDayPredicate: (day) {
                    return widget.selectDay(day) ||
                        isSameDay(widget.cubit.selectTime, day);
                  },
                  calendarStyle: CalendarStyle(
                    weekendTextStyle: textNormalCustom(
                      color: const Color(0xff3D5586),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    defaultTextStyle: textNormalCustom(
                      color: const Color(0xff3D5586),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    outsideTextStyle: textNormalCustom(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedTextStyle: textNormalCustom(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    todayDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    selectedDecoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.getInstance().leafPrimaryColor(),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    todayTextStyle: textNormalCustom(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    todaySelectedStyle: textNormalCustom(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                    todaySelectedDecoration: BoxDecoration(
                      color: AppTheme.getInstance().leafPrimaryColor(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff6566E9).withOpacity(0.1),
                          blurRadius: 20.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  headerVisible: false,
                  calendarFormat: widget.isFormatMonth == true
                      ? _calendarFormatWeek
                      : _calendarFormatMonth,
                  firstDay: DateTime.utc(1800),
                  lastDay: DateTime.utc(2199),
                  focusedDay: _focusedDay.value,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
