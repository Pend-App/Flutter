import 'dart:io';

class walletException extends HttpException {
  final String message;

  walletException(this.message) : super(message);

  String toString() {
    return message;
  }
}