
import 'package:social_task/core/exeptions/exeptions.dart';
import 'package:social_task/core/exeptions/failure.dart';
import 'package:social_task/core/utils/assets_manager.dart';

extension ExceptionHandler on Exception {
  Failure toFailure() {
    if (this is InternetConnectionException) {
      return Failure(
        image: AssetsManager.noInternet,
        message: "No internet connection. Check your connection and try again.",
      );
    }

    if (this is TimeOutException) {
      return Failure(
        image: AssetsManager.error,
        message: "Server connection timeout. Try again later.",
      );
    }

    if (this is ServerException) {
      return Failure(
        image: AssetsManager.error,
        message: "Server error occurred. Please try again later.",
      );
    }

    if (this is InvalidCredentialsException) {
      return Failure(
        image: AssetsManager.error,
        message: 'Invaild Credentials',
      );
    }

    if (this is ExceptionWithMessage) {
      final String message = (this as ExceptionWithMessage).message;

      return Failure(
        image: AssetsManager.error,
        message: message,
      );
    }

    if (this is AuthorizationException) {
      final failure = Failure(
        image: AssetsManager.error,
        message: "Access denied. Please login again.",
      );

      return failure;
    }

    if (this is ForbiddenException) {
      final failure = Failure(
        image: AssetsManager.error,
        message: "Access denied. Please login again.",
      );

      return failure;
    }

    if (this is NoDataException) {
      return Failure(image: AssetsManager.error, message: "No data available.");
    }

    return Failure(
      image: AssetsManager.error,
      message: "An unexpected error occurred. Try again.",
    );
  }
}
