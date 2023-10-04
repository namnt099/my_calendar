import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/color.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/presentation/horoscrope/ui/cung_giap.dart';
import 'package:my_calendar/presentation/horoscrope/ui/giai_doan.dart';
import 'package:my_calendar/presentation/horoscrope/ui/nhi_hop.dart';
import 'package:my_calendar/presentation/horoscrope/ui/nhi_khac.dart';
import 'package:my_calendar/presentation/horoscrope/ui/tam_hop.dart';
import 'package:my_calendar/presentation/horoscrope/ui/xung_chieu.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/app_button.dart';

class MenhScreen extends StatefulWidget {
  const MenhScreen({
    Key? key,
    required this.thapNhiCung,
    required this.index,
    required this.horoScope,
    required this.leafCubit,
    required this.cungChu,
    this.indexGiaiDoan,
  }) : super(key: key);
  final ThapNhiCung thapNhiCung;
  final HoroScope horoScope;
  final int index;
  final LeafCubit leafCubit;
  final String cungChu;
  final int? indexGiaiDoan;

  @override
  State<MenhScreen> createState() => _MenhScreenState();
}

class _MenhScreenState extends State<MenhScreen> {
  late final width;
  late final height;
  late final ThapNhiCung thapNhiCung;
  late final List<Map<String, dynamic>> data;

  @override
  void initState() {
    thapNhiCung = widget.thapNhiCung;
    getData();
    super.initState();
  }

