import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;

class GNavCustom extends StatefulWidget {
  const GNavCustom({
    Key? key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
    this.gap = 0,
    this.padding = const EdgeInsets.all(25),
    this.activeColor,
    this.color,
    this.rippleColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.tabBackgroundColor = Colors.transparent,
    this.tabBorderRadius = 100.0,
    this.iconSize,
    this.textStyle,
    this.curve = Curves.easeInCubic,
    this.tabMargin = EdgeInsets.zero,
    this.debug = false,
    this.duration = const Duration(milliseconds: 500),
    this.tabBorder,
    this.tabActiveBorder,
    this.tabShadow,
    this.haptic = true,
    this.tabBackgroundGradient,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  final List<GButton> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;
  final double gap;
  final double tabBorderRadius;
  final double? iconSize;
  final Color? activeColor;
  final Color backgroundColor;
  final Color tabBackgroundColor;
  final Color? color;
  final Color rippleColor;
  final Color hoverColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry tabMargin;
  final TextStyle? textStyle;
  final Duration duration;
  final Curve curve;
  final bool debug;
  final bool haptic;
  final Border? tabBorder;
  final Border? tabActiveBorder;
  final List<BoxShadow>? tabShadow;
  final Gradient? tabBackgroundGradient;
  final MainAxisAlignment mainAxisAlignment;

  @override
  _GNavState createState() => _GNavState();
}

class _GNavState extends State<GNavCustom> {
  late int selectedIndex;
  bool clickable = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(GNavCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.backgroundColor,
        child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: widget.tabs
                .map((t) => GButton(
                    key: t.key,
                    border: t.border ?? widget.tabBorder,
                    activeBorder: t.activeBorder ?? widget.tabActiveBorder,
                    shadow: t.shadow ?? widget.tabShadow,
                    borderRadius: t.borderRadius ??
                        BorderRadius.all(
                          Radius.circular(widget.tabBorderRadius),
                        ),
                    debug: widget.debug,
                    margin: t.margin ?? widget.tabMargin,
                    active: selectedIndex == widget.tabs.indexOf(t),
                    gap: t.gap ?? widget.gap,
                    iconActiveColor: t.iconActiveColor ?? widget.activeColor,
                    iconColor: t.iconColor ?? widget.color,
                    iconSize: t.iconSize ?? widget.iconSize,
                    textColor: t.textColor ?? widget.activeColor,
                    rippleColor: t.rippleColor ?? widget.rippleColor,
                    hoverColor: t.hoverColor ?? widget.hoverColor,
                    padding: t.padding ?? widget.padding,
                    textStyle: t.textStyle ?? widget.textStyle,
                    text: t.text,
                    icon: t.icon,
                    haptic: widget.haptic,
                    leading: t.leading,
                    curve: widget.curve,
                    backgroundGradient:
                        t.backgroundGradient ?? widget.tabBackgroundGradient,
                    backgroundColor:
                        t.backgroundColor ?? widget.tabBackgroundColor,
                    duration: widget.duration,
                    onPressed: () {
                      if (!clickable) return;
                      setState(() {
                        selectedIndex = widget.tabs.indexOf(t);
                        clickable = false;
                      });

                      t.onPressed?.call();

                      widget.onTabChange?.call(selectedIndex);

                      Future.delayed(widget.duration, () {
                        setState(() {
                          clickable = true;
                        });
                      });
                    }))
                .toList()));
  }
}

class GButton extends StatefulWidget {
  final bool? active;
  final bool? debug;
  final bool? haptic;
  final double? gap;
  final Color? iconColor;
  final Color? rippleColor;
  final Color? hoverColor;
  final Color? iconActiveColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final double? iconSize;
  final Function? onPressed;
  final String text;
  final Widget icon;
  final Color? backgroundColor;
  final Duration? duration;
  final Curve? curve;
  final Gradient? backgroundGradient;
  final Widget? leading;
  final BorderRadius? borderRadius;
  final Border? border;
  final Border? activeBorder;
  final List<BoxShadow>? shadow;
  final String? semanticLabel;

  const GButton({
    Key? key,
    this.active,
    this.haptic,
    this.backgroundColor,
    required this.icon,
    this.iconColor,
    this.rippleColor,
    this.hoverColor,
    this.iconActiveColor,
    this.text = '',
    this.textColor,
    this.padding,
    this.margin,
    this.duration,
    this.debug,
    this.gap,
    this.curve,
    this.textStyle,
    this.iconSize,
    this.leading,
    this.onPressed,
    this.backgroundGradient,
    this.borderRadius,
    this.border,
    this.activeBorder,
    this.shadow,
    this.semanticLabel,
  }) : super(key: key);

