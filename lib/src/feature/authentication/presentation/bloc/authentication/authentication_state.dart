abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class UnAuthenticateState extends AuthenticationState {
  final bool expiredToken;

  UnAuthenticateState({required this.expiredToken});
}

class AuthenticatedState extends AuthenticationState {}
