import 'package:html/parser.dart';

extension StringPhone on String {
  String format84() {
    return '+84$this';
  }

  String? youtubeURL() {
    final regExp = RegExp(
      r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    return regExp.firstMatch(this)?.group(1);
  }

  String parseHtml() {
    final document = parse(this);
    final String parsedString =
        parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }

  String splitStr() {
    String temp = '';
    if (contains(' ')) {
      temp = split(' ').first;
    } else {
      temp = this;
    }
    return temp;
  }


}
