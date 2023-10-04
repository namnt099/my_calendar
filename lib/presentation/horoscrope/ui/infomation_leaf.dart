import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/resources/color.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/model/horoscope/animal.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/presentation/horoscrope/ui/leaf.dart';
import 'package:my_calendar/widgets/app_bar.dart';
import 'package:my_calendar/widgets/app_button.dart';
import 'package:my_calendar/widgets/bottom_sheet/bottom_sheet_auto_hide.dart';
import 'package:my_calendar/widgets/calendar_view/extension/lich/date_picker_widget.dart';
import 'package:my_calendar/widgets/dropdown/cool_drop_down/cool_drop_down_custom.dart';
import 'package:my_calendar/widgets/dropdown/new_drop_down.dart';
import 'package:my_calendar/widgets/textfield/custom_textfield.dart';

class InformationLeaf extends StatefulWidget {
  const InformationLeaf({Key? key, this.add = false}) : super(key: key);
  final bool add;

  @override
  State<InformationLeaf> createState() => _InformationLeafState();
}

class _InformationLeafState extends State<InformationLeaf> {
  late final LeafCubit _cubit;
  DateTime date = DateTime.now();
  String ten = '';
  String namXem = '';
  String gioiTinh = '';
  String ngaySinh = '';
  String thangSinh = '';
  String namSinh = '';
  String gioSinh = '';
  String gioSinhStr = '';
  String amLich = '';
  String thamKhao = '1';
  List<String> listGT = ['Nam', 'Nữ'];
  List<String> listTLTK = [
    'Tất cả',
    'Tử vi Phú Giải của Thái Vân Trình',
    'Tử Vi của Nguyễn Mạnh Bảo',
    'Tử Vi Đẩu Số của Vân Đằng Thái Thứ Lang',
    'Tử vi giảng minh',
    'Tử vi đẩu số tân biên - Vân Đằng Thái Thứ Lang',
    'Tử Vi Áo Bí Biện Chứng Học',
    'Linh khu thời mệnh lý của Lê Hưng VKD',
    'Không rõ nguồn'
  ];

