import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/model/horoscope/animal.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/presentation/horoscrope/ui/infomation_leaf.dart';
import 'package:my_calendar/presentation/horoscrope/ui/leaf.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/menu_select_widget.dart';
import 'package:my_calendar/widgets/textfield/custom_textfield.dart';

class HistoryLeaf extends StatefulWidget {
  const HistoryLeaf({Key? key}) : super(key: key);

  @override
  State<HistoryLeaf> createState() => _HistoryLeafState();
}

class _HistoryLeafState extends State<HistoryLeaf> {
  List<HoroScope> listData = [];
  final dataSubject = BehaviorSubject<List<HoroScope>>.seeded([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listData = HiveLocal.getHoroScope();
    dataSubject.sink.add(listData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(
            const InformationLeaf(
              add: true,
            ),
          );
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.getInstance().darkRed(),
          ),
          child: Icon(
            Icons.add,
            color: AppTheme.getInstance().leafPrimaryColor(),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseAppBar(
            title: 'Lá số đã xem',
            backgroundColor: AppTheme.getInstance().darkRed(),
          ),
          spaceH16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextField(
              hintText: 'Tìm kiếm...',
              textChange: (value) {
                print(value);
                if (value.isNotEmpty) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    final data = dataSubject.value;
                    final newList = data
                        .where(
                          (element) => element.thienBan.ten.contains(value),
                        )
                        .toList();
                    dataSubject.sink.add(newList);
                  });
                } else {
                  dataSubject.sink.add(listData);
                }
              },
              color: AppTheme.getInstance().leafPrimaryColor(),
              textInputType: TextInputType.text,
              isShowClearText: false,
              prefixIcon: Icon(
                Icons.search,
                color: AppTheme.getInstance().leafPrimaryColor(),
              ),
            ),
          ),
          spaceH16,
          StreamBuilder<List<HoroScope>>(
              stream: dataSubject.stream,
              builder: (context, snapshot) {
                final List<HoroScope> data = snapshot.data ?? <HoroScope>[];
                return data.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              itemHistory(data[index].thienBan, index),
                        ),
                      )
                    : Text(
                        'Không có dữ liệu',
                        style: textNormalCustom(
                          color: AppTheme.getInstance().getBlackText(),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
              })
        ],
      ),
    );
  }

  Widget itemHistory(ThienBan data, int index) {
    final animal = Animal.data
        .where((element) => data.chiGioSinh.tenChi == element.name)
        .toList()
        .first;
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LeafScreen(
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
              index: index,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.getInstance().borderColor(),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ImageAssets.svgAssets(
                  animal.image,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                ),
                spaceW8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      data.ten.isEmpty ? '(Rỗng)' : data.ten,
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    spaceH4,
                    Text(
                      data.amDuongNamSinh == 'Dương'
                          ? '${data.ngayDuong}/${data.thangDuong}/${data.namDuong}'
                              ' (Dương)'
                          : '${data.ngayAm}/${data.thangAm}/${data.namAm}'
                              ' (Âm)',
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontSize: 14,
                      ),
                    ),
                    spaceH4,
                    Text(
                      data.gioiTinh == 1 ? 'Nam' : 'Nữ',
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            MenuSelectWidget(
              listSelect: [
                CellPopPupMenu(
                  urlImage: '',
                  text: 'Sửa',
                  onTap: () {},
                ),
                CellPopPupMenu(
                  urlImage: '',
                  text: 'Xóa',
                  onTap: () {
                    HiveLocal.deleteAt(index);
                    listData = HiveLocal.getHoroScope();
                    dataSubject.sink.add(listData);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
