abstract class LoginFailure {}

class InCorrectUserNamePasswordFailure extends LoginFailure {}

class AccountHaveBeenBlockedFailure extends LoginFailure {}

class CompanyAccountFailure extends LoginFailure {}

class ServerFailure extends LoginFailure {}

