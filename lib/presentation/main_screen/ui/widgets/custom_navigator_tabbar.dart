import 'package:flutter/material.dart';

import '../../../../config/resources/styles.dart';
import '../../../../config/themes/app_theme.dart';
import '../tabbar_item.dart';

class BottomTabBarWidget extends StatelessWidget {
  final int selectItemIndex;
  final Function(TabBarType) onChange;
  final Function(TabBarType) onDoubleTap;

  const BottomTabBarWidget({
    Key? key,
    required this.selectItemIndex,
    required this.onChange,
    required this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listItem = getTabListItem();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().backgroundColor(),
        border: Border(
          top: BorderSide(
            color: AppTheme.getInstance().backgroundColor(),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: List.generate(listItem.length, (index) {
            final tab = listItem[index];

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  onChange(tab);
                },
                child: tabBarItem(
                  context: context,
                  item: tab,
                  isSelect: index == selectItemIndex,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget tabBarItem({
    required BuildContext context,
    required TabBarType item,
    bool isSelect = false,
  }) {
    return ColoredBox(
      color: AppTheme.getInstance().backgroundColor(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          item.getTabBarItem(isSelect: isSelect).icon,
          spaceH4,
          Text(
            item.getTabBarItem().text,
            style: textNormalCustom(
              color: isSelect
                  ? AppTheme.getInstance().primaryColor()
                  : AppTheme.getInstance().getBlackText(),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
