// ignore_for_file: prefer_typing_uninitialized_variables, type_annotate_public_apis

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/color.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/data/exception/app_exception.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/presentation/horoscrope/ui/cac_vong_sao.dart';
import 'package:my_calendar/presentation/horoscrope/ui/dai_van.dart';
import 'package:my_calendar/presentation/horoscrope/ui/history.dart';
import 'package:my_calendar/presentation/horoscrope/ui/menh.dart';
import 'package:my_calendar/presentation/horoscrope/ui/van_han.dart';
import 'package:my_calendar/ultis/animate/hero_dialog_route.dart';
import 'package:my_calendar/ultis/extension/string_ext.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/views/state_stream_layout.dart';

import '../../../widgets/menu_select_widget.dart';
import 'cung_popup.dart';

class LeafScreen extends StatefulWidget {
  const LeafScreen({
    Key? key,
    required this.ten,
    required this.gioiTinh,
    required this.ngaySinh,
    required this.thangSinh,
    required this.namSinh,
    required this.gioSinh,
    required this.gioSinhStr,
    required this.amLich,
    required this.thamKhao,
    required this.namXem,
    required this.cubit,
    this.index,
    this.add = false,
  }) : super(key: key);
  final String ten;
  final String gioiTinh;
  final String ngaySinh;
  final String thangSinh;
  final String namSinh;
  final String gioSinh;
  final String gioSinhStr;
  final String amLich;
  final String thamKhao;
  final String namXem;
  final LeafCubit cubit;
  final int? index;
  final bool add;

  @override
  State<LeafScreen> createState() => _LeafScreenState();
}

class _LeafScreenState extends State<LeafScreen> {
  late final width;
  late final height;
  HoroScope _horo = HoroScope();
  ThienBan thienBan = ThienBan();

