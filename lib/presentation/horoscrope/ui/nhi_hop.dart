import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/color.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/widgets/app_bar.dart';

class NhiHop extends StatefulWidget {
  const NhiHop({
    Key? key,
    required this.index,
    required this.horoScope,
  }) : super(key: key);
  final HoroScope horoScope;
  final int index;

  @override
  State<NhiHop> createState() => _NhiHopState();
}

class _NhiHopState extends State<NhiHop> {
  late final width;
  late final height;
  int index1 = 0;
  int index2 = 0;

  @override
  void initState() {
    super.initState();
    if (widget.index == 1) {
      index1 = 1;
      index2 = 2;
    } else if (widget.index == 2) {
      index1 = 2;
      index2 = 1;
    } else {
      index1 = widget.index;
      index2 = 15 - index1;
    }
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
      body: Column(
        children: [
          BaseAppBar(
            title: 'Nhị hợp',
            titleColor: AppTheme.getInstance().leafPrimaryColor(),
            leading: BackLeading(
              color: AppTheme.getInstance().leafPrimaryColor(),
            ),
            backgroundColor: AppTheme.getInstance().darkRed(),
            actions: [
              InkWell(
                child: ImageAssets.svgAssets(
                  ImageAssets.icUser,
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
              ),
              spaceW16,
            ],
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
            children: [box, box, box, box],
          ),
          Row(
            children: [
              itemLeaf(thapNhiCung: widget.horoScope.thapNhiCung[index1]),
              itemLeaf(thapNhiCung: widget.horoScope.thapNhiCung[index2]),
            ],
          ),
          Row(
            children: [box, box, box, box],
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

  Widget get box => Container(
        height: height / 6,
        width: width / 4,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.getInstance().getBlackText().withOpacity(0.5),
            width: 0.5,
          ),
        ),
      );

  Widget itemLeaf({required ThapNhiCung thapNhiCung}) {
    return Container(
      height: height / 3,
      width: width / 2,
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
                    width: width / 14,
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
                                e.layTen(),
                                style: e.styleSao(
                                  fontSize: 16,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                  Container(
                    width: width / 14,
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
                            e.layTen(),
                            style: e.styleSao(
                              fontSize: 12,
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
                            e.layTen(),
                            style: e.styleSao(
                              fontSize: 12,
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
