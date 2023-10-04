import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/model/devine.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/presentation/horoscrope/ui/infomation_leaf.dart';
import 'package:my_calendar/widgets/app_bar.dart';

import 'leaf.dart';

final list = [
  Divine(
    'Xem Tử vi',
    ImageAssets.icSeeHoro,
    onTap: () {
      if (HiveLocal.getHoroScope().isEmpty) {
        Get.to(
          const InformationLeaf(),
        );
      } else {
        Get.to(
          LeafScreen(
            ten: '',
            gioiTinh: '',
            ngaySinh: '',
            thangSinh: '',
            namSinh: '',
            gioSinh: '',
            gioSinhStr: '',
            amLich: '',
            thamKhao: '',
            namXem: '',
            cubit: LeafCubit(),
          ),
        );
      }
    },
  ),
  Divine('Tử vi hằng ngày', ImageAssets.icHoro),
  Divine(
    'Giải sao',
    ImageAssets.icStar,
  ),
  Divine(
    'Giải mộng',
    ImageAssets.icPeople,
  ),
  Divine(
    'Tử vi trọn đời',
    ImageAssets.icCard,
  ),
  Divine(
    'Xem bói tình duyên',
    ImageAssets.icLove,
  ),
  Divine(
    '12 Cung hoàng đạo',
    ImageAssets.icZodiac,
  ),
  Divine(
    'La bàn',
    ImageAssets.icCompass,
  ),
];
final newList = [
  Divine(
    'Cưới hỏi',
    ImageAssets.icXi,
  ),
  Divine(
    'Khai trương',
    ImageAssets.icOpen,
  ),
  Divine(
    'Mua nhà',
    ImageAssets.icHouse,
  ),
  Divine(
    'Khởi công',
    ImageAssets.icShovel,
  ),
  Divine(
    'Tu tạo',
    ImageAssets.icRepair,
  ),
  Divine(
    'Khám chữa bệnh',
    ImageAssets.icDoctor,
  ),
  Divine(
    'Mua xe',
    ImageAssets.icCar,
  ),
];

class HoroscopeScreen extends StatefulWidget {
  const HoroscopeScreen({Key? key}) : super(key: key);

  @override
  State<HoroscopeScreen> createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().backgroundPrimary(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseAppBar(
            title: S.current.horoscope,
            backgroundColor: AppTheme.getInstance().primaryColor(),
            titleColor: AppTheme.getInstance().whiteTextColor(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH16,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Chọn ngày tốt',
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: newList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final type = newList[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  (index == 0 || index == newList.length - 1)
                                      ? 16
                                      : 8,
                            ),
                            child: iconTool(type),
                          ),
                        );
                      },
                    ),
                  ),
                  spaceH16,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Tiện ích',
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  spaceH16,
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (context, index) {
                      final type = list[index];
                      return GestureDetector(
                        onTap: () {},
                        child: iconTool(type),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconTool(Divine item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ImageAssets.svgAssets(
              item.image,
              fit: BoxFit.cover,
            ),
          ),
          spaceH10,
          Expanded(
            child: SizedBox(
              width: 70,
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: textNormalCustom(
                  fontSize: 14,
                  color: AppTheme.getInstance().getBlackText(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
