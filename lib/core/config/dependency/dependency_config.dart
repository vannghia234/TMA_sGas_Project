import 'package:get_it/get_it.dart';
import 'package:sgas/src/base/initial_layer/presentation/bloc/language_cubit.dart';
import 'package:sgas/src/base/validation_layer/presentation/bloc/validation_cubit.dart';

final getIt = GetIt.instance;
Future<void> configureDependencies() async {
  _configureDependenciesBloc();
  _configureController();
}

Future<void> _configureDependenciesBloc() async {
  getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  getIt.registerLazySingleton<ValidationCubit>(() => ValidationCubit());
}

Future<void> _configureController() async {}
