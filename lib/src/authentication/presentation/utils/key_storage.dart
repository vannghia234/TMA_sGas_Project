import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sgas/core/helper/logger_helper.dart';
import 'package:sgas/src/authentication/domain/usecases/authenticaion_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyStorage extends Cubit<LoginAuthenticationState> {
  KeyStorage() : super(InitialLogin()) {
    read();
  }

  AuthenticationUseCase useCase = AuthenticationUseCase();

  Future<void> save(
      {required String accessToken, required String refreshToken}) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", accessToken);
    await prefs.setString("refreshToken", refreshToken);
    state.accessToken = accessToken;
    state.refreshToken = refreshToken;
    emit(SuccessfulAuthentication());
  }

  Future<void> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.getString('accessToken') != null) {
        state.accessToken = prefs.getString('accessToken') ?? "";
      }
      if (prefs.getString('refreshToken') != null) {
        state.refreshToken = prefs.getString('refreshToken') ?? "";
      }
    } catch (e) {
      throw Exception(e);
    }

    logger.d("Read accessToken ${state.accessToken}");
    if (state.accessToken == "") {
      emit(FailAuthentication());
      return;
    } else {
      if (JwtDecoder.isExpired(state.accessToken)) {
        logger.d(
            "AccessToken is expired ?  ${JwtDecoder.isExpired(state.accessToken)}");
        // Map<String, dynamic> decodedToken = JwtDecoder.decode(state.accessToken);
        // logger.e("Read decoder $decodedToken");
        // DateTime expiryDateTime = DateTime.fromMillisecondsSinceEpoch(
        //     decodedToken["exp"] * 1000,
        //     isUtc: true);
        // String formattedExpiry =
        //     expiryDateTime.toString(); // Chuyển đổi thành chuỗi
        // print(formattedExpiry); // In ra thời gian hết hạn dưới dạng chuỗi

        if (JwtDecoder.isExpired(state.refreshToken)) {
          logger.d(
              "refreshToken is expired ?  ${JwtDecoder.isExpired(state.refreshToken)}");
          emit(FailAuthentication());
        } else {
          var res = await useCase.getAccesstokenFromRefreshToken(
              refreshToken: state.refreshToken);
          state.accessToken = res.data!.token!.accessToken!;
          state.refreshToken = res.data!.token!.refreshToken!;
          emit(SuccessfulAuthentication());
        }
      } else {
        emit(SuccessfulAuthentication());
        // TODO
      }
    }
  }

  Future<void> remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    emit(FailAuthentication());
  }

  void getAccessTokenFromRefreshtoken() {}
}

abstract class LoginAuthenticationState {
  String accessToken;
  String refreshToken;
  LoginAuthenticationState({this.accessToken = "", this.refreshToken = ""});
}

class InitialLogin extends LoginAuthenticationState {}

class SuccessfulAuthentication extends LoginAuthenticationState {}

class FailAuthentication extends LoginAuthenticationState {}
