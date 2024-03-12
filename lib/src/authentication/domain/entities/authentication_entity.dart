import 'package:equatable/equatable.dart';

class AuthenticationEntity extends Equatable {
  final String email;
  final String password;

  const AuthenticationEntity({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
