import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunar_calendar_converter_new/lunar_solar_converter.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/images.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/model/weather/weather.dart';
import 'package:my_calendar/presentation/month/month_screen.dart';
import 'package:my_calendar/ultis/utils.dart';
import 'package:my_calendar/widgets/calendar_view/bloc/lichh_am_duong_cubit.dart';
import 'package:my_calendar/widgets/table_calendar/table_calendar_widget.dart';

class LichAmDuongMobile extends StatefulWidget {
  const LichAmDuongMobile({Key? key}) : super(key: key);

  @override
  _LichAmDuongMobileState createState() => _LichAmDuongMobileState();
}

class _LichAmDuongMobileState extends State<LichAmDuongMobile> {
  late LichAmDuongCubit cubit;
  bool isCheckOnTap = true;
  DateTime dateTime = DateTime.now();
  late Lunar lunar;

  @override
  void initState() {
    super.initState();
    cubit = LichAmDuongCubit();
    cubit.getWeather();
    lunar = LunarSolarConverter.solarToLunar(
      Solar(
        solarYear: dateTime.year,
        solarDay: dateTime.day,
        solarMonth: dateTime.month,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().backgroundPrimary(),
      body: Column(
        children: [
          AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppTheme.getInstance().backgroundPrimary(),
            title: StreamBuilder<DateTime>(
              stream: cubit.changeDateTimeSubject.stream,
              builder: (context, snapshot) {
                return Text(
                  DateFormat('EEEE, dd-MM-yyyy')
                      .format(snapshot.data ?? DateTime.now()),
                  textAlign: TextAlign.center,
                  style: textNormalCustom(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MonthScreen(cubit: cubit),
                      ),
                    );
                  },
                  child: Text(
                    'Tháng',
                    style: textNormalCustom(
                      color: AppTheme.getInstance().primaryColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder<DateTime>(
                    stream: cubit.changeDateTimeSubject.stream,
                    builder: (context, snapshot) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TableCalendarWidget(
                          isCheckLunar: true,
                          verticalSwipe: false,
                          isFormatMonth: isCheckOnTap,
                          onChange: (DateTime start, DateTime end, selectDay) {
                            cubit.startDate = start.formatApiDDMMYYYY;
                            cubit.selectTime = selectDay;
                          },
                          onChangeRange: (
                            DateTime? start,
                            DateTime? end,
                            DateTime? focusedDay,
                          ) {},
                          onPageChange: (DateTime focusedDay) {
                            cubit.changeDateTimeSubject.sink.add(focusedDay);
                          },
                          initDateTime: snapshot.data ?? DateTime.now(),
                          selectDay: (day) => cubit.selectDay(day),
                          cubit: cubit,
                        ),
                      );
                    },
                  ),
                  spaceH16,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(5, 6),
                          blurRadius: 27,
                          color: Color.fromRGBO(74, 74, 74, 1),
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://source.unsplash.com/400x300/?lettuce-${Random().nextInt(100)}',
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: AppTheme.getInstance().primaryColor(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE')
                              .format(DateTime.now())
                              .toUpperCase(),
                          style: textNormalCustom(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            shadows: [
                              const BoxShadow(
                                offset: Offset(-3, 10),
                                spreadRadius: 31,
                                blurRadius: 48,
                              )
                            ],
                          ),
                        ),
                        Text(
                          DateFormat('dd MMMM')
                              .format(DateTime.now())
                              .toUpperCase(),
                          style: textNormalCustom(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        ///Todo
                        Text(
                          '${lunar.lunarDay} Tháng ${lunar.lunarMonth}, ${CanChi.namCanChi(dateTime.year)}',
                          style: textNormalCustom(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              const BoxShadow(
                                offset: Offset(-3, 10),
                                spreadRadius: 31,
                                blurRadius: 48,
                              )
                            ],
                          ),
                        ),
                        spaceH50,
                        spaceH50,
                        Text(
                          'Giờ ${CanChi.canChiGio(dateTime.hour, dateTime.day, dateTime.month, dateTime.year)} '
                          '| N. ${CanChi.canChiNgay(dateTime.day, dateTime.month, dateTime.year)} | T. ${CanChi.layCanChiThang(
                            LunarSolarConverter.solarToLunar(
                              Solar(
                                solarYear: dateTime.year,
                                solarMonth: dateTime.month,
                                solarDay: dateTime.day,
                              ),
                            ).lunarMonth ??
                                -1,
                            dateTime.year,
                          )}',
                          style: textNormalCustom(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            shadows: [
                              const BoxShadow(
                                offset: Offset(-3, 10),
                                spreadRadius: 31,
                                blurRadius: 48,
                              )
                            ],
                          ),
                        ),
                        spaceH8,

                      ],
                    ),
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Đổi ngày',
                          style: textNormalCustom(
                            color: AppTheme.getInstance().primaryColor(),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Tạo sự kiện',
                          style: textNormalCustom(
                            color: AppTheme.getInstance().primaryColor(),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Xem ngày tốt',
                          style: textNormalCustom(
                            color: AppTheme.getInstance().primaryColor(),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tử vi bói toán',
                          style: textNormalCustom(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Xem thêm',
                          style: textNormalCustom(
                            color: AppTheme.getInstance()
                                .backgroundPrimary()
                                .withOpacity(
                                  0.14,
                                ),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  spaceH16,
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cubit.list.length,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 70,
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                (index == 0 || index == cubit.list.length - 1)
                                    ? 16
                                    : 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: ImageAssets.svgAssets(
                                  cubit.list[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              spaceH8,
                              Expanded(
                                child: Text(
                                  cubit.list[index].title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: textNormal(
                                    Colors.black,
                                    14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  StreamBuilder<ParentWeather>(
                    stream: cubit.weatherStream,
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      return snapshot.data != null
                          ? Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              clipBehavior: Clip.hardEdge,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(5, 6),
                                    blurRadius: 27,
                                    color: Color.fromRGBO(74, 74, 74, 1),
                                  )
                                ],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    '$baseImg/${data?.weathers.first.icon}big.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hà Nội',
                                    style: textNormalCustom(
                                      color:
                                          AppTheme.getInstance().primaryColor(),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        const BoxShadow(
                                          offset: Offset(-3, 10),
                                          spreadRadius: 31,
                                          blurRadius: 48,
                                        )
                                      ],
                                    ),
                                  ),
                                  spaceH16,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: AppTheme.getInstance()
                                              .backgroundPrimary(),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          '$baseImg/${data?.weathers.first.icon}.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) {
                                            return Container(
                                              height: 50,
                                              width: 50,
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: AppTheme.getInstance()
                                                    .primaryColor(),
                                                shape: BoxShape.circle,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      spaceW8,
                                      SizedBox(
                                        height: 50,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${data?.main.temp} * C',
                                              style: textNormalCustom(
                                                color: AppTheme.getInstance()
                                                    .primaryColor(),
                                                fontSize: 18,
                                                shadows: [
                                                  const BoxShadow(
                                                    offset: Offset(-3, 10),
                                                    spreadRadius: 31,
                                                    blurRadius: 48,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '${data?.weathers.first.description.toUpperCase()}',
                                              style: textNormalCustom(
                                                color: AppTheme.getInstance()
                                                    .primaryColor(),
                                                shadows: [
                                                  const BoxShadow(
                                                    offset: Offset(-3, 10),
                                                    spreadRadius: 31,
                                                    blurRadius: 48,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  spaceH16,
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Độ ẩm',
                                            style: textNormalCustom(
                                              color: AppTheme.getInstance()
                                                  .primaryColor(),
                                              fontSize: 16,
                                              shadows: [
                                                const BoxShadow(
                                                  offset: Offset(-3, 10),
                                                  spreadRadius: 31,
                                                  blurRadius: 48,
                                                )
                                              ],
                                            ),
                                          ),
                                          spaceH4,
                                          Text(
                                            '${data?.main.humidity} %',
                                            style: textNormalCustom(
                                              color: AppTheme.getInstance()
                                                  .primaryColor(),
                                              fontSize: 16,
                                              shadows: [
                                                const BoxShadow(
                                                  offset: Offset(-3, 10),
                                                  spreadRadius: 31,
                                                  blurRadius: 48,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceW16,
                                      Column(
                                        children: [
                                          Text(
                                            'Tốc độ gió',
                                            style: textNormal(
                                              AppTheme.getInstance()
                                                  .primaryColor(),
                                              16,
                                            ),
                                          ),
                                          spaceH4,
                                          Text(
                                            '${data?.wind.speed} km/h',
                                            style: textNormalCustom(
                                              color: AppTheme.getInstance()
                                                  .primaryColor(),
                                              fontSize: 16,
                                              shadows: [
                                                const BoxShadow(
                                                  offset: Offset(-3, 10),
                                                  spreadRadius: 31,
                                                  blurRadius: 48,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  spaceH16,
                                  Text(
                                    'Tầm nhìn xa: ${(data?.visibility ?? 0) / 1000} km',
                                    style: textNormalCustom(
                                      color:
                                          AppTheme.getInstance().primaryColor(),
                                      fontSize: 14,
                                      shadows: [
                                        const BoxShadow(
                                          offset: Offset(-3, 10),
                                          spreadRadius: 31,
                                          blurRadius: 48,
                                        )
                                      ],
                                    ),
                                  ),
                                  spaceH4,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mặt trời mọc ${DateFormat('hh:mm aa').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            (data?.sys.sunrise.toInt() ?? 0) *
                                                1000,
                                          ),
                                        )}',
                                        style: textNormalCustom(
                                          color: AppTheme.getInstance()
                                              .primaryColor(),
                                          shadows: [
                                            const BoxShadow(
                                              offset: Offset(-3, 10),
                                              spreadRadius: 31,
                                              blurRadius: 48,
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Mặt trời lặn ${DateFormat('hh:mm aa').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            (data?.sys.sunset.toInt() ?? 0) *
                                                1000,
                                          ),
                                        )}',
                                        style: textNormalCustom(
                                          color: AppTheme.getInstance()
                                              .primaryColor(),
                                          shadows: [
                                            const BoxShadow(
                                              offset: Offset(-3, 10),
                                              spreadRadius: 31,
                                              blurRadius: 48,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  spaceH16,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
