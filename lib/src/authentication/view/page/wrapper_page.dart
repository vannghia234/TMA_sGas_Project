import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgas/src/authentication/view/page/authentication_page.dart';
import 'package:sgas/src/authentication/view/page/home_page.dart';
import 'package:sgas/src/authentication/view/utils/key_storage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyStorage, LoginAuthenticationState>(
      builder: (context, state) {
        return (state is SuccessfulAuthentication)
            ? const HomePage()
            : (state is FailAuthentication)
                ? const AuthenticationPage()
                : const Center(
                    child: Text("Error Wrapper"),
                  );
      },
    );
  }
}
