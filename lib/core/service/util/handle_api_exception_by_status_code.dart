
import 'package:sgas/core/config/dependency/dependency_config.dart';
import 'package:sgas/core/error/exception.dart';
import 'package:sgas/src/common/util/helper/logger_helper.dart';
import 'package:sgas/src/feature/authentication/domain/usecase/authenticaion_usecase.dart';
import 'package:sgas/src/feature/authentication/presentation/bloc/authentication/authentication_cubit.dart';

Future<void> handleAPIExceptionByStatusCode(
    String uri, int statusCode, String method,
    {int? codeBadRequest, String? data, bool? isAuthentication}) async {
  if (statusCode == 200) return;
  logger.f(
      "[API failure] $statusCode $method $uri badRequestCode $codeBadRequest");
  if (!isAuthentication!) {
    bool isValid = await AuthenticationUseCase().authenticate();
    if (!isValid) {
      getIt.get<AuthenticationCubit>().forceLogout();
      return;
    }
  }
  if (statusCode == 400) {
    throw BadRequestException(statusCode: codeBadRequest, data: data);
  }
  if (statusCode == 401) throw AuthorizationException();
  if (statusCode == 403) throw ForbiddenException();
  if (statusCode == 404) throw NotFoundException();
  throw ServerException();
}
