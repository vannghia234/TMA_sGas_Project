import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_state.dart';

class AuthenticationLayer extends StatelessWidget {
  const AuthenticationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      bloc: getIt.get<AuthenticationCubit>()..authenticate(),
      builder: (context, state) {
        if (state is UnAuthenticateState) {
          return Scaffold(
            backgroundColor: Colors.white54,
            body: CupertinoAlertDialog(
                title: const Text("Phiên bản đăng nhập đã hết hạn"),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(RoutePath.login);
                      },
                      child: const Text("Xác nhận",
                          style: TextStyle(color: BaseColor.primaryColor)))
                ]),
          );
        }

        if (state is AuthenticatedState) {
          // TODO: temp dashboard page
          return const Placeholder();
        }
        return const AppLoadingPage();
      },
    );
  }
}
