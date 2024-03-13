import 'package:get_it/get_it.dart';
import 'package:sgas/src/authentication/view/bloc/authentication_bloc.dart';
import 'package:sgas/src/authentication/view/bloc/change_new_password_cubit.dart';
import 'package:sgas/src/authentication/view/bloc/change_new_repassword_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> configDependencies() async {
  getIt.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc());
  getIt.registerLazySingleton<ChangeNewPasswordCubit>(
      () => ChangeNewPasswordCubit());
  getIt.registerLazySingleton<ChangeNewRePasswordCubit>(
      () => ChangeNewRePasswordCubit());
}
