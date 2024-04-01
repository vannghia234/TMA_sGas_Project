import 'package:get_it/get_it.dart';
import 'package:sgas/src/authentication/presentation/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/presentation/bloc/otp_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> configDependencies() async {
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());
  getIt.registerLazySingleton<ChangePasswordCubit>(() => ChangePasswordCubit());
  getIt.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit());
  getIt.registerLazySingleton<OtpCubit>(() => OtpCubit());
}
