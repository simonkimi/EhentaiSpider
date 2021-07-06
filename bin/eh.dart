import 'dart:async';

import 'package:eh/utils.dart';

void main(List<String> arguments) async {
  final stream = StreamController<int>();
  stream.stream.listen(print);

  stream.add(1);
  await 1.seconds.delay;
  stream.add(2);
  await 1.seconds.delay;
  stream.add(3);
  await 1.seconds.delay;
}


