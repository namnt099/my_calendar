import 'package:flutter/material.dart';

Future<T?> showBottomSheetCustom<T>(
  BuildContext context, {
  required Widget child,
  required String title,
  Color? colorTitle,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: false,
    isDismissible: false,
    enableDrag: false,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child
              ],
            ),
          )
        ],
      );
    },
  );
}
