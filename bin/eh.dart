import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:eh/parser/preview_parser.dart';
import 'package:eh/url.dart';
import 'package:eh/test/preview_html.dart' as preview_html;

void main(List<String> arguments) async {
  var dio = Dio()
  ..options.baseUrl=EhUrl.HOST_E
  ..options.connectTimeout=10*1000
  ..options.headers={
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2',
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0'
  };

  (dio.httpClientAdapter as DefaultHttpClientAdapter)
      .onHttpClientCreate = (client) {
    client.findProxy = (url) => 'PROXY 127.0.0.1:4780';
  };

  var previewList = PreviewParser(preview_html.html).parse();

}
