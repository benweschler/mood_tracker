class Logger {
  static const List<String> _log = <String>[];

  const Logger._();

  static void add(String entry) => _log.add(entry);

  static List<String> get dump => List.from(_log);
}
