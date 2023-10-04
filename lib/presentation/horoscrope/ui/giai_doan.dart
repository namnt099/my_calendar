import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/presentation/horoscrope/ui/note_popup.dart';
import 'package:my_calendar/ultis/animate/hero_dialog_route.dart';
import 'package:my_calendar/widgets/app_bar.dart';

class GiaiDoan extends StatelessWidget {
  const GiaiDoan({Key? key, required this.data, this.indexGD})
      : super(key: key);
  final List<Map<String, dynamic>> data;
  final int? indexGD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseAppBar(
            title: 'Giải đoán',
            titleColor: AppTheme.getInstance().leafPrimaryColor(),
            leading: BackLeading(
              color: AppTheme.getInstance().leafPrimaryColor(),
            ),
            backgroundColor: AppTheme.getInstance().darkRed(),
          ),
          spaceH16,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              data.first['title0'],
              style: textNormalCustom(
                color: AppTheme.getInstance().darkRed(),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          spaceH16,
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: data.length,
              itemBuilder: (context, index) => itemGiaiDoan(data[index]),
            ),
          )
        ],
      ),
    );
  }

  Widget itemGiaiDoan(Map<String, dynamic> item) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: AppTheme.getInstance().darkRed(),
            onPressed: (context) {
              Navigator.of(context)
                  .push(
                    HeroDialogRoute(
                      builder: (context) {
                        return const NotePopup();
                      },
                      isNonBackground: false,
                    ),
                  )
                  .then((value) => {if (value != null) {}});
            },
            icon: Icons.edit,
          ),
          SlidableAction(
            backgroundColor: AppTheme.getInstance().primaryColor(),
            onPressed: (context) {},
            icon: Icons.restore_from_trash_sharp,
          ),
          SlidableAction(
            backgroundColor: AppTheme.getInstance().accentColor(),
            onPressed: (context) {},
            icon: Icons.remove_red_eye_outlined,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.getInstance().borderColor().withOpacity(0.6),
              width: 8,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item['title1'] != 'null') ...[
              Text(
                item['title1'],
                style: textNormalCustom(
                  color: AppTheme.getInstance().getBlackText(),
                  fontSize: 14,
                ),
              ),
              spaceH16,
            ],
            if (item['title2'] != 'null') ...[
              Text(
                item['title2'],
                style: textNormalCustom(
                  color: AppTheme.getInstance().getBlackText(),
                  fontSize: 14,
                ),
              ),
              spaceH16,
            ],
            if (item['title3'] != 'null') ...[
              Text(
                item['title3'],
                style: textNormalCustom(
                  color: AppTheme.getInstance().getBlackText(),
                  fontSize: 14,
                ),
              ),
              spaceH16,
            ],
            if (item['title4'] != null) ...[
              Text(
                item['title4'],
                style: textNormalCustom(
                  color: AppTheme.getInstance().getBlackText(),
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
