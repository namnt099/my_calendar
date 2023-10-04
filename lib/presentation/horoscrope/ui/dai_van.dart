import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_calendar/config/resources/styles.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/presentation/horoscrope/ui/note_popup.dart';
import 'package:my_calendar/presentation/horoscrope/ui/show_note.dart';
import 'package:my_calendar/ultis/animate/hero_dialog_route.dart';
import 'package:my_calendar/widgets/app_bar.dart';

class DaiVan extends StatefulWidget {
  const DaiVan({Key? key, this.index})
      : super(key: key);
  final int? index;

  @override
  State<DaiVan> createState() => _DaiVanState();
}

class _DaiVanState extends State<DaiVan> {
  late final List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = widget.index != null
        ? HiveLocal.getDaiVan()[widget.index!]
        : HiveLocal.getDaiVan().last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseAppBar(
            title: 'Đại Vận',
            titleColor: AppTheme.getInstance().leafPrimaryColor(),
            leading: BackLeading(
              color: AppTheme.getInstance().leafPrimaryColor(),
            ),
            backgroundColor: AppTheme.getInstance().darkRed(),
          ),
          spaceH16,
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: data.length,
              itemBuilder: (context, index) => itemGiaiDoan(data[index], index),
            ),
          )
        ],
      ),
    );
  }

  Widget itemGiaiDoan(Map<String, dynamic> item, int index) {
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
                  .then(
                    (value) => {
                      if (value != null)
                        {
                          data[index].addAll({'title6': value}),
                          HiveLocal.saveDaiVan(
                            LeafCubit.converToRaw(data),
                            index: widget.index,
                            edit: true,
                          ),
                          setState(() {})
                        }
                    },
                  );
            },
            icon: Icons.edit,
          ),
          if (item['title6'] != null) ...[
            SlidableAction(
              backgroundColor: AppTheme.getInstance().primaryColor(),
              onPressed: (context) {
                data[index].remove('title6');
                setState(() {});
              },
              icon: Icons.restore_from_trash_sharp,
            ),
            SlidableAction(
              backgroundColor: AppTheme.getInstance().accentColor(),
              onPressed: (context) {
                Navigator.of(context).push(
                  HeroDialogRoute(
                    builder: (context) {
                      return ShowNotePopup(
                        value: item['title6'],
                      );
                    },
                    isNonBackground: false,
                  ),
                );
              },
              icon: Icons.remove_red_eye_outlined,
            ),
          ],
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.getInstance().borderColor().withOpacity(0.6),
              width: 8,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (item['title0'] != 'null') ...[
                    Text(
                      item['title0'],
                      style: textNormalCustom(
                        color: AppTheme.getInstance().darkRed(),
                        fontSize: 14,
                      ),
                    ),
                    spaceH16,
                  ],
                  if (item['title1'] != 'null') ...[
                    Text(
                      item['title1'],
                      style: textNormalCustom(
                        color: AppTheme.getInstance().getBlackText(),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                  // if (item['title4'] != null) ...[
                  //   Text(
                  //     item['title4'],
                  //     style: textNormalCustom(
                  //       color: AppTheme.getInstance().getBlackText(),
                  //       fontSize: 14,
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
            if (item['title6'] != null) ...[const Icon(Icons.check)]
          ],
        ),
      ),
    );
  }
}
