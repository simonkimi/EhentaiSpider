import 'package:eh/parser/preview_parser.dart';
import 'package:eh/test/preview_html.dart' as html;

void main(List<String> arguments) async {
  PreviewParser(html.html).parse();
}
