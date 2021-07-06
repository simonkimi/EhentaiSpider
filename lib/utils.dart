import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;

final startDate = DateTime.now();

void printTimeLine([String? tag]) {
  final thisTime = DateTime.now();
  print('${tag ?? 'TimeLine'}: ${thisTime.difference(startDate).toString()}');
}

extension IterableUtils<T> on Iterable<T> {
  T? get(bool test(T e)) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}

extension ListHelper<T> on List<T> {
  T random() {
    return this[Random().nextInt(length)];
  }

  List<T> addAsSet(Iterable<T> other) {
    addAll(other.where((e) => !contains(e)));
    return this;
  }

  T lastAt(int index) {
    return this[length - index];
  }
}

extension StringHelper on String {
  String getHost() {
    final items = split('/')
        .where((e) => e != 'http:' && e != 'https:')
        .where((e) => e.isNotEmpty)
        .toList();
    return items.isNotEmpty ? items[0] : '';
  }

  int toInt() => int.tryParse(this) ?? 0;

  String get host {
    return split('.').reversed.take(2).toList().reversed.join('.');
  }
}

extension MapHelper<K, V> on Map<K, V> {
  Map<K, V> get trim {
    return Map.fromEntries(
        entries.where((element) => element.value.toString().isNotEmpty));
  }
}

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class FFConvert {
  FFConvert._();

  static T? Function<T extends Object?>(dynamic value) convert =
      <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

class Log {
  static void i([
    dynamic p1,
    dynamic p2,
    dynamic p3,
    dynamic p4,
    dynamic p5,
    dynamic p6,
    dynamic p7,
    dynamic p8,
    dynamic p9,
  ]) {
    print([p1, p2, p3, p4, p5, p6, p7, p8, p9]
        .where((e) => e != null)
        .map((e) => e.toString())
        .join(' '));
  }
}

extension NumHelper on num {
  bool equalBetween(num min, num max) {
    return min <= this && this <= max;
  }
}

extension IntHelper on int {
  Duration get seconds => Duration(seconds: this);

  Duration get hours => Duration(hours: this);

  Duration get microseconds => Duration(microseconds: this);

  Duration get milliseconds => Duration(milliseconds: this);

  Duration get minutes => Duration(minutes: this);
}

extension DurationHelper on Duration {
  Future<void> get delay => Future.delayed(this);
}
