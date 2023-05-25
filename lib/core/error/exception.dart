class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class DatabaseDriftException extends AppException {
  DatabaseDriftException([String? message])
      : super(message, 'Error from database, ');
}
