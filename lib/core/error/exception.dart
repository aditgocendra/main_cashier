class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error fetch data from database drift');
}

class InsertDataException extends AppException {
  InsertDataException([String? message])
      : super(message, 'Error insert data to database drift, ');
}
