import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:webview_flutter/webview_flutter.dart' as webview;

import '../../html_parser.dart';
import '../../style.dart';
import '../navigation_delegate.dart';
import '../replaced_element.dart';

/// [IframeContentElement is a [ReplacedElement] with web content.
class IframeContentElement extends ReplacedElement {
  final String? src;
  final double? width;
  final double? height;
  final NavigationDelegate? navigationDelegate;
  final UniqueKey key = UniqueKey();

  IframeContentElement({
    required String name,
    required this.src,
    required this.width,
    required this.height,
    required dom.Element node,
    required this.navigationDelegate,
  }) : super(name: name, style: Style(), node: node, elementId: node.id);

  @override
  Widget toWidget(RenderContext context) {
    final sandboxMode = attributes["sandbox"];
    return Container(
      width: width ?? (height ?? 150) * 2,
      height: height ?? (width ?? 300) / 2,
      child: ContainerSpan(
        style: context.style,
        newContext: context,
        child: webview.WebView(
          initialUrl: src,
          key: key,
          javascriptMode: sandboxMode == null || sandboxMode == "allow-scripts"
              ? webview.JavascriptMode.unrestricted
              : webview.JavascriptMode.disabled,
          navigationDelegate: (request) async {
            final result = await navigationDelegate!(NavigationRequest(
              url: request.url,
              isForMainFrame: request.isForMainFrame,
            ));
            if (result == NavigationDecision.prevent) {
              return webview.NavigationDecision.prevent;
            } else {
              return webview.NavigationDecision.navigate;
            }
          },
          gestureRecognizers: {
            Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())
          },
        ),
      ),
    );
  }
}