  @override
  void initState() {
    super.initState();
    _cubit = LeafCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CL28C76F,
      appBar: AppBar(
        backgroundColor: CL28C76F,
        leading: BackLeading(
          color: AppTheme.getInstance().leafPrimaryColor(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nhập thông tin lá số',
                style: textNormalCustom(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
              ),
              spaceH50,
              NewCustomDropDown(
                selectedColor: AppTheme.getInstance().getBlackText(),
                placeHoder: 'Giới tính',
                initData: '',
                suffixIcon: ImageAssets.svgAssets(
                  ImageAssets.icSex,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
                useCustomHintColors: true,
                listData: listGT,
                onChange: (index) {
                  if (index == 0) {
                    gioiTinh = 'nam';
                  } else {
                    gioiTinh = 'nu';
                  }
                },
              ),
              spaceH16,
              CustomTextField(
                hintText: S.current.user_name,
                textChange: (value) {
                  ten = value;
                },
                color: AppTheme.getInstance().leafPrimaryColor(),
                textInputType: TextInputType.text,
                isShowClearText: false,
                prefixIcon: ImageAssets.svgAssets(
                  ImageAssets.icUser,
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
              ),
              spaceH16,
              GestureDetector(
                onTap: () {
                  showBottomSheetAutoHide(
                    context,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: AppTheme.getInstance().darkRed(),
                          child: Center(
                            child: Text(
                              'CHỌN GIỜ SINH',
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.getInstance().whiteTextColor(),
                              ),
                            ),
                          ),
                        ),
                        spaceH24,
                        Container(
                          height: 120,
                          color: Colors.white,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Animal.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  gioSinh = '${index + 1}';
                                  _cubit.gioSinhSubject.sink.add(
                                    Animal.data[index].name,
                                  );
                                  gioSinhStr = Animal.data[index].name;
                                  Navigator.pop(context);
                                },
                                child: item(
                                  Animal.data[index].name,
                                  Animal.data[index].hour,
                                  Animal.data[index].image,
                                ),
                              );
                            },
                          ),
                        ),
                        spaceH24,
                      ],
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    border: Border.all(
                      color:
                          AppTheme.getInstance().borderColor().withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageAssets.svgAssets(
                            ImageAssets.icClock,
                            color: AppTheme.getInstance().leafPrimaryColor(),
                          ),
                          spaceW8,
                          StreamBuilder<String>(
                            stream: _cubit.gioSinhSubject.stream,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? 'Giờ sinh';
                              return Text(
                                data,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: data == 'Giờ sinh'
                                      ? AppTheme.getInstance().hintTextColor()
                                      : AppTheme.getInstance().leafPrimaryColor(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: CustomPaint(
                          size: Size(10 * 0.01, 10 * 0.01),
                          painter: DropdownArrow(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              spaceH16,
              GestureDetector(
                onTap: () {
                  showBottomSheetAutoHide(
                    context,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: AppTheme.getInstance().darkRed(),
                          child: Center(
                            child: Text(
                              'CHỌN NGÀY SINH',
                              style: textNormalCustom(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.getInstance().whiteTextColor(),
                              ),
                            ),
                          ),
                        ),
                        spaceH24,
                        SizedBox(
                          height: 250,
                          child: FlutterRoundedCupertinoDatePickerWidgetAmDuong(
                            minimumYear: 1900,
                            maximumYear: 2099,
                            onDateTimeChanged: (value) {
                              date = value;
                            },
                            onChangeSolar: (date, flag) {
                              if (flag) {
                                amLich = 'on';
                              } else {
                                amLich = '';
                              }
                            },
                            textStyleDate: textNormalCustom(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.getInstance().getBlackText(),
                            ),
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 32,
                          ),
                          child: AppButton(
                            'Chọn',
                            () {
                              ngaySinh = date.day.toString();
                              thangSinh = date.month.toString();
                              namSinh = date.year.toString();
                              _cubit.ngaySinhSubject.sink
                                  .add('${date.day}/${date.month}/${date.year}');
                              Navigator.pop(context);
                            },
                            btnMargin: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    border: Border.all(
                      color:
                          AppTheme.getInstance().borderColor().withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageAssets.svgAssets(
                            ImageAssets.icBirthDay,
                            color: AppTheme.getInstance().leafPrimaryColor(),
                          ),
                          spaceW8,
                          StreamBuilder<String>(
                            stream: _cubit.ngaySinhSubject.stream,
                            builder: (context, snapshot) {
                              final data = snapshot.data ?? 'Ngày sinh';
                              return Text(
                                data,
                                style: textNormalCustom(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: data == 'Ngày sinh'
                                      ? AppTheme.getInstance().hintTextColor()
                                      : AppTheme.getInstance().leafPrimaryColor(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: CustomPaint(
                          size: Size(10 * 0.01, 10 * 0.01),
                          painter: DropdownArrow(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              spaceH16,
              NewCustomDropDown(
                selectedColor: AppTheme.getInstance().getBlackText(),
                placeHoder: 'Tài liệu tham khảo',
                initData: '',
                suffixIcon: ImageAssets.svgAssets(
                  ImageAssets.icBook,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
                useCustomHintColors: true,
                listData: listTLTK,
                onChange: (index) {
                  thamKhao = '${index + 1}';
                },
              ),
              spaceH16,
              CustomTextField(
                hintText: 'Năm xem hạn',
                textChange: (value) {
                  namXem = value;
                },
                color: AppTheme.getInstance().leafPrimaryColor(),
                textInputType: TextInputType.text,
                isShowClearText: false,
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: AppTheme.getInstance().leafPrimaryColor(),
                ),
              ),
              spaceH50,
              AppButton(
                'Xem',
                () {
                  if (gioiTinh.isNotEmpty &&
                      gioSinh.isNotEmpty &&
                      ngaySinh.isNotEmpty && namXem.isNotEmpty) {
                    Get.to(
                      LeafScreen(
                        ten: ten,
                        gioiTinh: gioiTinh,
                        ngaySinh: ngaySinh,
                        thangSinh: thangSinh,
                        namSinh: namSinh,
                        amLich: amLich,
                        gioSinh: gioSinh,
                        gioSinhStr: gioSinhStr,
                        thamKhao: thamKhao,
                        namXem: namXem,
                        cubit: _cubit,
                        add: widget.add,
                      ),
                    );
                  } else {
                    if (!Get.isSnackbarOpen) {
                      Get.snackbar(
                        '',
                        '',
                        snackPosition: SnackPosition.BOTTOM,
                        titleText: Text(
                          'CHÚ Ý',
                          style: textNormalCustom(
                            color: AppTheme.getInstance().leafPrimaryColor(),
                            fontSize: 16,
                          ),
                        ),
                        messageText: Text(
                          'Hãy nhập đủ thông tin',
                          style: textNormalCustom(
                            color: AppTheme.getInstance().leafPrimaryColor(),
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(String name, String hour, String image,
      {Function(String, String)? onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ImageAssets.svgAssets(
            image,
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
          spaceH8,
          Text(
            name,
            style: textNormalCustom(
              color: AppTheme.getInstance().getBlackText(),
              fontSize: 18,
            ),
          ),
          spaceH8,
          Text(
            hour,
            style: textNormalCustom(
              color: AppTheme.getInstance().getBlackText().withOpacity(0.5),
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
