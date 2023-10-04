// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';
import 'package:my_calendar/config/resources/styles.dart';

import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/widgets/table_calendar/src/customization/calendar_builders_phone.dart';
import 'package:my_calendar/widgets/table_calendar/src/customization/calendar_style_phone.dart';

class CellContent extends StatelessWidget {
  const CellContent({
    Key? key,
    this.isCheckLunar = false,
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
    this.isLunar = true,
  }) : super(key: key);

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
  final CalendarBuilders<dynamic> calendarBuilders;
  final bool isCheckLunar;
  final bool isLunar;

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

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    const duration = Duration(milliseconds: 250);
    final solar = Solar(
      solarDay: day.day,
      solarMonth: day.month,
      solarYear: day.year,
    );

    final lunar =
        Lunarr(LunarSolarConverter.solarToLunar(solar).lunarDay.toString());
    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.disabledDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.disabledTextStyle),
          );
    } else if (isSelected) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          Container(
            padding: padding,
            alignment: Alignment.center,
            child: Container(
              height: 40,
              width: 40,
              decoration: !isToday
                  ? BoxDecoration(
                      color: AppTheme.getInstance().primaryColor(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    )
                  : BoxDecoration(
                      color: AppTheme.getInstance().primaryColor(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
              alignment: Alignment.center,
              child: isCheckLunar
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: isToday
                              ? textNormalCustom(
                                  color:
                                      AppTheme.getInstance().whiteTextColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )
                              : textNormalCustom(
                                  color:
                                      AppTheme.getInstance().whiteTextColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                        ),
                        Text(
                          lunar.lunarDay,
                          style: isToday
                              ? textNormalCustom(
                                  color:
                                      AppTheme.getInstance().whiteTextColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                )
                              : textNormalCustom(
                                  color:
                                      AppTheme.getInstance().whiteTextColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                        ),
                      ],
                    )
                  : Text(
                      text,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().whiteTextColor(),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
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
                child: Text(text, style: calendarStyle.rangeStartTextStyle),
              );
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: calendarStyle.rangeEndDecoration,
            alignment: alignment,
            child: Text(text, style: calendarStyle.rangeEndTextStyle),
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
              decoration: BoxDecoration(
                color: AppTheme.getInstance().greyButtonColor(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                border: Border.all(color: AppTheme.getInstance().darkRed()),
              ),
              alignment: alignment,
              child: isCheckLunar
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().darkRed(),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            lunar.lunarDay,
                            style: textNormalCustom(
                              color: AppTheme.getInstance().darkRed(),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text(text, style: calendarStyle.todayTextStyle),
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
            child: Text(text, style: calendarStyle.holidayTextStyle),
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
                child: Text(text, style: calendarStyle.withinRangeTextStyle),
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
                  text,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().dfTxtColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  lunar.lunarDay,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().dfTxtColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
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
            child: isCheckLunar
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: isWeekend
                              ? calendarStyle.weekendTextStyle
                              : calendarStyle.defaultTextStyle,
                        ),
                        Text(
                          lunar.lunarDay,
                          style: calendarStyle.lunarTextStyle,
                        ),
                      ],
                    ),
                  )
                : Text(
                    text,
                    style: isWeekend
                        ? calendarStyle.weekendTextStyle
                        : calendarStyle.defaultTextStyle,
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

class Lunarr {
  Lunarr(this.lunarDay);

  final String lunarDay;
}
