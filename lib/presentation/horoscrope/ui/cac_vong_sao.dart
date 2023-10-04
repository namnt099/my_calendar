// ignore_for_file: prefer_typing_uninitialized_variables, type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/color.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/widgets/app_bar.dart';

class CacVongSao extends StatefulWidget {
  const CacVongSao({
    Key? key,
    required this.horoScope,
  }) : super(key: key);

  final HoroScope horoScope;

  @override
  State<CacVongSao> createState() => _CacVongSaoState();
}

class _CacVongSaoState extends State<CacVongSao> {
  late final width;
  late final height;
  late final List<ThapNhiCung> thapNhi;
  late final LeafCubit cubit;

  @override
  void initState() {
    super.initState();
    thapNhi = widget.horoScope.thapNhiCung;
    cubit = LeafCubit();
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
            title: 'Các vòng sao',
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
            children: [
              itemLeaf(thapNhi[6]),
              itemLeaf(thapNhi[7]),
              itemLeaf(thapNhi[8]),
              itemLeaf(thapNhi[9]),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  itemLeaf(thapNhi[5]),
                  itemLeaf(thapNhi[4]),
                ],
              ),
              itemLeafCenter(),
              Column(
                children: [
                  itemLeaf(thapNhi[10]),
                  itemLeaf(thapNhi[11]),
                ],
              ),
            ],
          ),
          Row(
            children: [
              itemLeaf(thapNhi[3]),
              itemLeaf(thapNhi[2]),
              itemLeaf(thapNhi[1]),
              itemLeaf(thapNhi[12]),
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

  Widget itemLeaf(ThapNhiCung thapNhiCung) {
    return Container(
      height: height / 6,
      width: width / 4,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().leafPrimaryColor(),
        ),
      ),
      child: StreamBuilder<int>(
        stream: cubit.indexSubject.stream,
        builder: (context, snapshot) {
          final snapIndex = snapshot.data ?? 0;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      thapNhiCung.cungTen.toUpperCase(),
                      style: textNormalCustom(
                        fontSize: 10,
                        color: AppTheme.getInstance().leafPrimaryColor(),
                      ),
                    ),
                    Text(
                      thapNhiCung.cungChu.toUpperCase(),
                      style: textNormalCustom(
                        fontSize: 10,
                        color: AppTheme.getInstance().whiteTextColor(),
                      ),
                    ),
                  ],
                ),
              ),
              if (snapIndex == 0 || snapIndex == 3)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
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
                                fontSize: 12,
                              ),
                            ),
                          )
                          .toList(),
                ),
              if (snapIndex == 2 || snapIndex == 3 || snapIndex == 1)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (snapIndex == 2 || snapIndex == 3)
                      Text(
                        thapNhiCung.vongLocTon().layTen(),
                        style: thapNhiCung.vongLocTon().styleSao(
                              fontSize: 12,
                            ),
                      ),
                    if (snapIndex == 1 || snapIndex == 3)
                      Text(
                        thapNhiCung.vongThaiTue().layTen(),
                        style: thapNhiCung.vongThaiTue().styleSao(
                              fontSize: 12,
                            ),
                      ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      thapNhiCung.cungAmDuong == 1 ? '+' : '-',
                      style: textNormalCustom(
                        fontSize: 12,
                        color: AppTheme.getInstance().dfTxtColor(),
                      ),
                    ),
                    Text(
                      thapNhiCung.vongTrangSinh().saoTen,
                      textAlign: TextAlign.center,
                      style: textNormalCustom(
                        fontSize: 12,
                        color: AppTheme.getInstance().leafPrimaryColor(),
                      ),
                    ),
                    Text(
                      thapNhiCung.cungDaiHan.toString(),
                      style: textNormalCustom(
                        fontSize: 12,
                        color: AppTheme.getInstance().dfTxtColor(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemLeafCenter() {
    return Container(
      height: height / 6 * 2,
      width: width / 4 * 2,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: CL24272B,
        border: Border.all(
          color: AppTheme.getInstance().leafPrimaryColor(),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          cubit.vongSao.length,
          (index) => StreamBuilder<int>(
            stream: cubit.indexSubject.stream,
            builder: (context, snapshot) {
              final snapIndex = snapshot.data ?? 0;
              return GestureDetector(
                onTap: () {
                  cubit.vongSao[index].onTap?.call();
                },
                child: Text(
                  cubit.vongSao[index].title,
                  style: textNormalCustom(
                    fontSize: 14,
                    color: index == snapIndex
                        ? CL0ABAB5
                        : AppTheme.getInstance().leafPrimaryColor(),
                  ),
                ),
              );
            },
          ),
        ),
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
