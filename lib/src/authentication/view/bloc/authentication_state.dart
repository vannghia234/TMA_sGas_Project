part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationProcess extends AuthenticationState {}

class AuthenticationSuccessfull extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed({required this.message});

  @override
  List<Object> get props => [message];
}
