import 'app_exception.dart';

class LoginErrorException extends AppException {

  LoginErrorException(String message)
      : super(
          error: 'LoginErrorException',
          message: message,
        );
}
