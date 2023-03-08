import 'package:flutter/widgets.dart';

class EntryTag {
  final String label;
  final IconData icon;

  const EntryTag({
    required this.label,
    required this.icon,
  });

  @override
  bool operator ==(Object other) => other is EntryTag && label == other.label;

  @override
  int get hashCode => label.hashCode;
}