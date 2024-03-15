class ChangePasswordEntity {
  final String token;
  final String username;
  final String newPassword;

  ChangePasswordEntity(
      {required this.token, required this.username, required this.newPassword});
}
