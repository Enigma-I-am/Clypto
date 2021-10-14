import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String message;

  // If a cache error happens we'll need to publish a new version of the app
  // to fix it. This is why we ask the user to update his/her app
  CustomException([
    this.message = 'Ops, we are sorry. Please, try to update your app...',
  ]);

  @override
  List<Object> get props => [message];
}
