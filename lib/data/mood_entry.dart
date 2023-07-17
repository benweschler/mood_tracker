import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'mood_entry.g.dart';

@HiveType(typeId: 1)
//TODO: freeze
class MoodEntry with EquatableMixin {
  @HiveField(0)
  final int mood;

  @HiveField(1)
  final Duration sleep;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime timestamp;

  const MoodEntry({
    required this.mood,
    required this.sleep,
    required this.description,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [mood, sleep, description, timestamp];
}
