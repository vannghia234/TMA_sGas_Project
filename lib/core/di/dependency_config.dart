import 'package:get_it/get_it.dart';
import 'package:sgas/src/authentication/view/bloc/change_re_password_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/forget_pass_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/login_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/change_password_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/otp_cubit.dart';
import 'package:sgas/src/authentication/view/utils/key_storage.dart';

GetIt getIt = GetIt.instance;

Future<void> configDependencies() async {
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());
  getIt.registerLazySingleton<ChangePasswordCubit>(() => ChangePasswordCubit());
  getIt.registerLazySingleton<ChangeRepasswordCubit>(
      () => ChangeRepasswordCubit());
  getIt.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit());
  getIt.registerLazySingleton<OtpCubit>(() => OtpCubit());
  getIt.registerLazySingleton<KeyStorage>(
    () => KeyStorage(),
  );
}
