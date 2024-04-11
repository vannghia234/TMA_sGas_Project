import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/config/routes/route_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_state.dart';
import 'package:sgas/src/feature/authentication/presentation/page/login_page.dart';

class AuthenticationLayer extends StatelessWidget {
  const AuthenticationLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      bloc: getIt.get<AuthenticationCubit>()..authenticate(),
      builder: (context, state) {
        if (state is UnAuthenticateState) {
          if (state.expiredToken) {
            Future.microtask(() => _showExpiredSessionDialog(context));
          }
          return const LoginPage();
        }

        if (state is AuthenticatedState) {
          // TODO: temp dashboard page
          return const Placeholder();
        }
        return const AppLoadingPage();
      },
    );
  }

  void _showExpiredSessionDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Phiên bản đã hết hạn"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.settings.name == RoutePath.root,
                );
              },
              child: const Text("Xác nhận",
                  style: TextStyle(color: BaseColor.blue500)),
            ),
          ],
        );
      },
    );
  }
}
