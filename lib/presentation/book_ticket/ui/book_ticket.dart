import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/resources/styles.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({Key? key}) : super(key: key);

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageAssets.header,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 280,
                ),
              ],
            ),
            Positioned(
              top: 52,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageAssets.svgAssets(ImageAssets.icPro),
                            spaceW48,
                          ],
                        ),
                        const Text('Bến xe Mỹ Đình'),
                        Row(
                          children: [
                            ImageAssets.svgAssets(ImageAssets.icSearch),
                            spaceW28,
                            ImageAssets.svgAssets(ImageAssets.icNoti),
                          ],
                        )
                      ],
                    ),
                  ),
                  spaceH18,
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xffF5F5F5),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text('Ngày xuất bến'),
                              spaceH8,
                              Text('06.02.2023')
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text('Tuyến đường'),
                            spaceH8,
                            Text('Chọn tuyến'),
                          ],
                        ),
                        ImageAssets.svgAssets(ImageAssets.icAdd),
                      ],
                    ),
                  ),
                  spaceH18,
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 16, left: 24, right: 24),
                      decoration: const BoxDecoration(
                        color: Color(0xffFAFAFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Text('Giờ xuất bến:'),
                                spaceW4,
                                Text('Tất cả'),
                                Icon(Icons.arrow_drop_down_sharp)
                              ]),
                              Text('0 chuyến'),
                            ],
                          ),
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   itemBuilder: (context, index) => Container(
                          //     height: 24,
                          //     color: Colors.black,
                          //     margin: const EdgeInsets.symmetric(vertical: 10),
                          //   ),
                          //   itemCount: 20,
                          // ),
                          emptyData()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyData() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.empty),
          spaceH40,
          Text('Vui lòng chọn tuyến/ chặng để\n hiển thị danh sách chuyến xe!')
        ],
      ),
    );
  }
}
