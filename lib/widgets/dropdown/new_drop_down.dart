import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/widgets/dropdown/cool_drop_down/cool_drop_down_custom.dart';

class CoolDropDownItem {
  String label;
  String value;

  CoolDropDownItem({
    required this.label,
    required this.value,
  });
}

class NewCustomDropDown extends StatefulWidget {
  final String placeHoder;
  final String initData;
  final Function(int) onChange;
  final List<String> listData;
  final List<CoolDropDownItem>? listDataWithValue;
  final double? setWidth;
  final int maxLines;
  final bool showSelectedDecoration;
  final bool useCustomHintColors;
  final Widget? selectedIcon;
  final bool needReInitData;
  final double? fontSize;
  final bool showClearButton;
  final Color? selectedColor;
  final Widget? suffixIcon;

  const NewCustomDropDown({
    Key? key,
    this.placeHoder = '',
    required this.onChange,
    required this.listData,
    this.listDataWithValue,
    required this.initData,
    this.setWidth,
    this.maxLines = 1,
    this.showSelectedDecoration = true,
    this.selectedIcon,
    this.useCustomHintColors = false,
    this.needReInitData = false,
    this.fontSize,
    this.showClearButton = false,
    this.selectedColor,
    this.suffixIcon,
  }) : super(key: key);

  @override
  NewCustomDropDownState createState() => NewCustomDropDownState();
}

class NewCustomDropDownState extends State<NewCustomDropDown> {
  final List<Map<dynamic, dynamic>> listSelect = [];
  int initIndex = -1;
  late int selectedIndex;
  final _dropKey = GlobalKey<CoolDropdownState>();

  @override
  void initState() {
    initListSelect();
    getCurrentIndex();
    selectedIndex = initIndex;
    super.initState();
  }

  void getCurrentIndex() {
    if (widget.listDataWithValue != null) {
      initIndex = widget.listDataWithValue!.indexWhere(
        (element) => element.value == widget.initData,
      );
    } else {
      initIndex = widget.listData.indexOf(widget.initData);
    }
  }

  @override
  void didUpdateWidget(covariant NewCustomDropDown oldWidget) {
    if (widget.needReInitData && listSelect.isEmpty) {
      initListSelect();
    }
    super.didUpdateWidget(oldWidget);
  }

  void initListSelect() {
    if (widget.listDataWithValue != null) {
      for (var i = 0; i < widget.listDataWithValue!.length; i++) {
        listSelect.add({
          'label': widget.listDataWithValue![i].label,
          'value': widget.listDataWithValue![i].value,
          'icon': const SizedBox(),
        });
      }
    } else {
      for (var i = 0; i < widget.listData.length; i++) {
        listSelect.add({
          'label': widget.listData[i],
          'value': widget.listData[i],
          'icon': const SizedBox(),
        });
      }
    }
  }

  void initData({required List<String> data, required String value}) {
    listSelect.clear();
    for (var i = 0; i < widget.listData.length; i++) {
      listSelect.add({
        'label': widget.listData[i],
        'value': widget.listData[i],
        'icon': const SizedBox(),
      });
    }
    initIndex = widget.listData.indexOf(widget.initData);
    _dropKey.currentState?.initData(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
      key: _dropKey,
      maxLines: widget.maxLines,
      defaultValue: initIndex < 0 ? null : listSelect[initIndex],
      dropdownHeight: 200,
      resultAlign: Alignment.center,
      dropdownList: listSelect,
      suffixIcon: widget.suffixIcon,
      onChange: (value) {
        selectedIndex = listSelect.indexOf(value);
        widget.onChange(selectedIndex);
        setState(() {});
      },
      placeholder: widget.placeHoder,
      selectedItemTS: textNormalCustom(
        fontSize: widget.fontSize ?? 14.0,
        color: widget.selectedColor ?? AppTheme.getInstance().getBlackText(),
      ),
      unselectedItemTS: textNormalCustom(
        fontSize: widget.fontSize ?? 14,
        color: AppTheme.getInstance().getBlackText(),
      ),
      selectedItemBD: widget.showSelectedDecoration
          ? BoxDecoration(
              color: AppTheme.getInstance().borderColor(),
              borderRadius: BorderRadius.circular(6),
            )
          : const BoxDecoration(),
      resultTS: textNormalCustom(
        fontSize: widget.fontSize ?? 14,
        color: AppTheme.getInstance().leafPrimaryColor(),
      ),
      placeholderTS: textNormalCustom(
        fontSize: widget.fontSize ?? 14,
        color: widget.useCustomHintColors
            ? AppTheme.getInstance().leafPrimaryColor().withOpacity(0.5)
            : AppTheme.getInstance().leafPrimaryColor(),
      ),
      selectedIcon: widget.selectedIcon,
      resultBD: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppTheme.getInstance().borderColor().withOpacity(0.5),
        ),
      ),
      dropdownBD: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        border: Border.all(
          color: AppTheme.getInstance().borderColor().withOpacity(0.5),
        ),
      ),
      isTriangle: false,
      gap: 1.0,
      resultIconRotation: selectedIndex < 0,
      resultIcon: widget.showClearButton
          ? selectedIndex < 0
              ? null
              : GestureDetector(
                  onTap: () {
                    widget.onChange(-1);
                  },
                  child: Icon(
                    Icons.close,
                    color: AppTheme.getInstance().getBlackText(),
                  ),
                )
          : null,
    );
  }
}
