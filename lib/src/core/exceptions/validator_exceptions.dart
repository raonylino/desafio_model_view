class ValidatorException implements Exception {
  final String message;
  final List? errors;

  ValidatorException({required this.message, this.errors});
}

class ServerException implements ValidatorException {
  @override
  final String message;

  ServerException({required this.message});

  @override
  List? get errors => null;
}