  void getData() {
    final temp = widget.leafCubit.dataGiaiDoan.isEmpty
        ? widget.indexGiaiDoan != null
            ? HiveLocal.getGiaiDoan()[widget.indexGiaiDoan!]
            : HiveLocal.getGiaiDoan().last
        : widget.leafCubit.dataGiaiDoan;
    data = temp
        .where((element) => widget.cungChu.toUpperCase() == element['title0'])
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().accentColor(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              BaseAppBar(
                title: 'Mệnh',
                titleColor: AppTheme.getInstance().leafPrimaryColor(),
                leading: BackLeading(
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
                backgroundColor: AppTheme.getInstance().darkRed(),
              ),
              spaceH8,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemListTextTop('Miếu địa'),
                  itemListTextTop('Vượng địa'),
                  itemListTextTop('Đắc địa'),
                  itemListTextTop('Hãm địa'),
                  itemListTextTop('Bình hỏa'),
                ],
              ),
              spaceH8,
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        NhiHop(
                          index: widget.index,
                          horoScope: widget.horoScope,
                        ),
                      );
                    },
                    child: itemLeaf(
                      'NHỊ\nHỢP',
                      crossAxisAlignment: CrossAxisAlignment.end,
                      right: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        CungGiap(
                          index: widget.index,
                          horoScope: widget.horoScope,
                        ),
                      );
                    },
                    child: itemLeaf(
                      'CU\nGI',
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        CungGiap(
                          index: widget.index,
                          horoScope: widget.horoScope,
                        ),
                      );
                    },
                    child: itemLeaf(
                      'NG\nÁP',
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        NhiKhac(
                          index: widget.index,
                          horoScope: widget.horoScope,
                        ),
                      );
                    },
                    child: itemLeaf(
                      'NHỊ\nKHẮC',
                      crossAxisAlignment: CrossAxisAlignment.start,
                      left: 16,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    XungChieu(
                      index: widget.index,
                      horoScope: widget.horoScope,
                    ),
                  );
                },
                child: Row(
                  children: [
                    Column(
                      children: [
                        itemLeaf(
                          'XUNG',
                          mainAxisAlignment: MainAxisAlignment.end,
                          right: 16,
                        ),
                        itemLeaf(
                          'CHIẾU',
                          mainAxisAlignment: MainAxisAlignment.start,
                          right: 16,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 3,
                      width: width / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          TamHop(
                            horoScope: widget.horoScope,
                            index: widget.index,
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          itemLeaf(
                            'TAM',
                            mainAxisAlignment: MainAxisAlignment.end,
                            left: 16,
                          ),
                          itemLeaf(
                            'HỢP',
                            mainAxisAlignment: MainAxisAlignment.start,
                            left: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  itemLeaf(''),
                  itemLeaf(''),
                  itemLeaf(''),
                  itemLeaf(''),
                ],
              ),
              spaceH16,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemFive(Colors.white, 'Kim'),
                  itemFive(CL0ABAB5, 'Mộc'),
                  itemFive(CLDCFFFE, 'Thủy'),
                  itemFive(CL303742, 'Hỏa'),
                  itemFive(CL808FA8, 'Thổ'),
                ],
              ),
              spaceH16,
              AppButton(
                'Giải đoán',
                () {
                  Get.to(
                    GiaiDoan(
                      data: data,
                      indexGD: widget.indexGiaiDoan,
                    ),
                  );
                },
                width: 200,
              ),
            ],
          ),
          itemLeafCenter(h: height / 3 + 50, w: width / 2 + 50)
        ],
      ),
    );
  }

  Widget itemListTextTop(String label) {
    final firstSpell = label.substring(0, 1);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstSpell,
            style: textNormalCustom(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.getInstance().whiteTextColor(),
            ),
          ),
          const TextSpan(
            text: '  ',
          ),
          TextSpan(
            text: label,
            style: textNormalCustom(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.getInstance().leafPrimaryColor(),
            ),
          )
        ],
      ),
    );
  }

  Widget itemFive(Color color, String label) {
    return Row(
      children: [
        Container(
          height: 14,
          width: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.elliptical(14, 14),
            ),
          ),
        ),
        spaceW4,
        Text(
          label,
          style: textNormalCustom(
            color: AppTheme.getInstance().leafPrimaryColor(),
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget itemLeaf(
    String? text, {
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    double? top,
    double? left,
    double? right,
    double? bottom,
    TextAlign? textAlign,
  }) {
    return Container(
      height: height / 6,
      width: width / 4,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().getBlackText().withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: top ?? 0,
              left: left ?? 0,
              right: right ?? 0,
              bottom: bottom ?? 0,
            ),
            child: Text(
              text ?? '',
              textAlign: textAlign ?? TextAlign.center,
              style: textNormalCustom(
                fontSize: 14,
                color: AppTheme.getInstance().leafPrimaryColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemLeafCenter({
    double? h,
    double? w,
  }) {
    return Container(
      height: h ?? height / 3,
      width: w ?? width / 2,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: CL24272B,
        border: Border.all(color: AppTheme.getInstance().leafPrimaryColor()),
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
                  Container(
                    width: width / 13,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: thapNhiCung.trietLo
                          ? AppTheme.getInstance().darkRed()
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        thapNhiCung.trietLo ? 'Triệt' : '',
                        style: textNormalCustom(
                          fontSize: 10,
                          color: AppTheme.getInstance().whiteTextColor(),
                        ),
                      ),
                    ),
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
                    width: width / 13,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
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
                          fontSize: 10,
                          color: AppTheme.getInstance().whiteTextColor(),
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
              Container(
                width: width / 13,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                decoration: BoxDecoration(
                  color: thapNhiCung.tuanTrung
                      ? AppTheme.getInstance().darkRed()
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    thapNhiCung.tuanTrung ? 'Tuần' : '',
                    style: textNormalCustom(
                      fontSize: 10,
                      color: AppTheme.getInstance().whiteTextColor(),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '',
                    style: textNormalCustom(),
                  ),
                ],
              ),
              Container(
                width: width / 13,
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
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
                      fontSize: 10,
                      color: AppTheme.getInstance().whiteTextColor(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemRow(String label, String content) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: textNormalCustom(
                fontSize: 12,
                color: AppTheme.getInstance().leafPrimaryColor(),
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: textNormalCustom(
                fontSize: 12,
                color: AppTheme.getInstance().dfTxtColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
