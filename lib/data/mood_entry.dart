import 'package:equatable/equatable.dart';

class MoodEntry with EquatableMixin {
  final int mood;
  final Duration sleep;
  final String description;
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