  @override
  void initState() {
    super.initState();
    if (HiveLocal.getHoroScope().isEmpty || widget.add) {
      widget.cubit.laSoTuVi(
        widget.ten,
        widget.gioiTinh,
        widget.ngaySinh,
        widget.thangSinh,
        widget.namSinh,
        widget.amLich,
        widget.gioSinh,
        '7',
        widget.thamKhao,
        widget.namXem,
      );
    } else {
      widget.index != null
          ? widget.cubit.horoSubject.sink
              .add(HiveLocal.getHoroScope()[widget.index!])
          : widget.cubit.horoSubject.sink.add(HiveLocal.getHoroScope().last);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.cubit.horoSubject.sink.addError(AppException('title', 'message'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateStreamLayout(
        stream: widget.cubit.stateStream,
        error: AppException('Lỗi', 'Đã có lỗi xảy ra'),
        retry: () {},
        textEmpty: 'Không có dữ liệu',
        child: Scaffold(
          backgroundColor: AppTheme.getInstance().accentColor(),
          body: StreamBuilder<HoroScope>(
            stream: widget.cubit.horoSubject.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? HoroScope();
              _horo = data;
              final thapNhi = data.thapNhiCung;
              return snapshot.data == null
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        BaseAppBar(
                          title: 'Lá số tử vi',
                          titleColor: AppTheme.getInstance().leafPrimaryColor(),
                          leading: BackLeading(
                            color: AppTheme.getInstance().leafPrimaryColor(),
                          ),
                          backgroundColor: AppTheme.getInstance().darkRed(),
                          actions: [
                            MenuSelectWidget(
                              listSelect: [
                                CellPopPupMenu(
                                  urlImage: '',
                                  text: 'Lịch sử xem',
                                  onTap: () {
                                    Get.to(const HistoryLeaf());
                                  },
                                ),
                                CellPopPupMenu(
                                  urlImage: '',
                                  text: 'Đại vận',
                                  onTap: () {
                                    Get.to(
                                      DaiVan(
                                        index: widget.index,
                                      ),
                                    );
                                  },
                                ),
                                CellPopPupMenu(
                                  urlImage: '',
                                  text: 'Vận hạn',
                                  onTap: () {
                                    Get.to(
                                      VanHan(
                                        index: widget.index,
                                      ),
                                    );
                                  },
                                ),
                                CellPopPupMenu(
                                  urlImage: '',
                                  text: 'Thống kê',
                                  onTap: () {
                                    widget.cubit.trondoi(
                                      widget.ten,
                                      widget.gioiTinh,
                                      widget.ngaySinh,
                                      widget.thangSinh,
                                      widget.namSinh,
                                      widget.amLich,
                                      widget.gioSinh,
                                      widget.namXem,
                                      '7',
                                    );
                                  },
                                ),
                              ],
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
                            itemLeaf(thapNhi[6], 6),
                            itemLeaf(thapNhi[7], 7),
                            itemLeaf(thapNhi[8], 8),
                            itemLeaf(thapNhi[9], 9),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                itemLeaf(thapNhi[5], 5),
                                itemLeaf(thapNhi[4], 4),
                              ],
                            ),
                            itemLeafCenter(data.thienBan),
                            Column(
                              children: [
                                itemLeaf(thapNhi[10], 10),
                                itemLeaf(thapNhi[11], 11),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            itemLeaf(thapNhi[3], 3),
                            itemLeaf(thapNhi[2], 2),
                            itemLeaf(thapNhi[1], 1),
                            itemLeaf(thapNhi[12], 12),
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
                          'Các vòng sao',
                          () {
                            Get.to(CacVongSao(horoScope: _horo));
                          },
                          width: width / 3.5,
                        ),
                      ],
                    );
            },
          ),
        ),
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

  Widget itemLeaf(ThapNhiCung thapNhiCung, int index) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) {
              return CungPopUp(
                thapNhiCung: thapNhiCung,

              );
            },
            isNonBackground: false,
          ),
        );
      },
      onTap: () {
        Get.to(
          MenhScreen(
            thapNhiCung: thapNhiCung,
            index: index,
            horoScope: _horo,
            leafCubit: widget.cubit,
            cungChu: 'CUNG ${thapNhiCung.cungChu.toUpperCase()}',
            indexGiaiDoan: widget.index,
          ),
        );
      },
      child: Container(
        height: height / 6,
        width: width / 4,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.getInstance().leafPrimaryColor(),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        thapNhiCung.cungTen,
                        style: textNormalCustom(
                          fontSize: 10,
                          color: AppTheme.getInstance().leafPrimaryColor(),
                        ),
                      ),
                      Text(
                        thapNhiCung.cungChu,
                        style: textNormalCustom(
                          fontSize: 10,
                          color: AppTheme.getInstance().whiteTextColor(),
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH4,
                if (thapNhiCung.chinhTinh().isNotEmpty) ...[
                  Text(
                    thapNhiCung.saoChinhTinh().toUpperCase(),
                    style: thapNhiCung.styleChinhTinh(),
                  ),
                ],
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
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
                                    e.layTen(lower: true).splitStr(),
                                    style: e.styleSao(
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
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
                                    e.layTen(lower: true).splitStr(),
                                    style: e.styleSao(
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (thapNhiCung.trietLo)
                  Container(
                    width: width / 13.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
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
                          fontSize: 8,
                          color: AppTheme.getInstance().whiteTextColor(),
                        ),
                      ),
                    ),
                  ),
                if (thapNhiCung.tuanTrung && !thapNhiCung.trietLo)
                  Container(
                    width: width / 13.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
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
                          fontSize: 8,
                          color: AppTheme.getInstance().whiteTextColor(),
                        ),
                      ),
                    ),
                  ),
                if (!thapNhiCung.tuanTrung && !thapNhiCung.trietLo)
                  SizedBox(
                    width: width / 13.5,
                  ),
                Text(
                  thapNhiCung.vongTrangSinh().saoTen,
                  textAlign: TextAlign.center,
                  style: textNormalCustom(
                    fontSize: 8,
                    color: AppTheme.getInstance().leafPrimaryColor(),
                  ),
                ),
                if (thapNhiCung.tuanTrung && thapNhiCung.trietLo)
                  Container(
                    width: width / 13.5,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().darkRed(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Tuần',
                        style: textNormalCustom(
                          fontSize: 8,
                          color: AppTheme.getInstance().whiteTextColor(),
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: width / 13.5,
                    child: Center(
                      child: Text(
                        thapNhiCung.cungDaiHan.toString(),
                        style: textNormalCustom(
                          fontSize: 8,
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
    );
  }

  Widget itemLeafCenter(ThienBan thienBan) {
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
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          itemRow('Ngày xem', thienBan.today),
          itemRow('Họ tên', thienBan.ten),
          itemRow(
            'Năm',
            '${thienBan.namDuong} ${thienBan.canNamTen} ${thienBan.chiNamTen}',
          ),
          itemRow(
            'Tháng',
            '${thienBan.thangDuong} ${thienBan.canThangTen} ${thienBan.chiThangTen}',
          ),
          itemRow(
            'Ngày',
            '${thienBan.ngayDuong} ${thienBan.canNgayTen} ${thienBan.chiNgayTen}',
          ),
          itemRow(
            'Giờ',
            thienBan.gioSinh,
          ),
          spaceH16,
          itemRow('Âm dương', thienBan.amDuongMenh),
          itemRow('Bản mệnh', thienBan.banMenh),
          itemRow('Cục', thienBan.tenCuc),
          itemRow('Mệnh chủ', thienBan.menhChu),
          itemRow('Thân chủ', thienBan.thanChu),
        ],
      ),
    );
  }

  Widget buildBlur({
    required Widget child,
    BorderRadius borderRadius = BorderRadius.zero,
    double sigmaX = 4,
    double sigmaY = 4,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
        ),
        child: child,
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
