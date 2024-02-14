abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class ServerException implements Exception {}

class WrongPasswordExeption implements Exception {}

class UserNotFundExeption implements Exception {}
