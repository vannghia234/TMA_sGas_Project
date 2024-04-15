// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sgas/core/error/failure.dart';

abstract class LoginFailure extends Failure {}

class InCorrectUserNamePasswordFailure extends LoginFailure {}

class AccountHaveBeenBlockedFailure extends LoginFailure {}

class CompanyAccountHaveBeenBlockedFailure extends LoginFailure {}

abstract class ForgetPasswordFailure extends Failure {}

class OverRequestForgetPasswordFailure extends ForgetPasswordFailure {}

class NotExistPhoneFailure extends ForgetPasswordFailure {}

abstract class OTPFailure extends Failure {}

class TimeOutOTPFailure extends OTPFailure {}

class IncorrectOTPFailure extends OTPFailure {}
