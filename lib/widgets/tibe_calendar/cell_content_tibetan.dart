// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tibetan_calendar/tibetan_calendar.dart';
import 'package:my_calendar/widgets/table_calendar/src/customization/calendar_builders_phone.dart';
import 'package:my_calendar/widgets/table_calendar/src/customization/calendar_style_phone.dart';

class CellContentTibe extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;

  const CellContentTibe({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isToday,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    const duration = Duration(milliseconds: 250);

    final tibetan =
        TibetanCalendar.getTibetanDate(DateTime(day.year, day.month, day.day));
    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.disabledDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.day.toString(),
                  style: calendarStyle.disabledTextStyle,
                ),
                Text(
                  tibetan.day,
                  style: calendarStyle.disabledTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
    } else if (isSelected) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          Container(
            padding: padding,
            alignment: Alignment.center,
            child: Container(
              height: 40,
              width: 40,
              decoration: isToday
                  ? calendarStyle.todaySelectedDecoration
                  : calendarStyle.selectedDecoration,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.day.toString(),
                    style: isToday
                        ? calendarStyle.todaySelectedStyle
                        : calendarStyle.selectedTextStyle,
                  ),
                  Text(
                    tibetan.day.toString(),
                    style: isToday
                        ? calendarStyle.todaySelectedStyle
                            .copyWith(fontSize: 12)
                        : calendarStyle.selectedTextStyle
                            .copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.rangeStartDecoration,
                alignment: alignment,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.day.toString(),
                      style: calendarStyle.rangeStartTextStyle,
                    ),
                    Text(
                      tibetan.day,
                      style: calendarStyle.rangeStartTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.day.toString(),
                  style: calendarStyle.rangeEndTextStyle,
                ),
                Text(
                  tibetan.day,
                  style: calendarStyle.rangeEndTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
    } else if (isToday && isTodayHighlighted) {
      cell = calendarBuilders.todayBuilder?.call(context, day, focusedDay) ??
          Container(
            padding: padding,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: duration,
              height: 40,
              width: 40,
              decoration: calendarStyle.todayDecoration,
              alignment: alignment,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.day.toString(),
                      style: calendarStyle.todayTextStyle,
                    ),
                    Text(
                      tibetan.day.toString(),
                      style: calendarStyle.todayTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.holidayDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(day.day.toString(), style: calendarStyle.holidayTextStyle),
                Text(
                  tibetan.day,
                  style: calendarStyle.holidayTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
    } else if (isWithinRange) {
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              AnimatedContainer(
                duration: duration,
                margin: margin,
                padding: padding,
                decoration: calendarStyle.withinRangeDecoration,
                alignment: alignment,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.day.toString(),
                      style: calendarStyle.withinRangeTextStyle,
                    ),
                    Text(
                      tibetan.day,
                      style: calendarStyle.withinRangeTextStyle.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.outsideDecoration,
            alignment: alignment,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.day.toString(),
                  style: calendarStyle.outsideTextStyle,
                ),
                Text(
                  tibetan.day.toString(),
                  style: calendarStyle.outsideTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          );
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          Container(
            margin: margin,
            padding: padding,
            decoration: isWeekend
                ? calendarStyle.weekendDecoration
                : calendarStyle.defaultDecoration,
            alignment: alignment,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.day.toString(),
                    style: isWeekend
                        ? calendarStyle.weekendTextStyle
                        : calendarStyle.defaultTextStyle,
                  ),
                  Text(
                    tibetan.day.toString(),
                    style: isWeekend
                        ? calendarStyle.weekendTextStyle.copyWith(fontSize: 12)
                        : calendarStyle.defaultTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
