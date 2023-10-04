import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/generated/l10n.dart';

class MenuItemCustom extends StatelessWidget {
  const MenuItemCustom({
    Key? key,
    required this.title,
    required this.image, required this.onTap,
  }) : super(key: key);
  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.getInstance().borderColor(),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageAssets.svgAssets(
                  image,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                ),
                spaceW4,
                Text(
                  title,
                  style: textNormalCustom(
                    color: AppTheme.getInstance().getBlackText(),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            spaceW8,
            Transform.rotate(
              angle: -pi,
              child: const Icon(Icons.arrow_back_ios_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
