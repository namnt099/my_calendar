import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';

class BaseAppBar extends StatefulWidget {
  const BaseAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.elevation,
    this.actions,
    this.backgroundColor,
    this.titleColor,
  }) : super(key: key);
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final double? elevation;
  final Color? backgroundColor;
  final Color? titleColor;

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: AppBar(
        backgroundColor: widget.backgroundColor ?? Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.title,
          style: textNormalCustom(
            color: widget.titleColor ?? AppTheme.getInstance().getBlackText(),
            fontSize: 18,
          ),
        ),
        leading: widget.leading,
        actions: widget.actions,
        elevation: widget.elevation ?? 0,
      ),
    );
  }
}

class BackLeading extends StatelessWidget {
  const BackLeading({Key? key, this.result, this.color}) : super(key: key);
  final dynamic? result;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context, result);
      },
      icon: Icon(
        Icons.arrow_back_ios,
        color: color ?? AppTheme.getInstance().getBlackText(),
      ),
    );
  }
}
