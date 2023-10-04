// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';

import 'package:my_calendar/widgets/table_calendar/src/shared/utils_phone.dart' show CalendarFormat;

class FormatButton extends StatelessWidget {
  const FormatButton({Key? key, 
    
    required this.calendarFormat,
    required this.onTap,
    required this.textStyle,
    required this.decoration,
    required this.padding,
    required this.showsNextFormat,
    required this.availableCalendarFormats,
  }) : super(key: key);

  final CalendarFormat calendarFormat;
  final ValueChanged<CalendarFormat> onTap;
  final TextStyle textStyle;
  final Decoration decoration;
  final EdgeInsets padding;
  final bool showsNextFormat;
  final Map<CalendarFormat, String> availableCalendarFormats;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(_nextFormat()),
      child: Container(
        decoration: decoration,
        padding: padding,
        child: Text(
          _formatButtonText,
          style: textStyle,
        ),
      ),
    );
  }

  String get _formatButtonText => showsNextFormat
      ? availableCalendarFormats[_nextFormat()]!
      : availableCalendarFormats[calendarFormat]!;

  CalendarFormat _nextFormat() {
    final formats = availableCalendarFormats.keys.toList();
    int id = formats.indexOf(calendarFormat);
    id = (id + 1) % formats.length;

    return formats[id];
  }
}
