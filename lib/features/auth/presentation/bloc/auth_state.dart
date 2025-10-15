import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OTPSent extends AuthState {
  final String phoneNumber;

  const OTPSent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class Authenticated extends AuthState {
  final String userId;
  final String token;

  const Authenticated(this.userId, this.token);

  @override
  List<Object?> get props => [userId, token];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class Unauthenticated extends AuthState {}



