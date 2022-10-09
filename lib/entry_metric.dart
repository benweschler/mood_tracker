import 'package:flutter/widgets.dart';

class EntryMetric {
  final EntryValue? value;
  final Tag? tag;
  final String? description;

  const EntryMetric({this.value, this.tag, this.description});
}

class Tag {
  final IconData? icon;
  final String name;

  const Tag(this.name, {this.icon});
}

class EntryValue {
  final num value;
  final num max;
  final num min;
  final bool greaterIsGood;

  const EntryValue({
    required this.value,
    required this.max,
    required this.min,
    required this.greaterIsGood,
  });
}
