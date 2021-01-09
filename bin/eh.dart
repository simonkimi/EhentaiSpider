import 'package:eh/parser/gallery_parser.dart';
import 'package:eh/test/gallery_html.dart' as html;

void main(List<String> arguments) async {
  GalleryParser(html.html).parse();
}
