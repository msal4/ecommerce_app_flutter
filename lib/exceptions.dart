abstract class AppException {
  const AppException(this.message);

  final String message;
}

class NoInternetException extends AppException {
  NoInternetException(String message) : super(message);
}

class NoServiceFoundException extends AppException {
  NoServiceFoundException(String message) : super(message);
}

class InvalidFormatException extends AppException {
  InvalidFormatException(String message) : super(message);
}

class UnknownException extends AppException {
  UnknownException(String message) : super(message);
}
