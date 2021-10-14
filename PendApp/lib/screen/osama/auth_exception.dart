import 'dart:io';

class authException extends HttpException {
  final String message;

  authException(this.message) : super(message);

  String toString() {
    return message;
  }
}