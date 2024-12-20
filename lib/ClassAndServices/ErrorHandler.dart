

import 'dart:developer';

class ErrorHandler {


  void logSuccessOrError({
    required bool success,
    required String text,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (success) {
      log('Success: $text');
    } else {
      log('Error: $text');
    }

    if (error != null) {
      log('Error details: $error');
    }

    if (stackTrace != null) {
      log('Stack trace: $stackTrace');
    }
  }


}


class ReturnHandler{
final String text;
final bool success;

ReturnHandler({
  required this.text,
  required this.success,
});

}
