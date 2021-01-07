import 'package:eh/models/preview_model.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;

class PreviewParser {
  final String previewHtml;

  PreviewParser(this.previewHtml);

  List<PreViewModel> parse() {
    var document = parser.parse(previewHtml);

    var previewList = document.querySelectorAll('.itg > tbody > tr')
        .where((element) => element.querySelector('.gl1c') != null).toList();

    return previewList.map((element) {
      var title = element
          .querySelector('.glink')
          ?.text ?? 'Error';
      var uploader = element
          .querySelector('.gl4c :first-child')
          ?.text ?? 'Error';
      var pages = parsePages(element);
      var stars = parseStar(element);
      var tag = element.querySelector('.gl1c')?.text ?? '';
      var uploadTime = element.querySelector('.glnew')?.text ?? '';

      var targetUrl = element.querySelector('.gl3c a')?.attributes['href'] ?? '';

      var previewImg = element.querySelector('.glthumb img')?.attributes['src'] ?? '';

      return PreViewModel(
        pages: pages,
        previewImg: previewImg,
        stars: stars,
        tag: tag,
        targetUrl: targetUrl,
        title: title,
        uploader: uploader,
        uploadTime: uploadTime
      );

    }).toList();
  }

  int parsePages(Element e) {
    var pageElement = e.querySelectorAll('.gl4c div');
    if (pageElement.length == 2) {
      return int.parse(pageElement[1].text.split(' ')[0]);
    }
    return 0;
  }

  int parseStar(Element e) {
    var starElement = e.querySelector('.ir');
    if (starElement != null) {
      var re = RegExp(r'\d+(?=px)');
      var style = starElement.attributes['style'];
      var starData = re.allMatches(style).map((e) => style.substring(e.start, e.end)).toList();
      var star = 10;
      var num1 = int.parse(starData[0]);
      var num2 = int.parse(starData[1]);
      star -= num1 ~/ 16 * 2;
      if (num2 >10) {
        star -= 1;
      }
      return star;
    }
    return 0;
  }
}