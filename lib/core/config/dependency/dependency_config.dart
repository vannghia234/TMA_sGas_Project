import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> configureDependencies() async {
  _configureDependenciesBloc();
  _configureController();
}

Future<void> _configureDependenciesBloc() async {}

Future<void> _configureController() async {}
