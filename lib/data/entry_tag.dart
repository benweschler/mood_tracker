import 'package:flutter/widgets.dart';

class EntryTag {
  final String label;
  final IconData icon;
  final Color color;

  const EntryTag({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  bool operator ==(Object other) => other is EntryTag && label == other.label;

  @override
  int get hashCode => label.hashCode;
}