  @override
  _GButtonState createState() => _GButtonState();
}

class _GButtonState extends State<GButton> {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semanticLabel ?? widget.text,
      child: Button(
        borderRadius: widget.borderRadius,
        border: widget.border,
        activeBorder: widget.activeBorder,
        shadow: widget.shadow,
        debug: widget.debug,
        duration: widget.duration,
        iconSize: widget.iconSize,
        active: widget.active,
        onPressed: () {
          if (widget.haptic!) HapticFeedback.selectionClick();
          widget.onPressed?.call();
        },
        padding: widget.padding,
        margin: widget.margin,
        gap: widget.gap,
        color: widget.backgroundColor,
        rippleColor: widget.rippleColor,
        hoverColor: widget.hoverColor,
        gradient: widget.backgroundGradient,
        curve: widget.curve,
        leading: widget.leading,
        iconActiveColor: widget.iconActiveColor,
        iconColor: widget.iconColor,
        icon: widget.icon,
        text: Text(
          widget.text,
          style: widget.textStyle ??
              TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.textColor,
              ),
        ),
      ),
    );
  }
}

class Button extends StatefulWidget {
  const Button({
    Key? key,
    required this.icon,
    this.iconSize,
    this.leading,
    this.iconActiveColor,
    this.iconColor,
    this.text,
    this.gap,
    this.color,
    this.rippleColor,
    this.hoverColor,
    required this.onPressed,
    this.duration,
    this.curve,
    this.padding,
    this.margin,
    required this.active,
    this.debug,
    this.gradient,
    this.borderRadius,
    this.border,
    this.activeBorder,
    this.shadow,
  }) : super(key: key);

  final Widget icon;
  final double? iconSize;
  final Text? text;
  final Widget? leading;
  final Color? iconActiveColor;
  final Color? iconColor;
  final Color? color;
  final Color? rippleColor;
  final Color? hoverColor;
  final double? gap;
  final bool? active;
  final bool? debug;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Duration? duration;
  final Curve? curve;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final Border? border;
  final Border? activeBorder;
  final List<BoxShadow>? shadow;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  late bool _expanded;
  late final AnimationController expandController;

  @override
  void initState() {
    super.initState();
    _expanded = widget.active!;

    expandController =
        AnimationController(vsync: this, duration: widget.duration)
          ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    expandController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var curveValue = expandController
        .drive(CurveTween(
            curve: _expanded ? widget.curve! : widget.curve!.flipped))
        .value;
    _expanded = !widget.active!;
    if (_expanded)
      expandController.reverse();
    else
      expandController.forward();

    Widget icon = widget.icon;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        highlightColor: widget.hoverColor,
        splashColor: widget.rippleColor,
        borderRadius: widget.borderRadius,
        onTap: widget.onPressed,
        child: Container(
          // padding: widget.margin,
          child: AnimatedContainer(
            curve: Curves.easeOut,
            padding: widget.padding,
            duration: widget.duration!,
            decoration: BoxDecoration(
              boxShadow: widget.shadow,
              border: widget.active!
                  ? (widget.activeBorder ?? widget.border)
                  : widget.border,
              gradient: widget.gradient,
              color: _expanded
                  ? widget.color!.withOpacity(0)
                  : widget.debug!
                      ? Colors.red
                      : widget.gradient != null
                          ? Colors.white
                          : widget.color,
              borderRadius: widget.borderRadius,
            ),
            child: SizedBox(
              height: 20,
              child: Stack(children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Opacity(
                    opacity: 0,
                    child: icon,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      widthFactor: curveValue,
                      child: Opacity(
                          opacity: _expanded
                              ? pow(expandController.value, 13) as double
                              : expandController
                                  .drive(CurveTween(curve: Curves.easeIn))
                                  .value,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: widget.gap! +
                                    8 -
                                    (8 *
                                        expandController
                                            .drive(CurveTween(
                                                curve: Curves.easeOutSine))
                                            .value),
                                right: 2 *
                                    expandController
                                        .drive(CurveTween(
                                            curve: Curves.easeOutSine))
                                        .value),
                            child: widget.text,
                          ))),
                ]),
                Align(alignment: Alignment.centerLeft, child: icon),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
