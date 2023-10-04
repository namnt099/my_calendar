import 'package:flutter/material.dart';

Future<T?> showBottomSheetAutoHide<T>(
    BuildContext context, {
      required Widget child,
    }) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child
            ],
          )
        ],
      );
    },
  );
}
