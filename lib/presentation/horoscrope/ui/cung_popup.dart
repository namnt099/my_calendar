import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/color.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/ultis/animate/custom_rect_tween.dart';

class CungPopUp extends StatelessWidget {
  const CungPopUp({
    Key? key,
    required this.thapNhiCung,
  }) : super(key: key);
  final ThapNhiCung thapNhiCung;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Center(
      child: Hero(
        tag: '',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
          child: Material(
            color: AppTheme.getInstance().leafPrimaryColor(),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            child: Container(
              height: height / 3,
              width: width / 1.7,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: CL24272B,
                border: Border.all(
                    color: AppTheme.getInstance().leafPrimaryColor()),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            thapNhiCung.cungTen.toUpperCase(),
                            style: textNormalCustom(
                              fontSize: 14,
                              color: AppTheme.getInstance().leafPrimaryColor(),
                            ),
                          ),
                          Text(
                            thapNhiCung.cungChu.toUpperCase(),
                            style: textNormalCustom(
                              fontSize: 14,
                              color: AppTheme.getInstance().leafPrimaryColor(),
                            ),
                          ),
                        ],
                      ),
                      spaceH4,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width / 8,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: thapNhiCung.chinhTinh().isEmpty
                                ? [
                                    Text(
                                      '',
                                      style: textNormalCustom(),
                                    ),
                                  ]
                                : thapNhiCung
                                    .chinhTinh()
                                    .map(
                                      (e) => Text(
                                        '${e.saoTen.toUpperCase()}(${e.saoDacTinh})',
                                        style: e.styleSao(
                                          fontSize: 16,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                          Container(
                            width: width / 8,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 4,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '',
                                style: textNormalCustom(
                                  fontSize: 12,
                                  color:
                                      AppTheme.getInstance().whiteTextColor(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: thapNhiCung.saoTot().isEmpty
                            ? [
                                Text(
                                  '',
                                  style: textNormalCustom(),
                                ),
                              ]
                            : thapNhiCung
                                .saoTot()
                                .map(
                                  (e) => Text(
                                    e.saoTen,
                                    style: e.styleSao(
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: thapNhiCung.saoXau().isEmpty
                            ? [
                                Text(
                                  '',
                                  style: textNormalCustom(),
                                ),
                              ]
                            : thapNhiCung
                                .saoXau()
                                .map(
                                  (e) => Text(
                                    e.saoTen,
                                    style: e.styleSao(
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (thapNhiCung.tuanTrung)
                        Container(
                          width: width / 8,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().darkRed(),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Tuần',
                              style: textNormalCustom(
                                fontSize: 12,
                                color: AppTheme.getInstance().whiteTextColor(),
                              ),
                            ),
                          ),
                        ),
                      if (thapNhiCung.trietLo)
                        Container(
                          width: width / 8,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().darkRed(),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Triệt',
                              style: textNormalCustom(
                                fontSize: 12,
                                color: AppTheme.getInstance().whiteTextColor(),
                              ),
                            ),
                          ),
                        ),
                      Text(
                        thapNhiCung.vongTrangSinh().saoTen,
                        textAlign: TextAlign.center,
                        style: textNormalCustom(
                          fontSize: 14,
                          color: AppTheme.getInstance().leafPrimaryColor(),
                        ),
                      ),
                      SizedBox(
                        width: width / 13,
                        child: Center(
                          child: Text(
                            thapNhiCung.cungDaiHan.toString(),
                            style: textNormalCustom(
                              fontSize: 14,
                              color: AppTheme.getInstance().whiteTextColor(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
