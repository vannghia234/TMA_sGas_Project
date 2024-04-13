abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class UnAuthenticateState extends AuthenticationState {
  final bool expiredToken;
   bool isAppeared;

  UnAuthenticateState({required this.expiredToken, this.isAppeared = false});
}

class AuthenticatedState extends AuthenticationState {}
