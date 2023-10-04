import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({
    Key? key,
    required this.image,
    required this.text, required this.onTap,
  }) : super(key: key);
  final String image;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: ImageAssets.svgAssets(
                image,
                fit: BoxFit.cover,
              ),
            ),
            spaceW16,
            Text(
              text,
              style: textNormalCustom(
                color: AppTheme.getInstance().getBlackText(),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
