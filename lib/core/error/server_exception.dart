class ServerException implements Exception {
  final String message;
  final StackTrace? trace;

  const ServerException({required this.message, required this.trace});

  String getLog() => '$message \nStack -> $trace';
}
