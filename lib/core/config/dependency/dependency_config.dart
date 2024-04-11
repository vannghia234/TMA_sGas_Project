import 'package:get_it/get_it.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/change_password_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/forget_pass_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/forget_password/otp_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/login/login_cubit.dart';
import 'package:sgas/src/base/initial_layer/presentation/bloc/language_cubit.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';
import 'package:sgas/src/common/utils/controller/loading_controller.dart';

final getIt = GetIt.instance;
Future<void> configureDependencies() async {
  _configureDependenciesBloc();
  _configureController();
}

Future<void> _configureDependenciesBloc() async {
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit());
  getIt.registerLazySingleton<ChangePasswordCubit>(() => ChangePasswordCubit());
  getIt.registerLazySingleton<ForgetPasswordCubit>(() => ForgetPasswordCubit());
  getIt.registerLazySingleton<OtpCubit>(() => OtpCubit());
  getIt.registerLazySingleton<AuthenticationCubit>(() => AuthenticationCubit());
  getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  getIt.registerSingleton<ValidationCubit>(ValidationCubit());
}

Future<void> _configureController() async {
  getIt.registerLazySingleton<LoadingController>(() => LoadingController());
}
