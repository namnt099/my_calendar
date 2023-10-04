import 'package:flutter/material.dart';
import 'package:my_calendar/widgets/html/flutter_html.dart';
import 'package:my_calendar/widgets/html/html_parser.dart';
import 'package:my_calendar/widgets/html/src/layout_element.dart';
import 'package:my_calendar/widgets/html/style.dart';


class HTMLView extends StatelessWidget {
  final String htmlContent;

  const HTMLView({Key? key, required this.htmlContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlContent,
      tagsList: Html.tags..addAll(['flutter']),
      style: {
        'table': Style(
          backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
        ),
        'tr': Style(
          border: const Border(bottom: BorderSide(color: Colors.grey)),
        ),
        'th': Style(
          padding: const EdgeInsets.all(6),
          backgroundColor: Colors.grey,
        ),
        'td': Style(
          padding: const EdgeInsets.all(6),
          alignment: Alignment.topLeft,
        ),
        'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
      },
      customRender: {
        'table': (context, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: (context.tree as TableLayoutElement).toWidget(context),
          );
        },
        'flutter': (RenderContext context, Widget child) {
          return FlutterLogo(
            style: (context.tree.element!.attributes['horizontal'] != null)
                ? FlutterLogoStyle.horizontal
                : FlutterLogoStyle.markOnly,
            textColor: context.style.color!,
            size: context.style.fontSize!.size! * 5,
          );
        },
      },
      onLinkTap: (url, _, __, ___) {
        print('Opening $url...');
      },
      onImageTap: (src, _, __, ___) {
        print(src);
      },
      onImageError: (exception, stackTrace) {
        print(exception);
      },
      onCssParseError: (css, messages) {
        print('css that errored: $css');
        print('error messages:');
        messages.forEach((element) {
          print(element);
        });
      },
    );
  }
}
