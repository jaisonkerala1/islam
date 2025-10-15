import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class SendOTP extends AuthEvent {
  final String phoneNumber;

  const SendOTP(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOTP extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const VerifyOTP(this.phoneNumber, this.otp);

  @override
  List<Object?> get props => [phoneNumber, otp];
}

class SignOut extends AuthEvent {}



