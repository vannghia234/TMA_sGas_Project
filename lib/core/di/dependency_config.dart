import 'package:get_it/get_it.dart';
import 'package:sgas/src/authentication/view/bloc/authentication_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> configDependencies() async {
  getIt.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc());
}
