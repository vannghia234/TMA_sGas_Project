import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/generated/l10n.dart';
import 'package:sgas/src/common/presentation/page/app_loading_page.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_state.dart';
import 'package:sgas/src/feature/authentication/presentation/page/home_page.dart';
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
            if (!state.isAppeared) {
              state.isAppeared = true;
              Future.microtask(() => _showExpiredSessionDialog(context));
            }
          }
          return const LoginPage();
        }

        if (state is AuthenticatedState) {
          return const HomePage();
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
          title: Text(S.current.txt_expired_version),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.current.txt_confirm,
                  style: const TextStyle(color: BaseColor.blue500)),
            ),
          ],
        );
      },
    );
  }
}
